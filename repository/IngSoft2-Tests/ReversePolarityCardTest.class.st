Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ReversePolarityCardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnAtomicBombNothingHappensWhenActivated [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 4. 3 }) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('AtomicBombs' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aGame nextTurn. "Mueve jorge"

	aDeck := aGame cardsOf: julianShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: julianShip targetPosition: 4. "Aplico reversePolarity en la bomba del casillero 4"

	aGame nextTurn. "Mueve julian"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
				
	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 3.

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnAtomicBombTwiceItsEffectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('AtomicBombs' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en la bomba del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult.

	aGame playCard: aReversePolarityCard by: julianShip targetPosition: 4. "Aplico reversePolarity de nuevo en la bomba  del casillero 4"
	aGame nextTurn. "Mueve julian, cae y se activa la bomba"

	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: jorgeShip remainingShields equals: 2.
	self assert: julianShip remainingShields equals: 2.

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnBlackHoleIfShipThatIsMovedBackFallsOnAnotherSpecialSquareItsEffectIsNotApplied [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('BlackHoles' -> { 4 }) . ('AtomicBombs' -> { 7 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.
	
	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el blackhole del casillero 4"
	
	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 7).
				 ('lap' -> 0).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnBlackHoleItsEffectIsReversed [

	| aGame expectedResult jorgeShip julianShip bobShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('BlackHoles' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el blackhole del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
				
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 7).
				 ('lap' -> 0).
				 ('card count' -> 2) }).
				
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 7).
				 ('lap' -> 0).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnBlackHoleOtherBlackHolesAreNotAffected [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('BlackHoles' -> { 4 . 2 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.
	
	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 2. "Aplico reversePolarity en el blackhole del casillero 2"
	
	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 10).
				 ('lap' -> 0).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnBlackHoleThriceItsEffectIsReversed [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3 }) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('BlackHoles' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el blackhole del casillero 4"
	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el blackhole del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
				
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 10).
				 ('lap' -> 0).
				 ('card count' -> 0) }).

	self assert: aGame boardStateWithCards equals: expectedResult.

	aGame playCard: aReversePolarityCard by: julianShip targetPosition: 4. "Aplico reversePolarity de nuevo en el blackhole del casillero 4"
	aGame nextTurn. "Mueve julian"
	
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 6).
				 ('lap' -> 0).
				 ('card count' -> 0) }).
				
	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnBlackHoleTwiceItsEffectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 7 }) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('BlackHoles' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el blackhole del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 7).
				 ('lap' -> 0).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult.

	aGame playCard: aReversePolarityCard by: julianShip targetPosition: 4. "Aplico reversePolarity de nuevo en el blackhole del casillero 4"
	aGame nextTurn. "Mueve julian"
	
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 10).
				 ('lap' -> 0).
				 ('card count' -> 1) }).
				
	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnCardGiverItsEffectIsReversed [

	| aGame expectedResult jorgeShip bobShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('CardGivers' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el card giver del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 3) }).

	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 3) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnCardGiverTwiceItsEffectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('CardGivers' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el card giver del casillero 4"
	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el card giver del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnHyperJumpItsEffectIsReversed [

	| aGame expectedResult jorgeShip bobShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperJumps' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el HyperJump del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 6).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 6).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
				
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnHyperJumpTwiceItsEffectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperJumps' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el HyperJump del casillero 4"
	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el HyperJump del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 9).
				 ('lap' -> 1).
				 ('card count' -> 0) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnHyperSpaceJumpItsEffectIsReversed [

	| aGame expectedResult jorgeShip bobShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperSpaceJumps' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el HyperSpaceJump del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
				
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 2.
	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnHyperSpaceJumpTwiceItsEffectStaysTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperSpaceJumps' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el HyperSpaceJump del casillero 4"
	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el HyperSpaceJump del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 0) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: jorgeShip remainingShields equals: 2.
	self assert: julianShip remainingShields equals: 3.
	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnMoonWalkItsEffectIsReversed [

	| aGame expectedResult jorgeShip bobShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('MoonWalks' -> { { 4. 5 } }) })
		         withDeck: (LoadedDeck cards: cardsToDraw). "Moonwalks de 5, {posicion, N}"

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el MoonWalk del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
	
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
				
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 9).
				 ('lap' -> 0).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnMoonWalkTwiceItsEffectStayTheSame [

	| aGame expectedResult jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('MoonWalks' -> { { 4. 5 } }) }) "Moonwalks de 5, {posicion, N}"
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el MoonWalk del casillero 4"
	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el MoonWalk del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 0) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 6).
				 ('lap' -> 0).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnWormHoleItsEffectIsReversed [

	| aGame expectedResult jorgeShip bobShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 4. 8 } }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el wormhole del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testAfterUsingReversePolarityCardOnWormHoleTwiceItsEffectStaysTheSame [

	| aGame expectedResult jorgeShip bobShip julianShip aDeck aReversePolarityCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 4. 8 } }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.

	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el wormhole del casillero 4"
	aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 4. "Aplico reversePolarity en el wormhole del casillero 4"

	aGame nextTurn. "Mueve jorge"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 0) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Bob').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testCannotUseReversePolarityCardOnEmptySquare [

	| aGame jorgeShip julianShip aDeck aReversePolarityCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('BlackHoles' -> { 4 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aReversePolarityCard := aDeck first.
	
	self
		should: [ aGame playCard: aReversePolarityCard by: jorgeShip targetPosition: 3 ]
		raise: Error
		withErrorMessage: 'Cannot reverse the polarity of an empty square!'
]

{ #category : 'basic tests' }
ReversePolarityCardTest >> testReversePolarityCardCannotBePlayedOutsideOfPlayersTurn [

	| aGame expectedResult jorgeShip julianShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: ReversePolarityCard new.
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
