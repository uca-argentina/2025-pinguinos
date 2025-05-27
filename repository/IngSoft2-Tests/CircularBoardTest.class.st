Class {
	#name : 'CircularBoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
CircularBoardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'running' }
CircularBoardTest >> testWhenCircularBoardIsCreatedThenGameEndsAfterOneRound [
	| aGame |

	aGame := Game inSize: 4 rounds: 1
		withWormHoleFrom: 2 to: 3 
		with: { LoadedDie withSides: 6 } 
		and: { Ship named: 'player 1' }.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
CircularBoardTest >> testWhenCircularBoardIsCreatedWithMoreThanOneRoundThenIsFinished [
	| aGame |

	aGame := Game inSize: 4 rounds: 2
		withWormHoleFrom: 2 to: 3 
		with: { LoadedDie withSides: 4 } 
		and: { Ship named: 'player 1' }.

	aGame nextTurn.
	aGame nextTurn.
	
	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
CircularBoardTest >> testWhenCircularBoardIsCreatedWithMoreThanOneRoundThenIsNotFinishedAfterFirstOne [
	| aGame |

	aGame := Game inSize: 4 rounds: 2
		withWormHoleFrom: 2 to: 3 
		with: { LoadedDie withSides: 6 } 
		and: { Ship named: 'player 1' }.

	aGame nextTurn.

	self deny: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
CircularBoardTest >> testWhenCircularBoardIsCreatedWithMoreThanOneShipdThenTheFirstOneWins [
	| aGame |

	aGame := Game inSize: 4 rounds: 2
		withWormHoleFrom: 2 to: 3 
		with: { LoadedDie withSides: 6 } 
		and: { Ship named: 'player 1' . Ship named: 'player 2'}.

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
CircularBoardTest >> testWhenCreatingCircularBoardWithNegativeRoundsThenItFails [
	
	self
		should: [ CircularBoard withSize: 10 rounds: -1 ]
		raise: Error 
		withErrorMessage: 'Round number for the board must be positive.'

]
