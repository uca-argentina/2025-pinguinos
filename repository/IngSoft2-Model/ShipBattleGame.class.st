"
The class which will manage a ship battle game on a circular board.
"
Class {
	#name : 'ShipBattleGame',
	#superclass : 'Game',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ShipBattleGame class >> inSize: aSize rounds: aRoundNumber with: aDiceSet and: aNumberOfShips withBlackholeAt: aPosition [
	^self new initializeInSize: aSize rounds: aRoundNumber with: aDiceSet and: aNumberOfShips withBlackholeAt: aPosition.
]

{ #category : 'instance creation' }
ShipBattleGame class >> inSize: aSize rounds: aRoundNumber withWormHoleFrom: aSquare to: anotherSquare with: aDiceSet and: aNumberOfShips [ 
	^self new initializeInSize: aSize rounds: aRoundNumber withWormholeFrom: aSquare to: anotherSquare with: aDiceSet and: aNumberOfShips
]

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

{ #category : 'game controls' }
ShipBattleGame >> fightBetween: fightingShip and: shipToFight [

	| shipToFightDiceRoll fightingShipDiceRoll |
	
	fightingShipDiceRoll := diceSet roll. "Primero tira el que llega al cuadrado"
	shipToFightDiceRoll := diceSet roll.

	fightingShipDiceRoll = shipToFightDiceRoll ifTrue: [ ^ nil ]. "Si hay empate no pasa nada"
	fightingShipDiceRoll > shipToFightDiceRoll
		ifTrue: [ shipToFight loseFight ]
		ifFalse: [ fightingShip loseFight ]
]

{ #category : 'validation' }
ShipBattleGame >> haveWeGotAWinner: currentShip [

	(board wasThisTheLastRoundFor: currentShip) ifTrue: [
		gameOver := true.
		gameWinner := currentShip name ].

	^ gameOver
]

{ #category : 'initialization' }
ShipBattleGame >> initializeInSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips [

	board := CircularBoard
		         withSize: aSize
		         rounds: aRoundNumber.

	diceSet := DiceSet withDice: aDiceSet.

	ships := self orderShips: aSetOfShips.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil.
]

{ #category : 'initialization' }
ShipBattleGame >> initializeInSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips withBlackholeAt: aPosition [ 

	board := CircularBoard
		         withSize: aSize
		         rounds: aRoundNumber
					withBlackholeAt: aPosition.

	diceSet := DiceSet withDice: aDiceSet.

	ships := self orderShips: aSetOfShips.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil.
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

	currentShip canIPlayTurn ifTrue: [ self playTurnOf: currentShip ] ifFalse: [ currentShip turnSkipped ].

	shipToMove := shipToMove \\ ships size + 1
]

{ #category : 'game controls' }
ShipBattleGame >> playTurnOf: currentShip [
	
	| shipToFight |
	
	currentShip moveBy: diceSet roll onCircularBoard: board.

	self haveWeGotAWinner: currentShip.
	
	shipToFight := self whoDoIFight: currentShip.
	
	shipToFight ifNotNil: [
		self fightBetween: currentShip and: shipToFight ].
]

{ #category : 'game controls' }
ShipBattleGame >> skipTurn [
	
	| currentShip |

	currentShip := ships at: shipToMove.
	currentShip recoverShields.
	
	shipToMove := shipToMove \\ ships size + 1.
]

{ #category : 'accessing' }
ShipBattleGame >> whoDoIFight: thisShip [

	| shipToFight returnValue |
	
	returnValue := nil.
	shipToFight := ships select: [ :ship | "Devuelvo toda nave que este en el cuadrado de thisShip excluyendo a thisShip en si misma, y al primer casillero"
		               thisShip position ~= 1 and: (ship position = thisShip position and: ship ~= thisShip) ].
	
	shipToFight ifNotEmpty: [ returnValue := shipToFight atRandom ]. "Devuelvo una nave random del cuadrado para pelear"
	
	^ returnValue 
]
