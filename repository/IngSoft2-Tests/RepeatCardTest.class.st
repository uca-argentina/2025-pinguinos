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
