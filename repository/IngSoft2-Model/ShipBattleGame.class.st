"
The class which will manage a ship battle game on a circular board.
"
Class {
	#name : 'ShipBattleGame',
	#superclass : 'Game',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
ShipBattleGame >> haveWeGotAWinner: currentShip [

	(board wasThisTheLastRoundFor: currentShip) ifTrue: [
		gameOver := true.
		gameWinner := currentShip name ].

	^ gameOver
]

{ #category : 'initialization' }
ShipBattleGame >> initializeInSize: aSize rounds: aRoundNumber withWormholeFrom: aSquare to: anotherSquare with: aDiceSet and: aSetOfShips [

	board := CircularBoard
		         withSize: aSize
		         rounds: aRoundNumber
		         withWormHoleFrom: aSquare
		         to: anotherSquare.

	diceSet := DiceSet withDice: aDiceSet.

	ships := self orderShips: aSetOfShips.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil.
]

{ #category : 'game controls' }
ShipBattleGame >> nextTurn [

	| currentShip |
	self canIKeepPlaying.
	
	currentShip := ships at: shipToMove.
	currentShip moveBy: diceSet roll onCircularBoard: board.

	self haveWeGotAWinner: currentShip.

	shipToMove := shipToMove \\ ships size + 1.
]
