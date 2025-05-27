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
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedThenGameDoesntEndIfShipDoesntCrossGoal [

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
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedThenGameEndsAfterOneTurn [

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
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWith2RoundsGameDoesntEndIfShipReachesLastSquareIn2ndRound [

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
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWith2RoundsGameEndsIfShipCrossesGoal2TimesIn2Turns [

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
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWith2RoundsGameEndsIfShipCrossesGoal2TimesInSameTurn [

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
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWithMoreThanOneRoundThenGameIsNotFinishedAfterFirstTurn [

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
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWithMoreThanOneRoundThenIsFinished [

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
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWithMoreThanOneShipThenTheFirstOneWins [

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

{ #category : 'running' }
ShipBattleGameTest >> testWith2ShipsInPlayWeCanGetRankedPositionOfShipsCorrectly [

	| aGame expectedResult |
	aGame := ShipBattleGame
		         inSize: 5
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 4) }
		         and: {
				         (Ship named: 'Jorge').
				         (Ship named: 'Luciano') }.

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { 'name' -> 'Jorge' . 'position' -> 4 . 'lap' -> 2 }).
	expectedResult at: '2°' put: (Dictionary newFrom: { 'name' -> 'Luciano' . 'position' -> 5 . 'lap' -> 1 }).

	self assert: aGame boardState equals: expectedResult
]
