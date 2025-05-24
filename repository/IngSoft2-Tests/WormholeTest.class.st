Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WormholeTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
WormholeTest >> testWhenFirstPositionIsNegativeThenCreationFails [

	self
		should: [ Wormhole firstPosition: -2 secondPosition: 6]
		raise:  Error
		withErrorMessage: 'First position position must be positive.'
]

{ #category : 'running' }
WormholeTest >> testWhenPositionsAreEqualThenCreationFails [

	self
		should: [ Wormhole firstPosition: 2 secondPosition: 2]
		raise:  Error
		withErrorMessage: 'Wormhole cannot lead to itself!'
]

{ #category : 'tests' }
WormholeTest >> testWhenSecondPositionIsNegativeThenCreationFails [

	self
		should: [ Wormhole firstPosition: 2 secondPosition: -6]
		raise:  Error
		withErrorMessage: 'Second position position must be positive.'
]

{ #category : 'running' }
WormholeTest >> testWhenWormholeIsUsedInTheSecondPositionThenShipGetsToTheOtherSide [

	| aWormhole aGame aWeighedDie expectedResult |
	
	aWormhole := Wormhole firstPosition: 2 secondPosition: 6.
	aWeighedDie := (Die withSides: 5) customizeMinimum: 5.
	aGame:= Game inSize: 14 withWormhole: aWormhole with: { aWeighedDie } and: 1.
	
	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: (aGame boardState) equals: expectedResult. 
]

{ #category : 'running' }
WormholeTest >> testWhenWormholeIsUsedThenGameCanStillBeKeptPlaying [

	| aWormhole aGame aWeighedDie |
	
	aWormhole := Wormhole firstPosition: 2 secondPosition: 6.
	aWeighedDie := (Die withSides: 5) customizeMinimum: 5.
	aGame:= Game inSize: 10 withWormhole: aWormhole with: { aWeighedDie } and: 1.
	
	aGame nextTurn.
	aGame nextTurn.
	
	self assert: (aGame nextTurn) equals: 'player 1 has won the game!' 
]

{ #category : 'tests' }
WormholeTest >> testWhenWormholePositionsAreInvertedThenGameStillPlays [

	| aWormhole aGame aWeighedDie expectedResult |
	
	aWormhole := Wormhole firstPosition: 6 secondPosition: 2.
	aWeighedDie := (Die withSides: 5) customizeMinimum: 5.
	aGame:= Game inSize: 14 withWormhole: aWormhole with: { aWeighedDie } and: 1.
	
	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: (aGame boardState) equals: expectedResult. 
]
