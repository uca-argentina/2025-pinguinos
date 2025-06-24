Class {
	#name : 'BlackholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BlackholeTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
BlackholeTest >> testPlayerCantCreateBlackHoleOutsideBoard [

	self
		should: [
			ShipBattleGame
				inSize: 6
				rounds: 2
				with: { (LoadedDie withSides: 2) }
				and: { (Ship named: 'Jorge') }
				withSpecialSquaresAt:
				(Dictionary newFrom: { ('BlackHoles' -> { 20 }) }) ]
		raise: Error
		withMessageText:
		'Position of BlackHoles must be within Bounds of Board!'
]

{ #category : 'running' }
BlackholeTest >> testWhenBlackholeAtPosition2ThenPlayerGetsSentToPosition4AndLoses1Lap [

	| aGame expectedResult |
	
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { (Ship named: 'Jorge') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('BlackHoles' -> { 2 }) }).

	aGame nextTurn.


	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 0) .
				('card count' -> 2)}).

	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
BlackholeTest >> testWhenBlackholeAtPosition2ThenPlayerGetsSentToPosition4ThenLandsOnAnotherBlackholeAndDoesntMove [

	| aGame expectedResult |
	
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { (Ship named: 'Jorge') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('BlackHoles' -> { 2. 4 }) }).

	aGame nextTurn.


	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 0) .('card count' -> 2)}).

	self assert: aGame boardState equals: expectedResult
]
