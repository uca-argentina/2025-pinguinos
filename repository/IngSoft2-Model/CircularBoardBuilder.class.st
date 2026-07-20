"
class that builds circular boards

"
Class {
	#name : 'CircularBoardBuilder',
	#superclass : 'Object',
	#instVars : [
		'map',
		'boardSize',
		'rounds',
		'probabilityRanges',
		'cardDeck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'building' }
CircularBoardBuilder >> build [
	self validateBoard.
	probabilityRanges ifNotNil: [ self setRandomSpecialSquares ].
	
	^ CircularBoard withMap: map ofSize: boardSize andNumberOfRounds: rounds.
]

{ #category : 'accessing' }
CircularBoardBuilder >> createAtomicBombsAt: squarePositions [
	
	self validateSquarePositionsAreWithinBounds: squarePositions.
	
	squarePositions do: [ :position |
		map at: position put: (AtomicBomb at: position) ]
]

{ #category : 'accessing' }
CircularBoardBuilder >> createBlackHolesAt: squarePositions [
	
	self validateSquarePositionsAreWithinBounds: squarePositions.
	
	squarePositions do: [ :position |
"		map at: position put: (Blackhole at: position in: self) ]"
		map at: position put: (BlackHole at: position )]
]

{ #category : 'accessing' }
CircularBoardBuilder >> createCardGiversAt: squarePositions [
	
	self validateSquarePositionsAreWithinBounds: squarePositions.
	cardDeck ifNil: [
		Error signal:
			'You must set a deck of cards first to be able to add Card Givers to the map!' ].
	
	squarePositions do: [ :position |
		map at: position put: (CardGiver at: position) ]
]

{ #category : 'accessing' }
CircularBoardBuilder >> createEmptySquaresAt: squarePositions [

	self validateSquarePositionsAreWithinBounds: squarePositions.

	squarePositions do: [ :position |
		map at: position put: (EmptySquare at: position) ]
]

{ #category : 'accessing' }
CircularBoardBuilder >> createHyperJumpsAt: squarePositions [

	self validateSquarePositionsAreWithinBounds: squarePositions.

	squarePositions do: [ :position |
		map
			at: position
			put: (HyperJump at: position) ]
]

{ #category : 'accessing' }
CircularBoardBuilder >> createHyperSpaceJumpsAt: squarePositions [

	self validateSquarePositionsAreWithinBounds: squarePositions.

	squarePositions do: [ :position |
		map at: position put: (HyperSpaceJump at: position) ]
]

{ #category : 'accessing' }
CircularBoardBuilder >> createMoonWalksAt: moonWalks [

	self validateSquarePositionsAreWithinBounds: (moonWalks collect: [ :moonWalk | moonWalk first ]).

	moonWalks do: [ :position |
		map
			at: position first
			put: (MoonWalk by: position second at: position first) ]
]

{ #category : 'accessing' }
CircularBoardBuilder >> createWormHolesAt: wormHoles [

	self validateSquarePositionsAreWithinBounds: (wormHoles flatCollect: [ :wormHole | wormHole ]).

	wormHoles do: [ :position |
		| wormHoleEnds |
		wormHoleEnds := Wormhole from: position first to: position second.

		map at: position first put: wormHoleEnds first.

		map at: position second put: wormHoleEnds second ]
]

{ #category : 'initialization' }
CircularBoardBuilder >> setBoardSize: aSize [
	
	(aSize isInteger and: [ aSize > 1 ]) ifFalse: [ 
		Error signal: 'Board size must be an integer and bigger than 1' ].
	
	boardSize := aSize.
	
	map := OrderedCollection new.

	1 to: boardSize do: [ :x | map add: (EmptySquare at: x) ].
	

]

{ #category : 'initialization' }
CircularBoardBuilder >> setBoardSizeInParsecs: aParsecSize [

	| sizeInCellUnits boardSizeMagnitude |
	(aParsecSize isInteger and: [ aParsecSize > 1 ]) ifFalse: [
		Error signal:
			'Board Parsec size must be an integer and bigger than 1' ].

	sizeInCellUnits := (Parsec of: aParsecSize) convertToCellUnits.
	boardSizeMagnitude := (sizeInCellUnits floor) value.

	boardSizeMagnitude > 1 ifFalse: [
		Error signal: 'Board Parsec size is too small!' ].

	boardSize := boardSizeMagnitude.

	map := OrderedCollection new.

	1 to: boardSize do: [ :x | map add: (EmptySquare at: x) ]
]

{ #category : 'initialization' }
CircularBoardBuilder >> setDeck: aDeck [
	cardDeck := aDeck.
]

{ #category : 'initialization' }
CircularBoardBuilder >> setNumberOfRounds: aNumberOfRounds [

	(aNumberOfRounds isInteger and: [ aNumberOfRounds > 0 ]) ifFalse: [
		Error signal:
			'Round number for the board must be positive and an integer.' ].

	rounds := aNumberOfRounds
]

{ #category : 'initialization' }
CircularBoardBuilder >> setRandomSpecialSquares [

	| blackHoles hyperSpaceJumps moonWalks hyperJumps atomicBombs cardGivers emptySquares resultForEachCell |
	
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
		(result > ((probabilityRanges at: 'EmptySquare') first) and: result <= ((probabilityRanges at: 'EmptySquare') second)) ifTrue: [ emptySquares add: i ].
		(result > ((probabilityRanges at: 'CardGiver') first) and: result <= ((probabilityRanges at: 'CardGiver') second)) ifTrue: [ cardGivers add: i ].
		(result > ((probabilityRanges at: 'BlackHole') first) and: result <= ((probabilityRanges at: 'BlackHole') second)) ifTrue: [ blackHoles add: i ].
		(result > ((probabilityRanges at: 'HyperSpaceJump') first) and: result <= ((probabilityRanges at: 'HyperSpaceJump') second)) ifTrue: [ hyperSpaceJumps add: i ].
		(result > ((probabilityRanges at: 'MoonWalk') first) and: result <= ((probabilityRanges at: 'MoonWalk') second)) ifTrue: [ moonWalks add: {i. (1 to: 5) atRandom} ].  "{posicion. N del moonwalk}"
		(result > ((probabilityRanges at: 'HyperJump') first)and: result <= ((probabilityRanges at: 'HyperJump') second)) ifTrue: [ hyperJumps add: i ].
		(result > ((probabilityRanges at: 'AtomicBomb') first) and: result <= ((probabilityRanges at: 'AtomicBomb') second)) ifTrue: [ atomicBombs add: i ] 
		].

	self setSquares: (Dictionary newFrom: {
				 ('BlackHoles' -> blackHoles).
				 ('HyperSpaceJumps' -> hyperSpaceJumps).
				 ('MoonWalks' -> moonWalks).
				 ('HyperJumps' -> hyperJumps).
				 ('AtomicBombs' -> atomicBombs).
				 ('EmptySquares' -> emptySquares).
				 ('CardGivers' -> cardGivers) }).
	
]

{ #category : 'initialization' }
CircularBoardBuilder >> setSquareProbabilities: aProbabilityDistribution [

	| currentLimit |
	self validateProbabilityDistribution: aProbabilityDistribution.
	
	probabilityRanges := OrderedDictionary new.
	currentLimit := 0.

	aProbabilityDistribution keysAndValuesDo: [ :squareType :probability |
		probabilityRanges at: squareType put: {
				currentLimit.
				(currentLimit + probability) }.
		currentLimit := currentLimit + probability ].

	
]

{ #category : 'initialization' }
CircularBoardBuilder >> setSquares: aDictionaryOfSquares [

	self createBlackHolesAt:
		(aDictionaryOfSquares at: 'BlackHoles' ifAbsent: [ {  } ]).
	self createHyperSpaceJumpsAt:
		(aDictionaryOfSquares at: 'HyperSpaceJumps' ifAbsent: [ {  } ]).
	self createMoonWalksAt:
		(aDictionaryOfSquares at: 'MoonWalks' ifAbsent: [ {  } ]).
	self createHyperJumpsAt:
		(aDictionaryOfSquares at: 'HyperJumps' ifAbsent: [ {  } ]).
	self createAtomicBombsAt:
		(aDictionaryOfSquares at: 'AtomicBombs' ifAbsent: [ {  } ]).
	self createWormHolesAt:
		(aDictionaryOfSquares at: 'WormHoles' ifAbsent: [ {  } ]).
	self createEmptySquaresAt:
		(aDictionaryOfSquares at: 'EmptySquares' ifAbsent: [ {  } ]).
	self createCardGiversAt:
		(aDictionaryOfSquares at: 'CardGivers' ifAbsent: [ {  } ])
]

{ #category : 'validating' }
CircularBoardBuilder >> validateBoard [

	boardSize ifNil: [
		Error signal:
			'You must define a board size with setBoardSize before being able to build a board.' ].

	rounds ifNil: [
		Error signal:
			'You must define a number of rounds to be played with setNumberOfRounds before being able to build a board.' ]
]

{ #category : 'validating' }
CircularBoardBuilder >> validateProbabilityDistribution: aProbabilityDistribution [

	aProbabilityDistribution valuesDo: [ :probability |
		(probability between: 0 and: 100) ifFalse: [
			Error signal: 'Probability numbers must be between 0 and 100.' ] ].

	aProbabilityDistribution values sum = 100 ifFalse: [
		Error signal: 'Probability numbers must add up to 100.' ]
]

{ #category : 'validating' }
CircularBoardBuilder >> validateSquarePositionsAreWithinBounds: anArrayOfSquarePositions [ 
	anArrayOfSquarePositions do: [ :position | 
		(position between: 1 and: boardSize) ifFalse:[Error signal: 'Position of squares must be within Bounds of Board!' ]
		 ]
	

]
