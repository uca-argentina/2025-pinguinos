"
Circular board class for board game; has a number of rounds to play in the same board.
"
Class {
	#name : 'CircularBoard',
	#superclass : 'Board',
	#instVars : [
		'rounds',
		'parsecBoardSize',
		'parsecRatio'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
CircularBoard class >> validateRoundNumberIsPositive: aRoundNumber [

	aRoundNumber < 1 ifTrue: [
		Error signal: 'Round number for the board must be positive.' ]
]

{ #category : 'creation' }
CircularBoard class >> withRandomSpecialSquaresAndSize: aSize rounds: aRoundNumber [

	self validateRoundNumberIsPositive: aRoundNumber.
	Board validateSizeIsPositive: aSize.


	^ (self withSize: aSize rounds: aRoundNumber)
		  initializeRandomSpecialSquares
]

{ #category : 'creation' }
CircularBoard class >> withSize: aSize rounds: aRoundNumber [

	self validateRoundNumberIsPositive: aRoundNumber.
	Board validateSizeIsPositive: aSize.
	^ self new initializeWithSize: aSize rounds: aRoundNumber
]

{ #category : 'creation' }
CircularBoard class >> withSize: aSize rounds: aRoundNumber withSpecialSquaresAt: squarePositions [

	self validateRoundNumberIsPositive: aRoundNumber.
	Board validateSizeIsPositive: aSize.


	^ (self withSize: aSize rounds: aRoundNumber)
		  initializeWithSpecialSquaresAt: squarePositions
]

{ #category : 'creation' }
CircularBoard class >> withSize: aSize rounds: aRoundNumber withWormHoleFrom: wormHoleOrigin to: wormHoleEnd [

	self validateRoundNumberIsPositive: aRoundNumber.
	Board validateSizeIsPositive: aSize.

	self is: wormHoleOrigin and: wormHoleEnd withinBoundsOf: aSize.
	self areEnds: wormHoleOrigin and: wormHoleEnd inGoal: aSize.

	^ (self withSize: aSize rounds: aRoundNumber)
		  initializeWithWormHoleFrom: wormHoleOrigin
		  to: wormHoleEnd
]

{ #category : 'accessing' }
CircularBoard >> createAtomicBombsAt: squarePositions [

	squarePositions do: [ :position |
		map at: position put: (AtomicBomb at: position) ]
]

{ #category : 'accessing' }
CircularBoard >> createBlackHolesAt: aSquarePositions [

	aSquarePositions do: [ :position |
		map at: position put: (Blackhole at: position in: self) ]
]

{ #category : 'accessing' }
CircularBoard >> createHyperJumpsAt: aSquarePositions [

	aSquarePositions do: [ :position |
		map
			at: position
			put: (HyperJump inBoardOfSize: parsecBoardSize at: position) ]
]

{ #category : 'accessing' }
CircularBoard >> createHyperSpaceJumpsAt: aSquarePositions [

	aSquarePositions do: [ :position |
		map at: position put: (HyperSpaceJump at: position in: self) ]
]

{ #category : 'accessing' }
CircularBoard >> createMoonWalksAt: squarePositions [

	squarePositions do: [ :position |
		map at: position put: (MoonWalk by: 3 at: position) ]
]

{ #category : 'getter' }
CircularBoard >> getParsecRatio [

	^ parsecRatio
]

{ #category : 'initialization' }
CircularBoard >> initializeRandomSpecialSquares [

	| blackHoles hyperSpaceJumps moonWalks hyperJumps atomicBombs resultForEachCell |
	
	blackHoles := OrderedCollection new.
	hyperSpaceJumps := OrderedCollection new.
	moonWalks := OrderedCollection new.
	hyperJumps := OrderedCollection new.
	atomicBombs := OrderedCollection new.

	"Tiro un numero random por cada casillero "
	resultForEachCell := OrderedCollection new.
	boardSize timesRepeat: [ resultForEachCell add: (1 to: 100) atRandom ].

	resultForEachCell doWithIndex: [ :result :i |
		(60 >= result and: result > 40) ifTrue: [ blackHoles add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(40 >= result and: result > 20) ifTrue: [ hyperSpaceJumps add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(20 >= result and: result > 10) ifTrue: [ moonWalks add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(10 >= result and: result > 2) ifTrue: [ hyperJumps add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(2 >= result and: result > 0) ifTrue: [ atomicBombs add: i ] ].

	self initializeWithSpecialSquaresAt: {
			blackHoles.
			hyperSpaceJumps.
			moonWalks.
			hyperJumps.
			atomicBombs }
]

{ #category : 'initialization' }
CircularBoard >> initializeWithSize: aSize rounds: aRoundNumber [

	super initializeWithSize: aSize. "Llamo a funcion de clase padre"

	rounds := aRoundNumber.
	parsecRatio := 20.
	parsecBoardSize := aSize * parsecRatio
]

{ #category : 'initialization' }
CircularBoard >> initializeWithSpecialSquaresAt: squarePositions [

	self createBlackHolesAt: squarePositions first.
	self createHyperSpaceJumpsAt: squarePositions second.
	self createMoonWalksAt: squarePositions third.
	self createHyperJumpsAt: squarePositions fourth.
	self createAtomicBombsAt: squarePositions fifth
]

{ #category : 'process' }
CircularBoard >> resolveMovementOf: anIntendedPosition [

	| finalPosition completedLaps |
	
	completedLaps := 0.
	(anIntendedPosition > boardSize or: anIntendedPosition < 1) ifTrue: [
		completedLaps := anIntendedPosition - 1 // boardSize ].

	finalPosition := anIntendedPosition - 1 \\ boardSize + 1.

	^ {
		  (map at: finalPosition).
		  completedLaps } "Devuelvo tupla de ubicacion final a la que debe ir el Ship y vuelta en la que esta"
]

{ #category : 'validation' }
CircularBoard >> wasThisTheLastRoundFor: aShip [

	^ aShip laps >= (rounds + 1) "+1 Ya que conisderamos que las naves empiezan en la lap 1"
]
