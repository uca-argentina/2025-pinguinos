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
	
	| aGame aWeighedDie expectedResult |
	
	aWeighedDie := (Die withSides: 4) customizeMinimum: 4.
	
	aGame := Game inSize: 4 withWormHoleFrom: 2 to: 3 with: { aWeighedDie } and: 2.
	
	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 4.
	expectedResult at: 'player 2' put: 1.
	
	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
GameTest >> testWhenShipReachesGoalThenGameEndsAndWeCanGetWinner [
	
	| aGame aWeighedDie |
	
	aWeighedDie := (Die withSides: 6) customizeMinimum: 6.
	
	aGame := Game inSize: 4 withWormHoleFrom: 2 to: 3 with: { aWeighedDie } and: 1.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'running' }
GameTest >> testWhenShipReachesGoalThenGameEndsAndWinnerIsDeclared [
	
	| aGame aWeighedDie |
	
	aWeighedDie := (Die withSides: 6) customizeMinimum: 6.
	
	aGame := Game inSize: 4 withWormHoleFrom: 2 to: 3 with: { aWeighedDie } and: 1.
	
	self assert: aGame nextTurn equals: 'player 1 has won the game!' 
]

{ #category : 'running' }
GameTest >> testWhenShipReachesGoalThenGameEndsCorrectlyAndTryingToPlayNextTurnResultsInError [
	
	| aGame aWeighedDie |
	
	aWeighedDie := (Die withSides: 6) customizeMinimum: 6.
	
	aGame := Game inSize: 4 withWormHoleFrom: 2 to: 3 with: { aWeighedDie } and: 1.

	aGame nextTurn.

	self assert: aGame isGameOver.
	self
		should: [ aGame nextTurn ]
		raise: Error
		withMessageText: 'player 1 has won, game over!'
]

{ #category : 'running' }
GameTest >> testWhenStartingGameThenAllShipsAreInSquare1 [

	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: 2.

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 1.
	expectedResult at: 'player 2' put: 1.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyTravelsThroughWormHole [
	
	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 2 to: 7 with: { Die withSides: 1 } and: 1.
	
	aGame nextTurn.

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 7.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd2ShipsAndPlaying1TurnThenShipsEndIn1And2Squares [
	
	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: 2.

	2 timesRepeat: [ aGame nextTurn ].

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	expectedResult at: 'player 2' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd2ShipsAndPlaying2TurnsThenShipsEndIn2Square [

	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: 2.

	2 timesRepeat: [ aGame nextTurn ].

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	expectedResult at: 'player 2' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd3ShipsAndPlaying4TurnsThenShipsEndInExpectedSquares [
		
	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: 3.

	4 timesRepeat: [ aGame nextTurn ].
	
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 3.
	expectedResult at: 'player 2' put: 2.
	expectedResult at: 'player 3' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAndPlayingTurnThenShipEndsOneSquareAhead [
	
	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: 1.

	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithTwo1SidedDiceAndPlayingTurnThenShipEndsTwoSquaresAhead [
	
	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 . Die withSides: 1 } and: 1.

	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 3.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithWeighedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyMoves3Squares [
	
	| expectedResult aWeighedDie aGame |
	
	aWeighedDie := (Die withSides: 4) customizeMinimum: 4.
	aGame := Game inSize: 8 withWormHoleFrom: 3 to: 7 with: {aWeighedDie} and: 1.
	
	aGame nextTurn.

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 5.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithWeighedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyTravelsBackThroughWormHole [
	
	| aGame expectedResult aWeighedDie |
	
	aWeighedDie := (Die withSides: 4) customizeMinimum: 4.
	
	aGame := Game inSize: 8 withWormHoleFrom: 5 to: 2 with: {aWeighedDie} and: 1.

	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
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
