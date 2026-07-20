Class {
	#name : 'AccelerationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
AccelerationCardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
AccelerationCardTest >> testAShipCanUseAccelerationCardCorrectlyOnEveryShip [

	| aGame expectedResult jorgeShip julianShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: AccelerationCard new.
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
	aGame playCard: aCard by: jorgeShip.
	
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
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
AccelerationCardTest >> testAccelerationCardCannotBePlayedOutsideOfPlayersTurn [

	| aGame expectedResult jorgeShip julianShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: AccelerationCard new.
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
AccelerationCardTest >> testWhen2AccelerationCardsArePlayedThenTheyAreUsedAndShipMoves2MoreSquares [

	| aGame expectedResult jorgeShip julianShip currentDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: AccelerationCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	currentDeck := aGame cardsOf: jorgeShip.
	aCard := currentDeck first.
	aGame playCard: aCard by: jorgeShip.

	currentDeck := aGame cardsOf: jorgeShip.
	aCard := currentDeck first.
	aGame playCard: aCard by: jorgeShip.

	aGame nextTurn.
	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 6).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 6).
				 ('lap' -> 1).
				 ('card count' -> 0) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenAccelerationCardIsPlayedThenItIsUsedAndItAffectsTheEntireRoll [

	| aGame expectedResult jorgeShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: AccelerationCard new.
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
AccelerationCardTest >> testWhenAccelerationCardIsPlayedThenItIsUsedAndShipMoves1MoreSquareInVariousTurns [

	| aGame expectedResult jorgeShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: AccelerationCard new.
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
