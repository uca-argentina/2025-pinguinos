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

	| aBoardBuilder probabilityDistribution aNullDeck |
	
	aNullDeck := NullDeck new.
	probabilityDistribution := Dictionary new.

	probabilityDistribution at: 'EmptySquare' put: 30.
	probabilityDistribution at: 'BlackHole' put: 20.
	probabilityDistribution at: 'HyperSpaceJump' put: 20.
	probabilityDistribution at: 'MoonWalk' put: 10.
	probabilityDistribution at: 'HyperJump' put: 8.
	probabilityDistribution at: 'AtomicBomb' put: 2.
	probabilityDistribution at: 'CardGiver' put: 10.
	
	aBoardBuilder := CircularBoardBuilder new.
	
	aBoardBuilder setNumberOfRounds: aRoundNumber.
	aBoardBuilder setBoardSize: aSize.
	aBoardBuilder setSquareProbabilities: probabilityDistribution.
	aBoardBuilder setDeck: aNullDeck.
	
	^ self new
		  initializeInBoard: aBoardBuilder build
		  with: aDiceSet
		  and: aSetOfShips
		  withDeck: aNullDeck
]

{ #category : 'instance creation' }
ShipBattleGame class >> inSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips withSpecialSquaresAt: squarePositions [

	| aBoardBuilder aNullDeck |
	
	aBoardBuilder := CircularBoardBuilder new.
	aNullDeck := NullDeck new.
	
	aBoardBuilder setNumberOfRounds: aRoundNumber.
	aBoardBuilder setBoardSize: aSize.
	aBoardBuilder setDeck: aNullDeck.
	aBoardBuilder setSquares: squarePositions.
	
	^ self new
		  initializeInBoard: aBoardBuilder build
		  with: aDiceSet
		  and: aSetOfShips
		  withDeck: aNullDeck
]

{ #category : 'accessing' }
ShipBattleGame class >> inSize: aSize rounds: aRoundNumber with: aDiceSet and: aSetOfShips withSpecialSquaresAt: squarePositions withDeck: aDeck [

	| aBoardBuilder |
	
	aBoardBuilder := CircularBoardBuilder new.
	
	aBoardBuilder setNumberOfRounds: aRoundNumber.
	aBoardBuilder setBoardSize: aSize.
	aBoardBuilder setDeck: aDeck.
	aBoardBuilder setSquares: squarePositions.
	
	^ self new
		  initializeInBoard: aBoardBuilder build
		  with: aDiceSet
		  and: aSetOfShips
		  withDeck: aDeck 
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

{ #category : 'game controls' }
ShipBattleGame >> breakShieldsOfAllShipsExceptFor: exceptionShip [

	ships do: [ :ship |
		ship ~= exceptionShip ifTrue: [ ship loseShield ] ]
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

{ #category : 'card usage' }
ShipBattleGame >> drawCardFor: aShip [

	aShip receive: (cardManager drawCard)
]

{ #category : 'card usage' }
ShipBattleGame >> drawCardsForEveryoneExceptFor: anExceptionShip [

	ships do: [ :ship |
		ship ~= anExceptionShip ifTrue: [
			ship receive: cardManager drawCard ] ]
]

{ #category : 'game controls' }
ShipBattleGame >> fightBetween: aggressorShip and: defendingShip [

	| aggresorAllyShips defendingAllyShips aggresorShipsDiceRoll defendingShipsDiceRoll |
	
	aggresorAllyShips := cardManager getAlliesOf: aggressorShip against: defendingShip.
	defendingAllyShips := cardManager getAlliesOf: defendingShip against: aggressorShip.

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
	
	defendingShip := self whoDoIFight: anAggressorShip.
	contractedShips := cardManager getAlliesOf: anAggressorShip against: defendingShip.

	defendingShip ifNotNil: [
		shipsContractedByDefendingShip := cardManager getAlliesOf: defendingShip against: anAggressorShip.
		
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

{ #category : 'game controls' }
ShipBattleGame >> hyperJump: aShip byParsecs: parsecsToMove [

	| spacesToMove |
	
	spacesToMove := (board sizeInParsecs / parsecsToMove) convertToCellUnits floor.
	aShip withNoEffectsMoveBy: spacesToMove value onCircularBoard: board
]

{ #category : 'game controls' }
ShipBattleGame >> hyperJumpEveryoneExcept: anExceptionShip byParsecs: parsecsToMove [

	| spacesToMove |
	spacesToMove := (board sizeInParsecs / parsecsToMove)
		                convertToCellUnits floor.

	ships do: [ :ship |
		ship ~= anExceptionShip ifTrue: [
			ship withNoEffectsMoveBy: spacesToMove value onCircularBoard: board ] ]
]

{ #category : 'initialization' }
ShipBattleGame >> initializeInBoard: aBoard with: aDiceSet and: aSetOfShips withDeck: aDeck [

	board := aBoard.
	diceSet := DiceSet withDice: aDiceSet.
	
	ships := self orderShips: aSetOfShips.
	ships := aSetOfShips collect: [ :ship |
			         ship addCards:
				         (OrderedCollection
					          with: aDeck drawCard
					          with: aDeck drawCard) ].

	cardManager := CardManager
		               ships: ships
		               board: board
		               deck: aDeck
		               game: self.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil
]

{ #category : 'accessing' }
ShipBattleGame >> manager [
	^ cardManager 
]

{ #category : 'game controls' }
ShipBattleGame >> moveAllShipsBackToStart [

	ships do: [ :ship | ship moveTo: (board getSquareAt: 1) ]
]

{ #category : 'game controls' }
ShipBattleGame >> moveAndIgnoreNewEffectsAllShipsBy: numberToMove exceptFor: exceptionShip [

	ships do: [ :ship |
		ship ~= exceptionShip ifTrue: [
			self moveAndIgnoreNewEffectsShip: ship by: numberToMove ] ]
]

{ #category : 'game controls' }
ShipBattleGame >> moveAndIgnoreNewEffectsShip: aShip by: aNumberToMove [

	aShip withNoEffectsMoveBy: aNumberToMove onCircularBoard: board.
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

	self validateAndPlayCard: aCard from: aShip target: aShip
]

{ #category : 'card usage' }
ShipBattleGame >> playCard: aCard by: aShip target: aTarget [

	self validateAndPlayCard: aCard from: aShip target: aTarget
]

{ #category : 'card usage' }
ShipBattleGame >> playCard: aCard by: aShip targetPosition: aPosition [
	
	| actualTarget |
	
	actualTarget := board getSquareAt: aPosition.
	
	self validateAndPlayCard: aCard from: aShip target: actualTarget
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

{ #category : 'card usage' }
ShipBattleGame >> validateAndPlayCard: aCard from: aShip target: aTarget [
	
	self canIKeepPlaying.
	self can: aShip playThisCard: aCard.
	
	cardManager playCard: aCard by: aShip target: aTarget.
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
