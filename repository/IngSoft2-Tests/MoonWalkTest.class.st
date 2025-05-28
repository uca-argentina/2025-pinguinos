Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
MoonWalkTest >> testMoonWalkOf3AtPosition2ThenEveryOtherPlayerGetsSentToPosition5AndLoses1Lap [

	| aGame expectedResult jorgeShip lucianoShip julioShip |

	jorgeShip := Ship named: 'Jorge'.
	julioShip := Ship named: 'Julio'.
	lucianoShip := Ship named: 'Luciano'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: {2. 1} ) }
		         and: { jorgeShip . julioShip . lucianoShip }
					withSpecialSquaresAt: {{}. {}. {2}. {}. {}}. "Moonwalks son de 3 por default"

	aGame nextTurn. "Jorge mueve hasta 3"
	aGame nextTurn. "Julio mueve hasta 2 y activa moonwalk"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Julio'). ('position' -> 2). ('lap' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 6). ('lap' -> 0) }).
	expectedResult at: '3°' put: (Dictionary newFrom: { ('name' -> 'Luciano'). ('position' -> 4). ('lap' -> 0) }).
	
	self assert: aGame boardState equals: expectedResult.
]

{ #category : 'running' }
MoonWalkTest >> testWhenAPlayerGetsMovedBackByAMoonWalkBackIntoAnotherMoonWalkThe2ndOneIsntTriggered [

	| aGame expectedResult jorgeShip julioShip |

	jorgeShip := Ship named: 'Jorge'.
	julioShip := Ship named: 'Julio'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { jorgeShip . julioShip }
					withSpecialSquaresAt: {{}. {}. {2. 5}. {}. {}}. "Moonwalks son de 3 por default"

	aGame nextTurn. "Jorge mueve hasta 2"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 2). ('lap' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: { ('name' -> 'Julio'). ('position' -> 4). ('lap' -> 0) }).
	
	self assert: aGame boardState equals: expectedResult.
]
