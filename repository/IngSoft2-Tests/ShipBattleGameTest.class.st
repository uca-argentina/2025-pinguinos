Class {
	#name : 'ShipBattleGameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ShipBattleGameTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenCircularBoardIsCreatedThenGameDoesntEndIfShipDoesntCrossGoal [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 1
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 3) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self deny: aGame getWinner equals: 'player 1'
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenCircularBoardIsCreatedThenGameEndsAfterOneRound [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 1
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 6) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenCircularBoardIsCreatedWith2RoundsGameDoesntEndIfShipReachesLastSquareIn2ndRound [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 134) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenCircularBoardIsCreatedWith2RoundsGameEndsIfShipCrossesGoal2TimesInSameDiceRoll [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 100) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenCircularBoardIsCreatedWithMoreThanOneRoundThenIsFinished [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 4) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.
	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenCircularBoardIsCreatedWithMoreThanOneRoundThenIsNotFinishedAfterFirstOne [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 6) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self deny: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenCircularBoardIsCreatedWithMoreThanOneShipThenTheFirstOneWins [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 6) }
		         and: {
				         (Ship named: 'player 1').
				         (Ship named: 'player 2') }.

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]
