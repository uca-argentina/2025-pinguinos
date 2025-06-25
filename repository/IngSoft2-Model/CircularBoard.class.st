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
CircularBoard class >> validate: aSquareType in: squarePositions areWithinBoundsOf: aSize [

	(squarePositions at: aSquareType ifAbsent: [ {  } ]) do: [
		:squarePosition |
		(squarePosition between: 1 and: aSize) ifFalse: [
			Error signal:
				'Position of ' , aSquareType , ' must be within Bounds of Board!' ] ]
]

{ #category : 'validation' }
CircularBoard class >> validateMoonWalksin: squarePositions areWithinBoundsOf: aSize [

	| moonWalkPositions |
	moonWalkPositions := squarePositions
		                     at: 'MoonWalks'
		                     ifAbsent: [ ^ self ].

	moonWalkPositions do: [ :moonWalkValues |
		(moonWalkValues first between: 1 and: aSize) ifFalse: [ Error signal: 'Position of MoonWalks must be within Bounds of Board!' ] ]
]

{ #category : 'validation' }
CircularBoard class >> validateRoundNumberIsPositive: aRoundNumber [

	aRoundNumber < 1 ifTrue: [
		Error signal: 'Round number for the board must be positive.' ]
]

{ #category : 'validation' }
CircularBoard class >> validateSquarePositionsAreWithinBounds: squarePositions of: aSize [

	self validate: 'BlackHoles' in: squarePositions areWithinBoundsOf: aSize.
	self validate: 'HyperSpaceJumps' in: squarePositions areWithinBoundsOf: aSize. 
	self validate: 'HyperJumps' in: squarePositions areWithinBoundsOf: aSize. 
	self validate: 'AtomicBombs' in: squarePositions areWithinBoundsOf: aSize. 
	
	self validateWormHolesIn: squarePositions areWithinBoundsOf: aSize.
	self validateMoonWalksin: squarePositions areWithinBoundsOf: aSize. 
]

{ #category : 'validation' }
CircularBoard class >> validateWormHolesIn: squarePositions areWithinBoundsOf: aSize [

	| wormHolePositions |
	
	wormHolePositions := squarePositions
		                     at: 'WormHoles'
		                     ifAbsent: [ ^ self ].
		
	wormHolePositions do: [ :wormHoleEnds |
		Board
			is: wormHoleEnds first
			and: wormHoleEnds second
			withinBoundsOf: aSize ]
		
	
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
	
	self validateSquarePositionsAreWithinBounds: squarePositions of: aSize.

	^ (self withSize: aSize rounds: aRoundNumber)
		  initializeWithSpecialSquaresAt: squarePositions
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
CircularBoard >> createCardGiversAt: squarePositions [

	squarePositions do: [:position | map at: position put: (CardGiver at: position with: Deck new) ].
]

{ #category : 'accessing' }
CircularBoard >> createEmptySquaresAt: aSquarePositions [
	
	aSquarePositions do: [:position | map at: position put: (EmptySquare at: position) ]
	
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
		map
			at: position first
			put: (MoonWalk by: position second at: position first) ]
]

{ #category : 'accessing' }
CircularBoard >> createWormHolesAt: squarePositions [

	squarePositions do: [ :position |
		| wormHoleEnds |
		wormHoleEnds := Wormhole from: position first to: position second.

		map at: position first put: wormHoleEnds first.

		map at: position second put: wormHoleEnds second ]
]

{ #category : 'getter' }
CircularBoard >> getParsecRatio [

	^ parsecRatio
]

{ #category : 'initialization' }
CircularBoard >> initializeRandomSpecialSquares [

	| blackHoles hyperSpaceJumps moonWalks hyperJumps atomicBombs resultForEachCell cardGivers emptySquares |
	
	blackHoles := OrderedCollection new.
	hyperSpaceJumps := OrderedCollection new.
	moonWalks := OrderedCollection new.
	hyperJumps := OrderedCollection new.
	atomicBombs := OrderedCollection new.
	cardGivers := OrderedCollection new.
	emptySquares := OrderedCollection new.
	
	"Tiro un numero random por cada casillero "
	resultForEachCell := OrderedCollection new.
	boardSize timesRepeat: [ resultForEachCell add: (1 to: 100) atRandom ].

	resultForEachCell doWithIndex: [ :result :i |
		(100 >= result and: result > 70) ifTrue: [ emptySquares add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(70 >= result and: result > 60) ifTrue: [ cardGivers add: i ] ].
	
	resultForEachCell doWithIndex: [ :result :i |
		(60 >= result and: result > 40) ifTrue: [ blackHoles add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(40 >= result and: result > 20) ifTrue: [ hyperSpaceJumps add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(20 >= result and: result > 10) ifTrue: [ moonWalks add: {i. (1 to: 5) atRandom} ] ].  "{posicion. N del moonwalk}"

	resultForEachCell doWithIndex: [ :result :i |
		(10 >= result and: result > 2) ifTrue: [ hyperJumps add: i ] ].

	resultForEachCell doWithIndex: [ :result :i |
		(2 >= result and: result > 0) ifTrue: [ atomicBombs add: i ] ].

	self initializeWithSpecialSquaresAt: (Dictionary newFrom: {
				 ('BlackHoles' -> blackHoles).
				 ('HyperSpaceJumps' -> hyperSpaceJumps).
				 ('MoonWalks' -> moonWalks).
				 ('HyperJumps' -> hyperJumps).
				 ('AtomicBombs' -> atomicBombs).
 				 ('EmptySquares' -> emptySquares ). 
				 ('CardGivers' -> cardGivers )})
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

	self createBlackHolesAt: (squarePositions at: 'BlackHoles' ifAbsent: [ {} ]).
	self createHyperSpaceJumpsAt: (squarePositions at: 'HyperSpaceJumps' ifAbsent: [ {} ]).
	self createMoonWalksAt: (squarePositions at: 'MoonWalks' ifAbsent: [ {} ]).
	self createHyperJumpsAt: (squarePositions at: 'HyperJumps' ifAbsent: [ {} ]).
	self createAtomicBombsAt: (squarePositions at: 'AtomicBombs' ifAbsent: [ {} ]).
	self createWormHolesAt: (squarePositions at: 'WormHoles' ifAbsent: [ {} ]).
	self createEmptySquaresAt: (squarePositions at: 'EmptySquares' ifAbsent: [ {} ]).
	self createCardGiversAt: (squarePositions at: 'CardGivers' ifAbsent: [ {} ]).
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
