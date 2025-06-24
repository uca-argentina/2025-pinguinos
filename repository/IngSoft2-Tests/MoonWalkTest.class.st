Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
MoonWalkTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : 'running' }
MoonWalkTest >> testMoonWalkOf3AtPosition2ThenEveryOtherPlayerGetsSentToPosition5AndLoses1Lap [

	| aGame expectedResult jorgeShip lucianoShip julioShip |
	
	jorgeShip := Ship named: 'Jorge'.
	julioShip := Ship named: 'Julio'.
	lucianoShip := Ship named: 'Luciano'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: { 2. 1 }) }
		         and: {
				         jorgeShip.
				         julioShip.
				         lucianoShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('MoonWalks' -> { { 2. 3 } }) }). "Moonwalks de 3, {posicion, N}"

	aGame nextTurn. "Jorge mueve hasta 3"
	aGame nextTurn. "Julio mueve hasta 2 y activa moonwalk"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julio').
				 ('position' -> 2).
				 ('lap' -> 1) .
				('card count' -> 2)
				}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 6).
				 ('lap' -> 0).('card count' -> 2) }).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 4).
				 ('lap' -> 0) .('card count' -> 2)}).

	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
MoonWalkTest >> testPlayerCantCreateMoonWalkOutsideBoard [

	self
		should: [
			ShipBattleGame
				inSize: 6
				rounds: 2
				with: { (LoadedDie withSides: 2) }
				and: { (Ship named: 'Jorge') }
				withSpecialSquaresAt:
				(Dictionary newFrom: { ('MoonWalks' -> { {20. 3} }) }) ]
		raise: Error
		withMessageText:
		'Position of MoonWalks must be within Bounds of Board!'
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
		         and: {
				         jorgeShip.
				         julioShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('MoonWalks' -> { {2. 3}.  {5. 3} }) }). "Moonwalks de 3, {posicion, N}"

	aGame nextTurn. "Jorge mueve hasta 2"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 2).
				 ('lap' -> 1).('card count' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julio').
				 ('position' -> 4).
				 ('lap' -> 0) .('card count' -> 2)}).

	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
MoonWalkTest >> testWhenAPlayerGetsMovedBackByAMoonWalkBackIntoAnotherSpecialSquareItIsntTriggered [

	| aGame expectedResult jorgeShip julioShip |
	
	jorgeShip := Ship named: 'Jorge'.
	julioShip := Ship named: 'Julio'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: {
				         jorgeShip.
				         julioShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {
					          ('MoonWalks' -> { {2. 3} }).
					          ('BlackHoles' -> { 4 }) }).

	aGame nextTurn. "Jorge mueve hasta 2"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 2).
				 ('lap' -> 1) .('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julio').
				 ('position' -> 4).
				 ('lap' -> 0) .('card count' -> 2) }).

	self assert: aGame boardState equals: expectedResult
]
