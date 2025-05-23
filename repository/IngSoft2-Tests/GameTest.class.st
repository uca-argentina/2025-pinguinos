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
GameTest >> testWhenShipReachesGoalThenGameEndsAndWeCanGetFinalBoardPositions [
	
	| aGameFactory newGame aWeighedDie expectedResult |
	
	aWeighedDie := (Die withSides: 6) customizeMinimum: 6.
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 4 withWormHoleFrom: 2 to: 3.
	aGameFactory ships: 2.
	aGameFactory withDice: { aWeighedDie }.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 4.
	expectedResult at: 'player 2' put: 1.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	
	self assert: newGame boardState equals: expectedResult
]

{ #category : 'running' }
GameTest >> testWhenShipReachesGoalThenGameEndsAndWeCanGetWinner [
	
	| aGameFactory newGame aWeighedDie |
	
	aWeighedDie := (Die withSides: 6) customizeMinimum: 6.
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 4 withWormHoleFrom: 2 to: 3.
	aGameFactory ships: 1.
	aGameFactory withDice: { aWeighedDie }.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	
	self assert: newGame getWinner equals: 'player 1'
]

{ #category : 'running' }
GameTest >> testWhenShipReachesGoalThenGameEndsAndWinnerIsDeclared [
	
	| aGameFactory newGame aWeighedDie |
	
	aWeighedDie := (Die withSides: 6) customizeMinimum: 6.
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 4 withWormHoleFrom: 2 to: 3.
	aGameFactory ships: 1.
	aGameFactory withDice: { aWeighedDie }.
	
	newGame := aGameFactory build.
	
	self assert: newGame nextTurn equals: 'player 1 has won the game!' 
]

{ #category : 'running' }
GameTest >> testWhenShipReachesGoalThenGameEndsCorrectlyAndTryingToPlayNextTurnResultsInError [

	| aGameFactory newGame aWeighedDie |
	aWeighedDie := (Die withSides: 6) customizeMinimum: 6.

	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 4 withWormHoleFrom: 2 to: 3.
	aGameFactory ships: 1.
	aGameFactory withDice: { aWeighedDie }.

	newGame := aGameFactory build.
	newGame nextTurn.

	self assert: newGame isGameOver.
	self
		should: [ newGame nextTurn ]
		raise: Error
		withMessageText: 'player 1 has won, game over!'
]

{ #category : 'running' }
GameTest >> testWhenStartingGameThenAllShipsAreInSquare1 [
	
	| aGameFactory newGame expectedResult |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 4 to: 7.
	aGameFactory ships: 2.
	aGameFactory withDice: { Die withSides: 1 }.
	
	newGame := aGameFactory build.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 1.
	expectedResult at: 'player 2' put: 1.
	
	self assert: newGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyTravelsThroughWormHole [
	
	| aGameFactory newGame expectedResult |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 2 to: 7.
	aGameFactory ships: 1.
	aGameFactory withDice: { Die withSides: 1 }.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 7.
	
	self assert: newGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd2ShipsAndPlaying1TurnThenShipsEndIn1And2Squares [
	
	| aGameFactory newGame expectedResult |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 4 to: 7.
	aGameFactory ships: 2.
	aGameFactory withDice: { Die withSides: 1 }.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	expectedResult at: 'player 2' put: 1.
	
	self assert: newGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd2ShipsAndPlaying2TurnsThenShipsEndIn2Square [
	
	| aGameFactory newGame expectedResult |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 4 to: 7.
	aGameFactory ships: 2.
	aGameFactory withDice: { Die withSides: 1 }.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	newGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	expectedResult at: 'player 2' put: 2.
	
	self assert: newGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd3ShipsAndPlaying4TurnsThenShipsEndInExpectedSquares [
	
	| aGameFactory newGame expectedResult |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 4 to: 7.
	aGameFactory ships: 3.
	aGameFactory withDice: { Die withSides: 1 }.
	
	newGame := aGameFactory build.
	4 timesRepeat: [ newGame nextTurn ].
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 3.
	expectedResult at: 'player 2' put: 2.
	expectedResult at: 'player 3' put: 2.
	
	self assert: newGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAndPlayingTurnThenShipEndsOneSquareAhead [
	
	| aGameFactory newGame expectedResult |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 4 to: 7.
	aGameFactory ships: 1.
	aGameFactory withDice: { Die withSides: 1 }.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: newGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithTwo1SidedDiceAndPlayingTurnThenShipEndsTwoSquaresAhead [
	
	| aGameFactory newGame expectedResult |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 4 to: 7.
	aGameFactory ships: 1.
	aGameFactory withDice: { Die withSides: 1 . Die withSides: 1 }.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 3.
	
	self assert: newGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithWeighedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyMoves3Squares [
	
	| aGameFactory newGame expectedResult aWeighedDie |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 3 to: 7.
	aGameFactory ships: 1.
	
	aWeighedDie := (Die withSides: 4) customizeMinimum: 4.
	aGameFactory withDice: { aWeighedDie }.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 5.
	
	self assert: newGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithWeighedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyTravelsBackThroughWormHole [
	
	| aGameFactory newGame expectedResult aWeighedDie |
	
	aGameFactory := GameFactory new.
	aGameFactory withBoardSize: 8 withWormHoleFrom: 5 to: 2.
	aGameFactory ships: 1.
	
	aWeighedDie := (Die withSides: 4) customizeMinimum: 4.
	aGameFactory withDice: { aWeighedDie }.
	
	newGame := aGameFactory build.
	newGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: newGame boardState equals: expectedResult 
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
