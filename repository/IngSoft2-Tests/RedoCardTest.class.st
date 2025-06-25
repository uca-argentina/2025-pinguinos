Class {
	#name : 'RedoCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
RedoCardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardCanBeUsedCorrectlyEvenIfItsNotYourTurn [

	| aGame jorgeShip julianShip aDeck aSpeedCard aRedoCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: RedoCard new.
	cardsToDraw add: RedoCard new. "2 Redo para Julian, y una speed y una redo para JOrge."
			
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
	aSpeedCard := aDeck first.
	aGame playCard: aSpeedCard by: jorgeShip. "Jorge juega SpeedCard sobre el mismo"
	
	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.
	aGame playCard: aRedoCard by: julianShip target: julianShip. "Julian juega Redo y por ende Speedcard sobre el mismo"
	
	aGame nextTurn. "jorge mueve a 5"
	aGame nextTurn. "julian mueve a 5"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardCanBeUsedCorrectlyEvenIfLastPlayedCardIsAnotherRedo [

	| aGame jorgeShip julianShip aDeck aSpeedCard aRedoCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: RedoCard new.
	cardsToDraw add: RedoCard new.
	cardsToDraw add: RedoCard new. "2 Redo para Julian, y una speed y una redo para JOrge."
			
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
	aSpeedCard := aDeck first.
	aGame playCard: aSpeedCard by: jorgeShip. "Jorge juega SpeedCard sobre el mismo"
	
	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.
	aGame playCard: aRedoCard by: julianShip target: julianShip. "Julian juega Redo y por ende Speedcard sobre el mismo"
	
	aGame nextTurn. "jorge mueve a 5"
	aGame nextTurn. "julian mueve a 5"
	
	aDeck := aGame cardsOf: jorgeShip.
	aRedoCard := aDeck first.
	aGame playCard: aRedoCard by: jorgeShip target: jorgeShip. "Jorge juega Redo y por ende redo y por ende speedcard de nuevo sobre el mismo"
	
	aGame nextTurn. "Jorge mueve a 10"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 10).
				 ('lap' -> 1).
				 ('card count' -> 0) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardCanBeUsedCorrectlyOnLastPlayedCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aRedoCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: RedoCard new.
	cardsToDraw add: RedoCard new. "2 Redo para Julian, y dos speed para JOrge."
			
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
	aSpeedCard := aDeck first.

	aGame playCard: aSpeedCard by: jorgeShip. "Jorge juega SpeedCard sobre el mismo"
	aGame nextTurn. "jorge mueve a 5"

	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.

	aGame playCard: aRedoCard by: julianShip target: julianShip. "Julian juega Redo y por ende Speedcard sobre el mismo"
	aGame nextTurn. "julian mueve a 5"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardCantBeUsedWhenNoCardsHaveBeenPlayed [

	| aGame jorgeShip julianShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: RedoCard new.
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

	self
		should: [ aGame playCard: aCard by: jorgeShip ]
		raise: Error
		withErrorMessage:
		'No cards have been played yet, this card cannot be used!'.

	self assert: (aGame cardsOf: jorgeShip) size equals: 2
]
