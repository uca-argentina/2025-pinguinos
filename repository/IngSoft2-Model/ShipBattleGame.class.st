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

{ #category : 'testing' }
ShipBattleGame >> can: aShip playThisCard: aCard [

	((ships at: shipToMove) ~= aShip and: aCard isTurnRestricted)
		ifTrue: [
			Error signal:
				'This ship cannot play this card because it is not his turn!' ]
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
ShipBattleGame >> fightBetween: aggressorShip and: defendingShip [

	| aggresorAllyShips defendingAllyShips aggresorShipsDiceRoll defendingShipsDiceRoll |
	
	aggresorAllyShips := cardManager getAlliesOf: aggressorShip.
	defendingAllyShips := cardManager getAlliesOf: defendingShip.

	aggresorShipsDiceRoll := diceSet roll + (aggresorAllyShips
		                          inject: 0
		                          into: [ :runningTotal :aShip |
		                          runningTotal + diceSet roll ]). "Primero tira el equipo del que llega al cuadrado"
	defendingShipsDiceRoll := diceSet roll + (defendingAllyShips
		                           inject: 0
		                           into: [ :runningTotal :aShip |
		                           runningTotal + diceSet roll ]).

	aggresorShipsDiceRoll = defendingShipsDiceRoll ifTrue: [ ^ nil ]. "Si hay empate no pasa nada"
	aggresorShipsDiceRoll > defendingShipsDiceRoll
		ifTrue: [
			defendingShip loseFight.
			defendingAllyShips do: [ :defendingAllyShip |
				defendingAllyShip loseShield ] ]
		ifFalse: [
			aggressorShip loseFight.
			aggresorAllyShips do: [ :aggresorAllyShip |
				aggresorAllyShip loseShield ] ]
]

{ #category : 'helper' }
ShipBattleGame >> handleFights: anAggressorShip [

	| defendingShip contractedShips shipsContractedByDefendingShip |
	
	contractedShips := cardManager getAlliesOf: anAggressorShip.
	defendingShip := self whoDoIFight: anAggressorShip.

	defendingShip ifNotNil: [
		shipsContractedByDefendingShip := cardManager getAlliesOf: defendingShip.
		
		((contractedShips includes: defendingShip) or:
			 (shipsContractedByDefendingShip includes: anAggressorShip))
			ifFalse: [ self fightBetween: anAggressorShip and: defendingShip ] ]
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
	
	cardManager := NullCardManager 
		               ships: ships
		               board: board
		               deck: nil.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil.
]

{ #category : 'initialization' }
ShipBattleGame >> initializeInSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips withSpecialSquaresAt: squarePositions [

	board := CircularBoard
		         withSize: aSize
		         rounds: aRoundNumber
		         withSpecialSquaresAt: squarePositions.

	diceSet := DiceSet withDice: aDiceSet.

	ships := self orderShips: aSetOfShips.
	
	cardManager := NullCardManager 
		               ships: ships
		               board: board
		               deck: nil.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil.
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
	gameWinner := nil.
]

{ #category : 'accessing' }
ShipBattleGame >> manager [
	^ cardManager 
]

{ #category : 'game controls' }
ShipBattleGame >> move: aShip byLightYears: anAmountOfLightYears [

	| spacesToMove |
	spacesToMove := anAmountOfLightYears convertToCellUnits floor.
	aShip withNoEffectsMove: spacesToMove onCircularBoard: board
]

{ #category : 'game controls' }
ShipBattleGame >> move: aShip byParsecs: anAmountOfParsecs [

	| spacesToMove |
	spacesToMove := anAmountOfParsecs convertToCellUnits floor.
	aShip withNoEffectsMove: spacesToMove value onCircularBoard: board
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
	self can: aShip playThisCard: aCard.
	
	cardManager playCard: aCard by: aShip target: aTarget.
]

{ #category : 'game controls' }
ShipBattleGame >> playTurnOf: currentShip [

	| numberToMove |
	
	numberToMove := diceSet roll.
	numberToMove := numberToMove + (cardManager addMovement: currentShip).

	currentShip moveBy: numberToMove onCircularBoard: board of: self.

	self haveWeGotAWinner: currentShip.

	self handleFights: currentShip. 
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
