Class {
	#name : 'ReversalCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ReversalCardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
ReversalCardTest >> testReversalCardCanBeUsedCorrectlyEvenWhenItsNotYourTurn [

	| aGame jorgeShip julianShip aDeck aSpeedCard aReversalCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	
	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	
	"cartas Julian"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.
			
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
	aReversalCard := aDeck first.
	aGame playCard: aReversalCard by: julianShip target: aSpeedCard. "Julian juega ReversalCard sobre el SpeedCard de Jorge"
	
	aGame nextTurn. "jorge se mueve 3-1 espacios a 3"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'tests' }
ReversalCardTest >> testReversalCardCanBeUsedCorrectlyOnAnActiveAccelerationCard [

	| aGame jorgeShip julianShip bobShip aDeck aSpeedCard anAccelerationCard aReversalCard cardsToDraw expectedResult |
	cardsToDraw := OrderedCollection new.

	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.

	"cartas Julian"
	cardsToDraw add: AccelerationCard new.
	cardsToDraw add: SpeedCard new.

	"cartas bob"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.

	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	bobShip := Ship named: 'Bob'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip.
				         bobShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aSpeedCard := aDeck first.
	aGame playCard: aSpeedCard by: jorgeShip. "Jorge juega SpeedCard sobre el mismo"
	
	aGame nextTurn. "jorge se mueve 3+1 espacios a 5"

	aDeck := aGame cardsOf: julianShip.
	anAccelerationCard := aDeck first.
	aGame playCard: anAccelerationCard by: julianShip. "Julian juega AccelerationCard sobre todos"
	
	aDeck := aGame cardsOf: bobShip.
	aReversalCard := aDeck first.
	aGame playCard: aReversalCard by: bobShip target: anAccelerationCard. "Bob juega ReversalCard sobre el acceleration de Jorge"
	
	aGame nextTurn. "julian mueve 3-1 espacios a 3"
	aGame nextTurn. "bob mueve 3-1 espacios a 3"
	aGame nextTurn. "Jorge mueve 3+1-1=3 espacios a 8"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
ReversalCardTest >> testReversalCardCanBeUsedCorrectlyOnAnActiveMercenaryCard [

	| aGame jorgeShip julianShip bobShip aDeck aMercenaryCard aReversalCard cardsToDraw expectedResult |
	cardsToDraw := OrderedCollection new.

	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.

	"cartas Julian"
	cardsToDraw add: MercenaryCard new.
	cardsToDraw add: SpeedCard new.

	"cartas bob"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.

	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	bobShip := Ship named: 'Bob'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 4. 4. 2. 3. 4 }) }
		         and: {
				         jorgeShip.
				         julianShip.
				         bobShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw). "2 para bob, 3 para jorge y 4 para julian"

	aGame nextTurn. "jorge se mueve 3 espacios a 4"

	aDeck := aGame cardsOf: julianShip.
	aMercenaryCard := aDeck first.
	aGame playCard: aMercenaryCard by: julianShip target: jorgeShip. "Julian contrata a jorge"

	aDeck := aGame cardsOf: bobShip.
	aReversalCard := aDeck first.
	aGame playCard: aReversalCard by: bobShip target: aMercenaryCard. "Bob juega ReversalCard sobre el contrato de julian a jorge"

	aGame nextTurn. "julian mueve 4 espacios a 5"
	aGame nextTurn. "bob mueve 4 espacios a 5 y pelea con julian, pero jorge lo ayuda a bob"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' ->4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult.

	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 2.
	self assert: bobShip remainingShields equals: 3.
]

{ #category : 'tests' }
ReversalCardTest >> testReversalCardCanBeUsedCorrectlyOnAnActiveSpeedCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aReversalCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	
	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	
	"cartas Julian"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.
			
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
	aGame nextTurn. "jorge se mueve 3+1 espacios a 5"

	aDeck := aGame cardsOf: julianShip.
	aReversalCard := aDeck first.

	aGame playCard: aReversalCard by: julianShip target: aSpeedCard. "Julian juega ReversalCard sobre el SpeedCard de Jorge"
	aGame nextTurn. "julian mueve 3 espacios a 4"

	aGame nextTurn. "jorge mueve 3-1 espacios a 7"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 7).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'tests' }
ReversalCardTest >> testReversalCardCantBeUsedOnAnInactiveCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aReversalCard cardsToDraw |
	
	cardsToDraw := OrderedCollection new.
	
	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.
	
	"cartas Julian"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.
			
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
	aReversalCard := aDeck first.

	self
		should: [ aGame playCard: aReversalCard by: julianShip target: aSpeedCard ]
		raise: Error
		withErrorMessage: 'The selected card is not active at the moment, so it cannot be reversed!'.
	



]

{ #category : 'tests' }
ReversalCardTest >> testWhenReversalIsUsedOnMercenaryMercenaryShipsWillFightTheContractorIfTheyFallOnSameSquare [

	| aGame jorgeShip julianShip bobShip aDeck aMercenaryCard aReversalCard cardsToDraw expectedResult |
	cardsToDraw := OrderedCollection new.

	"cartas jorge"
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: SpeedCard new.

	"cartas Julian"
	cardsToDraw add: MercenaryCard new.
	cardsToDraw add: SpeedCard new.

	"cartas bob"
	cardsToDraw add: ReversalCard new.
	cardsToDraw add: SpeedCard new.

	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	bobShip := Ship named: 'Bob'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 3. 2. 3 }) }
		         and: {
				         jorgeShip.
				         julianShip.
				         bobShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw). "2 para julian, 3 para jorge "


	aGame nextTurn. "jorge se mueve 3 espacios a 4"

	aDeck := aGame cardsOf: julianShip.
	aMercenaryCard := aDeck first.
	aGame playCard: aMercenaryCard by: julianShip target: jorgeShip. "Julian contrata a jorge"

	aDeck := aGame cardsOf: bobShip.
	aReversalCard := aDeck first.
	aGame playCard: aReversalCard by: bobShip target: aMercenaryCard. "Bob juega ReversalCard sobre el contrato de julian a jorge"

	aGame nextTurn. "julian mueve 3 espacios a 4 a donde esta julian y pelean"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult.

	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 2.
	self assert: bobShip remainingShields equals: 3.
]
