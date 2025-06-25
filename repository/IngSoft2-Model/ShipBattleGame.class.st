"
The class which will manage a ship battle game on a circular board.
"
Class {
	#name : 'ShipBattleGame',
	#superclass : 'Game',
	#instVars : [
		'cardManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ShipBattleGame class >> inSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips [

	^ self new
		  initializeInSize: aSize
		  rounds: aRoundNumber
		  with: aDiceSet
		  and: aSetOfShips
]

{ #category : 'instance creation' }
ShipBattleGame class >> inSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips withSpecialSquaresAt: squarePositions [

	^ self new
		  initializeInSize: aSize
		  rounds: aRoundNumber
		  with: aDiceSet
		  and: aSetOfShips
		  withSpecialSquaresAt: squarePositions
]

{ #category : 'accessing' }
ShipBattleGame class >> inSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips withSpecialSquaresAt: squarePositions withDeck: aDeck [

	^ self new
		  initializeInSize: aSize
		  rounds: aRoundNumber
		  with: aDiceSet
		  and: aSetOfShips
		  withSpecialSquaresAt: squarePositions
		  withDeck: aDeck.
]

{ #category : 'accessing' }
ShipBattleGame >> boardState [

	| currentGameState rankedList tempShipsList |
	
	currentGameState := OrderedDictionary new.
	tempShipsList := ships copy.

	rankedList := tempShipsList sort: [ :shipA :shipB |
		              self compareProgressOf2Ships: shipA and: shipB ].

	rankedList doWithIndex: [ :ship :i |
		currentGameState
			at: i printString , '°'
			put: (Dictionary newFrom: {
						 ('name' -> ship name).
						 ('position' -> ship position).
						 ('lap' -> ship laps) })].

	^ currentGameState
]

{ #category : 'accessing' }
ShipBattleGame >> boardStateWithCards [

	| currentGameState rankedList tempShipsList |
	
	currentGameState := OrderedDictionary new.
	tempShipsList := ships copy.

	rankedList := tempShipsList sort: [ :shipA :shipB |
		              self compareProgressOf2Ships: shipA and: shipB ].

	rankedList doWithIndex: [ :ship :i |
		currentGameState
			at: i printString , '°'
			put: (Dictionary newFrom: {
						 ('name' -> ship name).
						 ('position' -> ship position).
						 ('lap' -> ship laps) .
						 ('card count' -> ship cards size) })].

	^ currentGameState
]

{ #category : 'game controls' }
ShipBattleGame >> breakShieldsOfAllShips [

	ships do: [ :ship | ship loseShield ]
]

{ #category : 'accessing' }
ShipBattleGame >> cardsOf: aShip [

	| aSearchedShip |
	aSearchedShip :=	ships detect: [ :ship | ship = aShip ].
	^ aSearchedShip cards copy
]

{ #category : 'comparing' }
ShipBattleGame >> compareProgressOf2Ships: shipA and: shipB [

	^ shipA laps > shipB laps or: [ "Comparo primero numero de vueltas, si son iguales paso a posicion en el tablero."
		  shipA laps = shipB laps and: [ shipA position > shipB position ] ]
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
		         withRandomSpecialSquaresAndSize: aSize
		         rounds: aRoundNumber.

	diceSet := DiceSet withDice: aDiceSet.

	ships := self orderShips: aSetOfShips.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil
]

{ #category : 'initialization' }
ShipBattleGame >> initializeInSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips withSpecialSquaresAt: squarePositions [

	board := CircularBoard
		         withSize: aSize
		         rounds: aRoundNumber
		         withSpecialSquaresAt: squarePositions.

	diceSet := DiceSet withDice: aDiceSet.

	ships := self orderShips: aSetOfShips.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil
]

{ #category : 'initialization' }
ShipBattleGame >> initializeInSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips withSpecialSquaresAt: squarePositions withDeck: aDeck [

	board := CircularBoard
		         withSize: aSize
		         rounds: aRoundNumber
		         withSpecialSquaresAt: squarePositions.

	diceSet := DiceSet withDice: aDiceSet.

	ships :=  aSetOfShips collect: [ :ship | ship addCards: (OrderedCollection 
																					with: aDeck drawCard 
																					with: aDeck drawCard) ].

	cardManager := CardManager
		               ships: ships
		               board: board
		               deck: aDeck.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil
]

{ #category : 'accessing' }
ShipBattleGame >> manager [
	^ cardManager 
]

{ #category : 'game controls' }
ShipBattleGame >> move: aShip byParsecs: anAmountOfParsecs [

	| spacesToMove |
	
	spacesToMove := (anAmountOfParsecs / board getParsecRatio) floor.
	aShip withNoEffectsMove: spacesToMove onCircularBoard: board
]

{ #category : 'game controls' }
ShipBattleGame >> moveAllShipsBackToStart [

	ships do: [ :ship | ship moveTo: (board getSquareAt: 1) ]
]

{ #category : 'game controls' }
ShipBattleGame >> moveAllShipsBy: numberToMove exceptFor: exceptionShip [

	ships do: [ :ship |
		ship ~= exceptionShip ifTrue: [
			ship moveBy: numberToMove onCircularBoard: board of: self ] ]
]

{ #category : 'game controls' }
ShipBattleGame >> nextTurn [

	| currentShip |
	
	self canIKeepPlaying.

	currentShip := ships at: shipToMove.

	currentShip canIPlayTurn
		ifTrue: [ self playTurnOf: currentShip ]
		ifFalse: [ currentShip turnSkipped ].

	shipToMove := shipToMove \\ ships size + 1
]

{ #category : 'card usage' }
ShipBattleGame >> playCard: aCard by: aShip [ 

	self playCard: aCard by: aShip target: aShip
]

{ #category : 'card usage' }
ShipBattleGame >> playCard: aCard by: aShip target: aTarget [
	
	self canIKeepPlaying.
	
	cardManager playCard: aCard by: aShip target: aTarget
]

{ #category : 'game controls' }
ShipBattleGame >> playTurnOf: currentShip [

	| shipToFight |
	
	currentShip moveBy: diceSet roll onCircularBoard: board of: self.

	self haveWeGotAWinner: currentShip.

	shipToFight := self whoDoIFight: currentShip.

	shipToFight ifNotNil: [
		self fightBetween: currentShip and: shipToFight ]
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
	shipToFight := ships select: [ :ship | "Devuelvo toda nave que este en el cuadrado de thisShip excluyendo a thisShip en si misma"
		               ship position = thisShip position and:
			               ship ~= thisShip ].

	shipToFight ifNotEmpty: [ returnValue := shipToFight atRandom ]. "Devuelvo una nave random del cuadrado para pelear"

	^ returnValue
]
