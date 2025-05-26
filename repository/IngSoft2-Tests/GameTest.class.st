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
	
	aWeighedDie := LoadedDie withSides: 4.
	
	aGame := Game inSize: 4 withWormHoleFrom: 2 to: 3 with: { aWeighedDie } and: { Ship named: 'player 1' . Ship named: 'player 2' }.
	
	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 4.
	expectedResult at: 'player 2' put: 1.
	
	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
GameTest >> testWhenShipReachesGoalThenGameEndsAndWeCanGetWinner [
	
	| aGame aWeighedDie |
	
	aWeighedDie := LoadedDie withSides: 6.
	
	aGame := Game inSize: 4 withWormHoleFrom: 2 to: 3 with: { aWeighedDie } and: { Ship named: 'player 1' }.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'running' }
GameTest >> testWhenShipReachesGoalThenGameEndsCorrectlyAndTryingToPlayNextTurnResultsInError [
	
	| aGame aWeighedDie |
	
	aWeighedDie := LoadedDie withSides: 6.
	
	aGame := Game inSize: 4 withWormHoleFrom: 2 to: 3 with: { aWeighedDie } and: { Ship named: 'player 1' }.

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
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: { Ship named: 'player 1' . Ship named: 'player 2' }.

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 1.
	expectedResult at: 'player 2' put: 1.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyTravelsThroughWormHole [
	
	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 2 to: 7 with: { Die withSides: 1 } and: { Ship named: 'player 1' }.
	
	aGame nextTurn.

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 7.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd2ShipsAndPlaying1TurnThenShipsEndIn1And2Squares [
	
	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: { Ship named: 'player 1' . Ship named: 'player 2' }.

	2 timesRepeat: [ aGame nextTurn ].

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	expectedResult at: 'player 2' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd2ShipsAndPlaying2TurnsThenShipsEndIn2Square [

	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: { Ship named: 'player 1' . Ship named: 'player 2' }.

	2 timesRepeat: [ aGame nextTurn ].

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	expectedResult at: 'player 2' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWith1SidedDieAnd3ShipsAndPlaying4TurnsThenShipsEndInExpectedSquares [
		
	| expectedResult aGame |
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: { Ship named: 'player 1' . Ship named: 'player 2' . Ship named: 'player 3'}.

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
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 } and: { Ship named: 'player 1' }.

	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithTwo1SidedDiceAndPlayingTurnThenShipEndsTwoSquaresAhead [
	
	| expectedResult aGame |
	
	
	aGame := Game inSize: 8 withWormHoleFrom: 4 to: 7 with: { Die withSides: 1 . Die withSides: 1 } and: { Ship named: 'player 1' }.

	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 3.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithWeighedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyMoves3Squares [
	
	| expectedResult aWeighedDie aGame shipSet |
	
	shipSet := { Ship named: 'player 1' }.
	aWeighedDie := LoadedDie withSides: 4.
	aGame := Game inSize: 8 withWormHoleFrom: 3 to: 7 with: {aWeighedDie} and: shipSet.
	
	aGame nextTurn.

	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 5.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenStartingGameWithWeighedDieAnd1ShipAfterPlayingTurnTheShipCorrectlyTravelsBackThroughWormHole [
	
	| aGame expectedResult aWeighedDie shipSet |
	
	aWeighedDie := LoadedDie withSides: 4.
	
	shipSet := { Ship named: 'player 1' }.
	
	aGame := Game inSize: 8 withWormHoleFrom: 5 to: 2 with: {aWeighedDie} and: shipSet.

	aGame nextTurn.
	
	expectedResult := Dictionary new.
	expectedResult at: 'player 1' put: 2.
	
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
GameTest >> testWhenTryingToCreateGameWithOtherObjectsInPlaceOfShipsResultsInError [

	self
		should: [ Game inSize: 8 withWormHoleFrom: 5 to: 2 with: { Die withSides: 6 } and: { Die withSides: 4 } ]
		raise: Error
		withMessageText: 'Set of ships must contain only ships!'
	
]

{ #category : 'running' }
GameTest >> testWhenTryingToCreateGameWithoutShipsAnErrorIsRaised [

	self
		should: [ Game inSize: 8 withWormHoleFrom: 5 to: 2 with: { Die withSides: 6 } and: {} ]
		raise: Error
		withMessageText: 'Cannot build a game without any ships!'
	
]
