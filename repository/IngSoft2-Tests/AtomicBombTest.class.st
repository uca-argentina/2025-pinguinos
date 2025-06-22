Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
AtomicBombTest >> testPlayerLandsOnAtomicBombAtPosition5ThenEveryoneReturnsToSquare1 [

	| aGame expectedResult jorgeShip julioShip lucianoShip |

	jorgeShip := Ship named: 'Jorge'.
	julioShip := Ship named: 'Julio'.
	lucianoShip := Ship named: 'Luciano'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: {7. 2. 4. 2. 3}) }
		         and: { jorgeShip . julioShip . lucianoShip }
					withSpecialSquaresAt: {{}. {}. {}. {}. {5} . {}. {}}.

	aGame nextTurn. "Jorge mueve hasta 2 en su segunda vuelta"
	aGame nextTurn. "Julio mueve hasta 3"
	aGame nextTurn. "Luciano mueve hasta 5, activa la bomba, todos vuelven al 1, pierden un escudo y Luciano entra en una pelea que pierde"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 1). ('lap' -> 2). ('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: { ('name' -> 'Luciano'). ('position' -> 1). ('lap' -> 1). ('card count' -> 2) }).
	expectedResult at: '3°' put: (Dictionary newFrom: { ('name' -> 'Julio'). ('position' -> 1). ('lap' -> 1). ('card count' -> 2) }).
	
	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
	self assert: julioShip remainingShields equals: 2.
	self assert: lucianoShip remainingShields equals: 1.
]
