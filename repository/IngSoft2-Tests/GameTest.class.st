Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
GameTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : 'running' }
GameTest >> testWhenTryingToCreateGameWithoutBoardAnErrorIsRaised [

	| aGameFactory |
	
	aGameFactory := GameFactory new.
	
	self
		should: [ aGameFactory build ]
		raise: Error
		withMessageText: 'Cannot build a game without a board!'
	
]

{ #category : 'running' }
GameTest >> testWhenTryingToCreateGameWithoutDiceAnErrorIsRaised [

	| aGameFactory |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 2 to: 5.
	aGameFactory ships: 3.
	
	self
		should: [ aGameFactory build ]
		raise: Error
		withMessageText: 'Cannot build a game without any dice!'
	
]

{ #category : 'running' }
GameTest >> testWhenTryingToCreateGameWithoutShipAnErrorIsRaised [

	| aGameFactory |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 2 to: 5.
	
	self
		should: [ aGameFactory build ]
		raise: Error
		withMessageText: 'Cannot build a game without any ships!'
	
]
