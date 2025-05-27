"
The class which will manage a ship battle game on a circular board.
"
Class {
	#name : 'ShipBattleGame',
	#superclass : 'Game',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'getter' }
ShipBattleGame >> boardState [

	| currentGameState rankedList |
	
	currentGameState := OrderedDictionary new.
	
	rankedList := ships sort: [ :shipA :shipB |
		              self compareProgressOf2Ships: shipA and: shipB ].
	
	rankedList doWithIndex: [ :ship :i |
		currentGameState
			at: (i printString , '°')
			put: (Dictionary newFrom: {
						 ('name' -> ship name).
						 ('position' -> ship position).
						 ('lap' -> ship laps) }) ].
					
	^ currentGameState
]

{ #category : 'comparing' }
ShipBattleGame >> compareProgressOf2Ships: shipA and: shipB [

	^ shipA laps > shipB laps or: [
		  shipA laps = shipB laps and: [ shipA position > shipB position ] ] "Comparo primero numero de vueltas, si son iguales paso a posicion en el tablero."
]

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
