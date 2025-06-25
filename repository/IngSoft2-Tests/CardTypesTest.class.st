Class {
	#name : 'CardTypesTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
CardTypesTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
CardTypesTest >> testAShipCanUseSpeedCardCorrectlyOnOtherShip [

	| aGame expectedResult jorgeShip julianShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: SpeedCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.
	aGame playCard: aCard by: jorgeShip target: julianShip.
	
	aGame nextTurn. "Mueve jorge"
	aGame nextTurn. "Mueve julian"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
CardTypesTest >> testShipCannotPlayCardItDoesntHave [

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
		should: [ aGame playCard: SpeedCard new by: jorgeShip. ]
		raise: Error
		withErrorMessage:
		'This ship cannot play this card because it does not have it!'.

	
]

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
CardTypesTest >> testWhenSpeedCardCannotBePlayedOutsideOfPlayersTurn [

	| aGame expectedResult jorgeShip julianShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: SpeedCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.

	aGame nextTurn. "Jorge juega su turno"
	
	"Jorge intenta usar carta permanente en turno de otro y falla"
	self
		should: [ aGame playCard: aCard by: jorgeShip ]
		raise: Error
		withErrorMessage: 'This ship cannot play this card because it is not his turn!'.

	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
CardTypesTest >> testWhenSpeedCardIsPlayedThenItIsUsedAndItAffectsTheEntireRoll [

	| aGame expectedResult jorgeShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: SpeedCard new.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: {
				         (LoadedDie withSides: 3).
				         (LoadedDie withSides: 3) }
		         and: { jorgeShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.

	aGame playCard: aCard by: jorgeShip.
	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

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
