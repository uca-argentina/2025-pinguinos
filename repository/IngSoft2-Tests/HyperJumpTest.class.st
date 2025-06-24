Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
HyperJumpTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : 'running' }
HyperJumpTest >> testHyperJumpInternalListCyclesBackProperlyWhen6thPlayerTouchesSquareHeGetsSameValueAsFirst [

	| aGame expectedResult jorgeShip julioShip lucianoShip luisShip pepeShip julianShip |
	
	jorgeShip := Ship named: 'Jorge'.
	julioShip := Ship named: 'Julio'.
	lucianoShip := Ship named: 'Luciano'.
	luisShip := Ship named: 'Luis'.
	pepeShip := Ship named: 'Pepe'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julioShip.
				         lucianoShip.
				         luisShip.
				         pepeShip.
				         julianShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperJumps' -> { 4 }) }).

	aGame nextTurn. "Jorge mueve hasta 4"
	aGame nextTurn. "Julio mueve hasta 4"
	aGame nextTurn. "Luciano mueve hasta 4"
	aGame nextTurn. "Luis mueve hasta 4"
	aGame nextTurn. "Pepe mueve hasta 4"
	aGame nextTurn. "Julian mueve hasta 4"


	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 2) .
				('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 2).
				('card count' -> 2) }).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julio').
				 ('position' -> 6).
				 ('lap' -> 1).
				('card count' -> 2) }).
	expectedResult at: '4°' put: (Dictionary newFrom: {
				 ('name' -> 'Pepe').
				 ('position' -> 5).
				 ('lap' -> 1) .
				('card count' -> 2)}).
	expectedResult at: '5°' put: (Dictionary newFrom: {
				 ('name' -> 'Luis').
				 ('position' -> 5).
				 ('lap' -> 1).
				('card count' -> 2) }).
	expectedResult at: '6°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 5).
				 ('lap' -> 1) .
				('card count' -> 2)}).

	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
HyperJumpTest >> testHyperSpaceJumpAtPosition4ThenPlayerGetsSent60ParsecsForwardTo1AndSecondPlayerGetsSent40ParsecsForwardTo6 [

	| aGame expectedResult jorgeShip julioShip |
	
	jorgeShip := Ship named: 'Jorge'.
	julioShip := Ship named: 'Julio'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julioShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperJumps' -> { 4 }) }).

	aGame nextTurn. "Jorge mueve hasta 4"
	aGame nextTurn. "Julio mueve hasta 4"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 2) .
				('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julio').
				 ('position' -> 6).
				 ('lap' -> 1) .
				('card count' -> 2)}).

	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
HyperJumpTest >> testHyperSpaceJumpAtPosition4ThenPlayerGetsSent60ParsecsForwardToPosition1 [

	| aGame expectedResult jorgeShip |
	
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: { jorgeShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperJumps' -> { 4 }) }).

	aGame nextTurn. "Jorge mueve hasta 4"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 2).
				('card count' -> 2)}).

	self assert: aGame boardState equals: expectedResult
]

{ #category : 'tests' }
HyperJumpTest >> testPlayerCantCreateHyperJumpOutsideBoard [

	self
		should: [
			ShipBattleGame
				inSize: 6
				rounds: 2
				with: { (LoadedDie withSides: 2) }
				and: { (Ship named: 'Jorge') }
				withSpecialSquaresAt:
				(Dictionary newFrom: { ('HyperJumps' -> { 20 }) }) ]
		raise: Error
		withMessageText:
		'Position of HyperJumps must be within Bounds of Board!'
]
