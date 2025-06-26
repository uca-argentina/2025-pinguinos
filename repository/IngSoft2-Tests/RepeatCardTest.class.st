Class {
	#name : 'RepeatCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RepeatCardTest >> testWhenLastEffectWasAtomicBombAndUseTheRepeatCardThenShouldApplyTheEffect [

	| aGame jorgeShip aDeck  cardsToDraw expectedResult aRepeatCard juanShip |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: RepeatCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	juanShip := Ship named: 'Juan'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip . juanShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('AtomicBombs' -> { 7 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aRepeatCard := aDeck first.

	aGame nextTurn. "jorge mueve a 4"
	aGame nextTurn. "juan mueve a 7"
	aGame nextTurn. "jorge mueve a 7"
		"Acá se activa atomic bombs"
	aGame nextTurn. "juan mueve a 4"
	aGame playCard: aRepeatCard by: jorgeShip target: juanShip. "Jorge juega RepeatCard"
	aGame nextTurn. "jorge mueve a 4"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Juan').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
RepeatCardTest >> testWhenLastEffectWasBlackHoleSquareAndUseTheRepeatCardThenShouldApplyItsEffect [
	| aGame jorgeShip aDeck  cardsToDraw expectedResult aRepeatCard juanShip |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: RepeatCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	juanShip := Ship named: 'Juan'.

	aGame := ShipBattleGame
		         inSize: 15
		         rounds: 2
		         with: { (LoadedDie withSides: 4) }
		         and: { jorgeShip . juanShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('BlackHoles' -> { 13 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aDeck := aGame cardsOf: jorgeShip.
	aRepeatCard := aDeck first.
	
	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Juan mueve hasta 5"
	aGame nextTurn. "Jorge mueve hasta 9"
	aGame nextTurn. "Juan mueve hasta 9"
	aGame nextTurn. "Jorge mueve hasta 13"
	
	aGame playCard: aRepeatCard by: jorgeShip target: juanShip. "Jorge juega RepeatCard"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 9).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Juan').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'tests' }
RepeatCardTest >> testWhenLastEffectWasCardGiverSquareAndUseTheRepeatCardThenShouldApplyItsEffect [
	| aGame jorgeShip aDeck  cardsToDraw expectedResult aRepeatCard |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: RepeatCard new.
			
	jorgeShip := Ship named: 'Jorge'.

	
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 2) }
		         and: { jorgeShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('CardGivers' -> { 3 . 5 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aDeck := aGame cardsOf: jorgeShip.
	aRepeatCard := aDeck first.
	
	aGame nextTurn. "Jorge mueve hasta 3"
	aGame playCard: aRepeatCard by: jorgeShip. "Jorge juega RepeatCard"
	aGame nextTurn. "Jorge mueve hasta 3"
	
	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 4) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'tests' }
RepeatCardTest >> testWhenLastEffectWasHyperJumpSquareAndUseTheRepeatCardThenShouldApplyItsEffect [
	| aGame jorgeShip aDeck  cardsToDraw expectedResult aRepeatCard |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: RepeatCard new.
			
	jorgeShip := Ship named: 'Jorge'.

	
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 2) }
		         and: { jorgeShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperJumps' -> { 3 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aDeck := aGame cardsOf: jorgeShip.
	aRepeatCard := aDeck first.
	
	aGame nextTurn. "Jorge mueve hasta 3"
	aGame playCard: aRepeatCard by: jorgeShip. "Jorge juega RepeatCard"
	
	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 2).
				 ('lap' -> 2).
				 ('card count' -> 1) }).


	self assert: aGame boardStateWithCards equals: expectedResult.

]

{ #category : 'tests' }
RepeatCardTest >> testWhenLastEffectWasHyperSpaceJumpSquareAndUseTheRepeatCardThenShouldApplyItsEffect [

	| aGame jorgeShip aDeck  cardsToDraw expectedResult aRepeatCard juanShip |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: RepeatCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	juanShip := Ship named: 'Juan'.
	
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { jorgeShip . juanShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperSpaceJumps' -> { 2 }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aDeck := aGame cardsOf: jorgeShip.
	aRepeatCard := aDeck first.
	
	aGame nextTurn. "Jorge mueve hasta 2"
	aGame playCard: aRepeatCard by: jorgeShip target: juanShip. "Jorge juega RepeatCard"
	
	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 6).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Juan').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
	self assert: juanShip remainingShields equals: 2.
]

{ #category : 'tests' }
RepeatCardTest >> testWhenLastEffectWasMoonwalkJumpSquareAndUseTheRepeatCardThenShouldApplyItsEffect [

	| aGame jorgeShip aDeck  cardsToDraw expectedResult aRepeatCard juanShip |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: RepeatCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	juanShip := Ship named: 'Juan'.
	
	aGame := ShipBattleGame
		         inSize: 12
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: { jorgeShip . juanShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('MoonWalks' -> { {7. 2} }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aDeck := aGame cardsOf: jorgeShip.
	aRepeatCard := aDeck first.
	
	aGame nextTurn. "Jorge mueve hasta 4"
	aGame nextTurn. "Juan mueve hasta 4"
	aGame nextTurn. "Jorge mueve hasta 7"
	aGame playCard: aRepeatCard by: jorgeShip target: juanShip. "Jorge juega RepeatCard"
	aGame nextTurn. "Juan mueve hasta 5"
	aGame nextTurn. "Jorge mueve hasta 8"
	
	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 8).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Juan').
				 ('position' -> 5).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
]

{ #category : 'tests' }
RepeatCardTest >> testWhenLastEffectWasNormalSquareAndUseTheRepeatCardThenShouldApplyNoEffect [

	| aGame jorgeShip aDeck  cardsToDraw expectedResult aRepeatCard juanShip |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: RepeatCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	juanShip := Ship named: 'Juan'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip . juanShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aRepeatCard := aDeck first.


	aGame nextTurn. "jorge mueve a 4"
	aGame nextTurn. "juan mueve a 4"
	aGame nextTurn. "jorge mueve a 7"
	aGame playCard: aRepeatCard by: jorgeShip target: juanShip. "Jorge juega RepeatCard"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 7).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Juan').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'tests' }
RepeatCardTest >> testWhenLastEffectWasWormholeAndUseTheRepeatCardThenShouldApplyTheEffect [

	| aGame jorgeShip aDeck cardsToDraw expectedResult aRepeatCard juanShip |
	
	cardsToDraw := OrderedCollection new.
	cardsToDraw add: RepeatCard new.
			
	jorgeShip := Ship named: 'Jorge'.
	juanShip := Ship named: 'Juan'.
	
	aGame := ShipBattleGame
		         inSize: 20
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip . juanShip }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('WormHoles' -> { {7. 15} }) })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aRepeatCard := aDeck first.

	aGame nextTurn. "jorge mueve a 4"
	aGame nextTurn. "juan mueve a 4"
	aGame nextTurn. "jorge mueve a 7"
	aGame playCard: aRepeatCard by: jorgeShip target: juanShip . "Jorge juega RepeatCard"

	expectedResult := OrderedDictionary new.
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 15).
				 ('lap' -> 1).
				 ('card count' -> 1) }).
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Juan').
				 ('position' -> 15).
				 ('lap' -> 1).
				 ('card count' -> 2) }).


	self assert: aGame boardStateWithCards equals: expectedResult
	
]
