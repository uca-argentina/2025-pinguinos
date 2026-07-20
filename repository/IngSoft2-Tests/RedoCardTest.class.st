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
RedoCardTest >> testRedoCardCanBeUsedCorrectlyOnLastPlayedAccelerationCard [

	| aGame jorgeShip julianShip aDeck anAccelerationCard aRedoCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: AccelerationCard new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: RedoCard new.
	cardsToDraw add: RedoCard new. "2 Redo para Julian, y 1 acceleration y 1 speed para JOrge."
			
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
	anAccelerationCard := aDeck first.

	aGame playCard: anAccelerationCard by: jorgeShip. "Jorge juega AccelerationCard"
	aGame nextTurn. "jorge mueve a 5"

	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.

	aGame playCard: aRedoCard by: julianShip. "Julian juega Redo y por ende AccelerationCard"
	aGame nextTurn. "julian mueve a 6"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 6).
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
RedoCardTest >> testRedoCardCanBeUsedCorrectlyOnLastPlayedCancellationCard [

	| aGame jorgeShip julianShip joseShip aDeck aCancellationCard aSpeedCard anAccelerationCard aRedoCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.

	cardsToDraw add: AccelerationCard new. "Jorge"
	cardsToDraw add: SpeedCard new. "Jorge"
	cardsToDraw add: RedoCard new. "Julian"
	cardsToDraw add: RedoCard new. "Julian"
	cardsToDraw add: CancellationCard new. "Jose"
	cardsToDraw add: SpeedCard new. "Jose"

	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	anAccelerationCard := aDeck first.
	aSpeedCard := aDeck second.
	aGame playCard: anAccelerationCard by: jorgeShip. "Jorge juega AccelerationCard"
	aGame playCard: aSpeedCard by: jorgeShip target: julianShip. "Jorge juega speed sobre si julian"
	aGame nextTurn. "jorge mueve a 5"
	
	aDeck := aGame cardsOf: joseShip.
	aCancellationCard := aDeck first.
	aGame playCard: aCancellationCard by: joseShip target: anAccelerationCard. "Jose juega Cancellation card sobre la acceleration de jorge"
	
	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.

	aGame playCard: aRedoCard by: julianShip target: aSpeedCard. "Julian juega Redo y por ende cancellation y con ella cancela la speed de Jorge"
	aGame nextTurn. "julian mueve a 4"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 0) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Jose').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardCanBeUsedCorrectlyOnLastPlayedMercenaryCard [

	| aGame jorgeShip julianShip aDeck aMercenaryCard aRedoCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: MercenaryCard new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: RedoCard new.
	cardsToDraw add: RedoCard new. "2 Redo para Julian, y 1 mercenary y 1 speed para JOrge."
			
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: {3. 3. 1. 3}) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aMercenaryCard := aDeck first.

	aGame playCard: aMercenaryCard by: jorgeShip target: julianShip. "Jorge juega mercenary con julian"
	aGame nextTurn. "jorge mueve a 4"

	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.

	aGame playCard: aRedoCard by: julianShip target: jorgeShip. "Julian juega Redo y por ende mercenary sobre jorge"
	aGame nextTurn. "julian mueve a 4 y no pelea"

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

	self assert: aGame boardStateWithCards equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 3.
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardCanBeUsedCorrectlyOnLastPlayedReversalCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aReversalCard aRedoCard cardsToDraw expectedResult |
	cardsToDraw := OrderedCollection new.

	cardsToDraw add: SpeedCard new. "Jorge"
	cardsToDraw add: SpeedCard new. "Jorge"
	
	cardsToDraw add: RedoCard new. "Julian"
	cardsToDraw add: ReversalCard new. "Julian"

	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 2. 5 }) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aSpeedCard := aDeck second.

	aGame playCard: aSpeedCard by: jorgeShip. "Jorge juega speedcard"

	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.
	aReversalCard := aDeck second.

	aGame playCard: aReversalCard by: julianShip target: aSpeedCard.
	
	aGame nextTurn. "jorge mueve 2-1=1 a 2"
	
	aGame playCard: aRedoCard by: julianShip target: aSpeedCard. 

	aGame nextTurn. "julian mueve a 6"
	
	aGame nextTurn. "jorge mueve 2+1=3 a 5"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 6).
				 ('lap' -> 1).
				 ('card count' -> 0) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardCanBeUsedCorrectlyOnLastPlayedReversePolarityCard [

	| aGame jorgeShip julianShip aDeck aSpeedCard aReversePolarityCard aRedoCard cardsToDraw expectedResult |
	cardsToDraw := OrderedCollection new.

	cardsToDraw add: ReversePolarityCard new. "Jorge"
	cardsToDraw add: SpeedCard new. "Jorge"
	cardsToDraw add: RedoCard new. "Julian"
	cardsToDraw add: RedoCard new. "Julian"

	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 2. 5 }) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('BlackHoles' -> { 4. 6 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.
	aSpeedCard := aDeck second.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Jorge juega ReversePolarity en el blackhole"
	aGame nextTurn. "jorge mueve a 3"

	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.

	aGame playCard: aRedoCard by: julianShip targetPosition: 6. "julian juega redo card sobre y por ende reversepolarity y revierte al blakhole de 6"

	aGame nextTurn. "julian mueve al blackhole en 6"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 6).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 9).
				 ('lap' -> 0).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
RedoCardTest >> testRedoCardCanBeUsedCorrectlyOnLastPlayedSpeedCard [

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
RedoCardTest >> testRedoCardCanBeUsedInCorrectlyOnLastPlayedMercenaryCard [

	| aGame jorgeShip julianShip aDeck aMercenaryCard aRedoCard cardsToDraw |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: MercenaryCard new.
	cardsToDraw add: SpeedCard new.
	cardsToDraw add: RedoCard new.
	cardsToDraw add: RedoCard new. "2 Redo para Julian, y 1 mercenary y 1 speed para JOrge."
			
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: {3. 3. 1. 3}) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aMercenaryCard := aDeck first.

	aGame playCard: aMercenaryCard by: jorgeShip target: julianShip. "Jorge juega mercenary con julian"
	aGame nextTurn. "jorge mueve a 4"

	aDeck := aGame cardsOf: julianShip.
	aRedoCard := aDeck first.

	 "Julian juega Redo y por ende mercenary pero intenta auto contratarse"
	self
		should: [ aGame playCard: aRedoCard by: julianShip target: julianShip ]
		raise: Error
		withErrorMessage:
		'A ship cannot contract itself as a mercenary!'.
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
		'No cards have been played yet!'.

	self assert: (aGame cardsOf: jorgeShip) size equals: 2
]
