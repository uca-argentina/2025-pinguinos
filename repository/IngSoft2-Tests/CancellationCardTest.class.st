Class {
	#name : 'CancellationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
CancellationCardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
CancellationCardTest >> testCancellationCardCanBeUsedCorrectlyOnAnActiveCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aCancellationCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: CancellationCard new.
	cardsToDraw add: SpeedCard new. "Cancellation y speed para Julian, y dos speed para JOrge."
			
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
	aCancellationCard := aDeck first.

	aGame playCard: aCancellationCard by: julianShip target: aSpeedCard. "Julian juega Cancellation sobre el SpeedCard de Jorge"
	aGame nextTurn. "julian mueve a 4"

	aGame nextTurn. "jorge mueve a 8"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
CancellationCardTest >> testCancellationCardCanBeUsedCorrectlyOnAnActiveMercenaryCard [

	| aGame jorgeShip julianShip bobShip aDeck aMercenaryCard aCancellationCard cardsToDraw expectedResult |
	cardsToDraw := OrderedCollection new.
	"Jorge"
	cardsToDraw add: MercenaryCard new.
	cardsToDraw add: SpeedCard new.

	cardsToDraw add: CancellationCard new.
	cardsToDraw add: SpeedCard new. "Cancellation y speed para Julian,"

	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	bobShip := Ship named: 'Bob'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 3. 2. 1 }) }
		         and: {
				         jorgeShip.
				         julianShip.
				         bobShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aMercenaryCard := aDeck first.
	aGame playCard: aMercenaryCard by: jorgeShip target: bobShip. "Jorge contrata a bob"

	aGame nextTurn. "jorge mueve a 4"

	aDeck := aGame cardsOf: julianShip.
	aCancellationCard := aDeck first.
	aGame
		playCard: aCancellationCard
		by: julianShip
		target: aMercenaryCard. "Julian juega Cancellation sobre el contrato de Jorge con bob"

	aGame nextTurn. "julian mueve a 4 y pelea con jorge que no es ayudado por bob y gana 2 a 1"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: jorgeShip remainingShields equals: 2.
	self assert: julianShip remainingShields equals: 3.
	self assert: bobShip remainingShields equals: 3.

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
CancellationCardTest >> testCancellationCardCanBeUsedEvenWhenItsNotYourTurn [

	| aGame jorgeShip julianShip aDeck aSpeedCard aCancellationCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: CancellationCard new.
	cardsToDraw add: SpeedCard new. "Cancellation y speed para Julian, y dos speed para JOrge."
			
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
	aCancellationCard := aDeck first.
	aGame playCard: aCancellationCard by: julianShip target: aSpeedCard. "Julian juega Cancellation sobre el SpeedCard de Jorge"
	aGame nextTurn. "jorge mueve a 4"

	aGame nextTurn. "julian mueve a 4"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
CancellationCardTest >> testCancellationCardCantBeUsedOnAnInactiveCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aCancellationCard cardsToDraw |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: CancellationCard new.
	cardsToDraw add: SpeedCard new. "Cancellation y speed para Julian, y dos speed para JOrge."
	
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
	
	aDeck := aGame cardsOf: julianShip.
	aCancellationCard := aDeck first.
	
	self
		should: [ aGame playCard: aCancellationCard by: julianShip target: aSpeedCard. ]
		raise: Error
		withErrorMessage: 'The selected card is not active at the moment, so it cannot be removed!'.
	



]

{ #category : 'tests' }
CancellationCardTest >> testCancellationCardCantBeUsedWhenThereAreNoActivePermanentCards [

	| aGame jorgeShip julianShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: CancellationCard new.
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
		should: [ aGame playCard: aCard by: jorgeShip target: SpeedCard new ]
		raise: Error
		withErrorMessage: 'The selected card is not active at the moment, so it cannot be removed!'.
	



]
