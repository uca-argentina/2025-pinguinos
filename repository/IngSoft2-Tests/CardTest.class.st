Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> testWhenCardGiverAtPosition2ThenShipGetsCardsAddedToTheirCount [

	| aGame expectedResult cardsToDraw |
	
	cardsToDraw := OrderedCollection with: SpeedCard new.
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { Ship named: 'Jorge' }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('CardGivers' -> { 2 })})
					withDeck: (LoadedDeck cards: cardsToDraw).

	aGame nextTurn.

   "self assert: 'Jorge' cards size equals: 2."

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 2).
				 ('lap' -> 1) .
				 ('card count' -> 3)}).
				
	self assert: aGame boardStateWithCards equals: expectedResult 
]

{ #category : 'running' }
CardTest >> testWhenShipIsCreatedByAGameThenItHasTwoRandomCards [

	| aGame expectedResult jorgeShip cardsToDraw |
	

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

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2)}).

	self assert: aGame boardStateWithCards equals: expectedResult
]
