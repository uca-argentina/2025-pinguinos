Class {
	#name : 'CircularBoardBuilderTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
CircularBoardBuilderTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testAfterCreatingABoardOfSize100WithSemiRandomlyDistributedSpecialSquaresWeSeeTheDistributionOfTypesIsAsExpected [

	| aBoardBuilder classCounts boards numberOfBoards probabilityDistribution |
	probabilityDistribution := Dictionary new.
	classCounts := Dictionary new.
	numberOfBoards := 1000.

	probabilityDistribution at: 'EmptySquare' put: 30.
	probabilityDistribution at: 'BlackHole' put: 20.
	probabilityDistribution at: 'HyperSpaceJump' put: 20.
	probabilityDistribution at: 'MoonWalk' put: 10.
	probabilityDistribution at: 'HyperJump' put: 8.
	probabilityDistribution at: 'AtomicBomb' put: 2.
	probabilityDistribution at: 'CardGiver' put: 10.

	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.
	aBoardBuilder setSquareProbabilities: probabilityDistribution.
	aBoardBuilder setDeck: NullDeck new.

	"dict['nombre clase'] = { numero de ocurrencias }"
	classCounts at: 'EmptySquare' put: 0.
	classCounts at: 'BlackHole' put: 0.
	classCounts at: 'HyperSpaceJump' put: 0.
	classCounts at: 'MoonWalk' put: 0.
	classCounts at: 'HyperJump' put: 0.
	classCounts at: 'AtomicBomb' put: 0.
	classCounts at: 'CardGiver' put: 0.

	boards := OrderedCollection new.
	
	numberOfBoards timesRepeat: [ boards add: aBoardBuilder build ].

	boards do: [ :board |
		1 to: 100 do: [ :i |
			| className |
			className := (board getSquareAt: i) class asString.
			classCounts at: className put: (classCounts at: className) + 1 ] ].

	"Observo que cada cuadrado aparezca ± 10 veces del valor esperado"
	classCounts keysAndValuesDo: [ :className :value |
		self assert: ( (value / numberOfBoards) between: ((probabilityDistribution at: className) - 1) and: ((probabilityDistribution at: className) + 1)) 
		]
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCanBuildBoardOfSize40Parsecs [

	| aBoardBuilder aBoard |
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setNumberOfRounds: 1.
	aBoardBuilder setBoardSizeInParsecs: 40.

	aBoard := aBoardBuilder build.

	self assert: aBoard size equals: 2.
	self assert: (aBoard getSquareAt: 5) class equals: EmptySquare.
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCanBuildBoardOfSize5 [

	| aBoardBuilder aBoard |
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setNumberOfRounds: 1.
	aBoardBuilder setBoardSize: 5.

	aBoard := aBoardBuilder build.

	self assert: aBoard size equals: 5.
	self assert: (aBoard getSquareAt: 5) class equals: EmptySquare.
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCanBuildBoardWithACustomSetOfSquarePositions [

	| aBoardBuilder aSetOfSquares aBoard |
	
	aSetOfSquares := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.
	
	aSetOfSquares at: 'EmptySquares' put: { 8 . 10 }.
	aSetOfSquares at: 'BlackHoles' put: { 30 }.
	aSetOfSquares at: 'CardGivers' put: { 20 }.
	aSetOfSquares at: 'MoonWalks' put: { { 2 . 3 } . { 7 . 5 } } . "Moonwalks de 3, {posicion, N}"
	aSetOfSquares at: 'HyperJumps' put: { 12 . 5 . 90 }.
	aSetOfSquares at: 'HyperSpaceJumps' put: { 88 }.
	aSetOfSquares at: 'AtomicBombs' put: { 22 }.
	
	aBoardBuilder setDeck: NullDeck new.
	aBoardBuilder setSquares: aSetOfSquares.
	
	aBoard := aBoardBuilder build.
	
	self assert: (aBoard getSquareAt: 1) class equals: EmptySquare.
	self assert: (aBoard getSquareAt: 8) class equals: EmptySquare.
	self assert: (aBoard getSquareAt: 10) class equals: EmptySquare.
	self assert: (aBoard getSquareAt: 30) class equals: BlackHole.
	self assert: (aBoard getSquareAt: 20) class equals: CardGiver.
	self assert: (aBoard getSquareAt: 2) class equals: MoonWalk.
	self assert: (aBoard getSquareAt: 7) class equals: MoonWalk.
	self assert: (aBoard getSquareAt: 12) class equals: HyperJump.
	self assert: (aBoard getSquareAt: 5) class equals: HyperJump.
	self assert: (aBoard getSquareAt: 90) class equals: HyperJump.
	self assert: (aBoard getSquareAt: 88) class equals: HyperSpaceJump.
	self assert: (aBoard getSquareAt: 22) class equals: AtomicBomb.
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildBoardOfSize39Parsecs [

	| aBoardBuilder  |
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setNumberOfRounds: 1.
	"Conversion rate is 1 Cell = 20 Parsecs, the floor of the conversion is taken, so here we'd get 1 Cell Unit of size, which is too small"

	self
		should: [ aBoardBuilder setBoardSizeInParsecs: 39 ]
		raise: Error
		withErrorMessage: 'Board Parsec size is too small!'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildBoardOfSizeNegativeParsecs [

	| aBoardBuilder  |
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setNumberOfRounds: 1.
	"Conversion rate is 1 Cell = 20 Parsecs, the floor of the conversion is taken, so here we'd get 1 Cell Unit of size, which is too small"

	self
		should: [ aBoardBuilder setBoardSizeInParsecs: -40 ]
		raise: Error
		withErrorMessage: 'Board Parsec size must be an integer and bigger than 1'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildBoardWithMoonWalksOutsideOutOfBoard [

	| aBoardBuilder aSetOfSquares |
	aSetOfSquares := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.

	aSetOfSquares at: 'MoonWalks' put: { { 101 . 4 } }.

	self
		should: [ aBoardBuilder setSquares: aSetOfSquares ]
		raise: Error
		withErrorMessage:
		'Position of squares must be within Bounds of Board!'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildBoardWithNegativeSquarePositions [

	| aBoardBuilder aSetOfSquares |
	aSetOfSquares := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.

	aSetOfSquares at: 'EmptySquares' put: { -1 }.

	self
		should: [ aBoardBuilder setSquares: aSetOfSquares ]
		raise: Error
		withErrorMessage:
		'Position of squares must be within Bounds of Board!'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildBoardWithSquarePositionsLessThan1 [

	| aBoardBuilder aSetOfSquares |
	aSetOfSquares := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.

	aSetOfSquares at: 'EmptySquares' put: { 0 }.

	self
		should: [ aBoardBuilder setSquares: aSetOfSquares ]
		raise: Error
		withErrorMessage:
		'Position of squares must be within Bounds of Board!'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildBoardWithSquaresOutsideOfBoardRange [

	| aBoardBuilder aSetOfSquares |
	aSetOfSquares := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.

	aSetOfSquares at: 'EmptySquares' put: { 101 }.

	self
		should: [ aBoardBuilder setSquares: aSetOfSquares ]
		raise: Error
		withErrorMessage:
		'Position of squares must be within Bounds of Board!'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildBoardWithWormHolesLeadingOutOfBoard [

	| aBoardBuilder aSetOfSquares |
	aSetOfSquares := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.

	aSetOfSquares at: 'WormHoles' put: { { 1 . 101 } }.

	self
		should: [ aBoardBuilder setSquares: aSetOfSquares ]
		raise: Error
		withErrorMessage:
		'Position of squares must be within Bounds of Board!'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildWithCardGiverSquaresWithoutSettingCardDeck [

	| aBoardBuilder aSetOfSquares |
	aSetOfSquares := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.

	aSetOfSquares at: 'CardGivers' put: { 3 }.

	self
		should: [ aBoardBuilder setSquares: aSetOfSquares ]
		raise: Error
		withErrorMessage:
		'You must set a deck of cards first to be able to add Card Givers to the map!'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildWithRandomSquaresWIthoutSettingADeck [

	| aBoardBuilder probabilityDistribution |
	probabilityDistribution := Dictionary new.

	probabilityDistribution at: 'EmptySquare' put: 30.
	probabilityDistribution at: 'BlackHole' put: 20.
	probabilityDistribution at: 'HyperSpaceJump' put: 20.
	probabilityDistribution at: 'MoonWalk' put: 10.
	probabilityDistribution at: 'HyperJump' put: 8.
	probabilityDistribution at: 'AtomicBomb' put: 2.
	probabilityDistribution at: 'CardGiver' put: 10.

	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.
	aBoardBuilder setSquareProbabilities: probabilityDistribution.

	self
		should: [ aBoardBuilder build ]
		raise: Error
		withErrorMessage:
		'You must set a deck of cards first to be able to add Card Givers to the map!'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildWithoutSettingBoardSize [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	
	self
		should: [ aBoardBuilder build ]
		raise: Error 
		withErrorMessage: 'You must define a board size with setBoardSize before being able to build a board.'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotBuildWithoutSettingNumberOfRounds [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 2.
	
	self
		should: [ aBoardBuilder build ]
		raise: Error 
		withErrorMessage: 'You must define a number of rounds to be played with setNumberOfRounds before being able to build a board.'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetAProbabilityDistributionToANegativeNumber [

	| aBoardBuilder probabilityDistribution |
	
	probabilityDistribution := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.
	
	probabilityDistribution at: 'EmptySquare' put: -10.
	probabilityDistribution at: 'BlackHole' put: 80.
	probabilityDistribution at: 'CardGiver' put: 30.
	
	self
		should: [ aBoardBuilder setSquareProbabilities: probabilityDistribution.]
		raise: Error 
		withErrorMessage: 'Probability numbers must be between 0 and 100.'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetBoardSizeToANonInteger [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	
	self
		should: [ aBoardBuilder setBoardSize: 1.2 ]
		raise: Error 
		withErrorMessage: 'Board size must be an integer and bigger than 1'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetBoardSizeToAString [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	
	self
		should: [ aBoardBuilder setBoardSize: 'something' ]
		raise: Error 
		withErrorMessage: 'Board size must be an integer and bigger than 1'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetBoardSizeToLessThan2 [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	
	self
		should: [ aBoardBuilder setBoardSize: 1 ]
		raise: Error 
		withErrorMessage: 'Board size must be an integer and bigger than 1'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetNumberOfRoundsToANonInteger [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	
	self
		should: [ aBoardBuilder setNumberOfRounds: 1.5 ]
		raise: Error 
		withErrorMessage: 'Round number for the board must be positive and an integer.'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetNumberOfRoundsToAString [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	
	self
		should: [ aBoardBuilder setNumberOfRounds: 'Not an integer' ]
		raise: Error 
		withErrorMessage: 'Round number for the board must be positive and an integer.'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetNumberOfRoundsToLessThan1 [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	
	self
		should: [ aBoardBuilder setNumberOfRounds: 0 ]
		raise: Error 
		withErrorMessage: 'Round number for the board must be positive and an integer.'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetProbabilityDistributionThatAddsUpToLessThan100 [

	| aBoardBuilder probabilityDistribution |
	
	probabilityDistribution := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.
	
	probabilityDistribution at: 'EmptySquare' put: 30.
	probabilityDistribution at: 'BlackHole' put: 20.
	
	self
		should: [ aBoardBuilder setSquareProbabilities: probabilityDistribution.]
		raise: Error 
		withErrorMessage: 'Probability numbers must add up to 100.'
]

{ #category : 'tests' }
CircularBoardBuilderTest >> testCannotSetProbabilityDistributionThatAddsUpToMoreThan100 [

	| aBoardBuilder probabilityDistribution |
	
	probabilityDistribution := OrderedDictionary new.
	aBoardBuilder := CircularBoardBuilder new.
	aBoardBuilder setBoardSize: 100.
	aBoardBuilder setNumberOfRounds: 2.
	
	probabilityDistribution at: 'EmptySquare' put: 30.
	probabilityDistribution at: 'BlackHole' put: 90.
	
	self
		should: [ aBoardBuilder setSquareProbabilities: probabilityDistribution.]
		raise: Error 
		withErrorMessage: 'Probability numbers must add up to 100.'
]
