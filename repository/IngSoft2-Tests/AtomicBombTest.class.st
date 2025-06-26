Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
AtomicBombTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : 'running' }
AtomicBombTest >> testPlayerCantCreateAtomicBombOutsideBoard [

	self
		should: [
			ShipBattleGame
				inSize: 6
				rounds: 2
				with: { (LoadedDie withSides: 2) }
				and: { (Ship named: 'Jorge') }
				withSpecialSquaresAt:
				(Dictionary newFrom: { ('AtomicBombs' -> { 20 }) }) ]
		raise: Error
		withMessageText:
		'Position of AtomicBombs must be within Bounds of Board!'
]

{ #category : 'running' }
AtomicBombTest >> testPlayerLandsOnAtomicBombAtPosition5ThenEveryoneReturnsToSquare1 [

	| aGame expectedResult jorgeShip julioShip lucianoShip |
	
	jorgeShip := Ship named: 'Jorge'.
	julioShip := Ship named: 'Julio'.
	lucianoShip := Ship named: 'Luciano'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: { 7. 2. 4. 2. 3 }) }
		         and: {
				         jorgeShip.
				         julioShip.
				         lucianoShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('AtomicBombs' -> { 5 }) }).

	aGame nextTurn. "Jorge mueve hasta 2 en su segunda vuelta"
	aGame nextTurn. "Julio mueve hasta 3"
	aGame nextTurn. "Luciano mueve hasta 5, activa la bomba, todos vuelven al 1, pierden un escudo y Luciano entra en una pelea que pierde"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 1).
				 ('lap' -> 1)}).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julio').
				 ('position' -> 1).
				 ('lap' -> 1)}).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
	self assert: julioShip remainingShields equals: 2.
	self assert: lucianoShip remainingShields equals: 1
]
