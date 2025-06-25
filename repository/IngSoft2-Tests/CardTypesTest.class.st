Class {
	#name : 'CardTypesTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTypesTest >> testWhenCardIsPlayedThenItIsUsed [

	| aGame expectedResult jorgeShip aDeck aCard cardsToDraw |
	

	cardsToDraw := OrderedCollection with: SpeedCard new.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: { jorgeShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { })
					withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.
	
	aGame playCard: aCard by: jorgeShip. 

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1)}).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
CardTypesTest >> testWhenSpeedCardIsPlayedThenItIsUsedAndShipMoves1MoreSquare [
	| aGame expectedResult jorgeShip aDeck aCard cardsToDraw |
	

	cardsToDraw := OrderedCollection with: SpeedCard new.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: { jorgeShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { })
					withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.
	
	aGame playCard: aCard by: jorgeShip. 
	aGame nextTurn.
	
	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1)}).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
CardTypesTest >> testWhenSpeedCardIsPlayedThenItIsUsedAndShipMoves1MoreSquareInVariousTurns [

	| aGame expectedResult jorgeShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: SpeedCard new.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: { jorgeShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { })
					withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.
	
	aGame playCard: aCard by: jorgeShip. 
	aGame nextTurn.
	aGame nextTurn.
	
	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 9).
				 ('lap' -> 1).
				 ('card count' -> 1)}).

	self assert: aGame boardStateWithCards equals: expectedResult
]
