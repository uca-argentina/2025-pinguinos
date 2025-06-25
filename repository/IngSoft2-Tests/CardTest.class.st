Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
CardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
CardTest >> testShipCannotPlayCardItDoesntHave [

	| aGame jorgeShip cardsToDraw |
	
	cardsToDraw := OrderedCollection with: SpeedCard new.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: { jorgeShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	self
		should: [ aGame playCard: SpeedCard new by: jorgeShip ]
		raise: Error
		withErrorMessage:
		'This ship cannot play this card because it does not have it!'
]

{ #category : 'tests' }
CardTest >> testWhenCardGiverAtPosition2ThenShipGetsCardsAddedToTheirCount [

	| aGame expectedResult cardsToDraw aShip |
	
	aShip := Ship named: 'Jorge'.

	cardsToDraw := OrderedCollection with: SpeedCard new.
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { aShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('CardGivers' -> { 2 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	self assert: aShip cards size equals: 2.

	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 2).
				 ('lap' -> 1).
				 ('card count' -> 3) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
CardTest >> testWhenCardIsPlayedThenItIsUsed [

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
