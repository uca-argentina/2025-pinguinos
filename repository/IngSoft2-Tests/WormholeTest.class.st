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
		should: [ Wormhole from: -2 to: 4 ]
		raise:  Error
		withErrorMessage: 'X position must be positive.'
]

{ #category : 'running' }
WormholeTest >> testWhenPositionsAreEqualThenCreationFails [

	self
		should: [ Wormhole from: 2 to: 2]
		raise:  Error
		withErrorMessage: 'Wormhole cannot lead to itself!'
]

{ #category : 'tests' }
WormholeTest >> testWhenSecondPositionIsNegativeThenCreationFails [

	self
		should: [ Wormhole from: 3 to: -6]
		raise:  Error
		withErrorMessage: 'X position must be positive.'
]

{ #category : 'running' }
WormholeTest >> testWhenWormholeIsUsedInTheSecondPositionThenShipGetsToTheOtherSide [

	| aGame aWeighedDie expectedResult |
	
	aWeighedDie := (Die withSides: 5) customizeMinimum: 5.
	aGame:= Game inSize: 8 withWormHoleFrom: 2 to: 6 with: { aWeighedDie } and: 1.
	
	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: (aGame boardState) equals: expectedResult. 
]

{ #category : 'running' }
WormholeTest >> testWhenWormholeIsUsedThenGameCanStillBeKeptPlaying [

	| aGame aWeighedDie |
	
	aWeighedDie := (Die withSides: 5) customizeMinimum: 5.
	aGame:= Game inSize: 10 withWormHoleFrom: 2 to: 6 with: { aWeighedDie } and: 1.
	
	aGame nextTurn.
	aGame nextTurn.
	
	self assert: (aGame nextTurn) equals: 'player 1 has won the game!' 
]

{ #category : 'tests' }
WormholeTest >> testWhenWormholePositionsAreInvertedThenGameStillPlays [

	| aGame aWeighedDie expectedResult |
	
	aWeighedDie := (Die withSides: 5) customizeMinimum: 5.
	aGame:= Game inSize: 10 withWormHoleFrom: 6 to: 2 with: { aWeighedDie } and: 1.
	
	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: (aGame boardState) equals: expectedResult. 
]
