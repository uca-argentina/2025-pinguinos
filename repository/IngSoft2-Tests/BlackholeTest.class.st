Class {
	#name : 'BlackholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
BlackholeTest >> testWhenBlackholeAtPosition2ThenPlayerGetsSentToPosition4AndLoses1Lap [

	| aGame expectedResult |
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { (Ship named: 'Jorge') }
		         withSpecialSquaresAt: {{2}. {}. {}. {}. {}}.

	aGame nextTurn.


	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 0) }).
				
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
		         withSpecialSquaresAt: {{2. 4}. {}. {}. {}. {}}.

	aGame nextTurn.


	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 0) }).
				
	self assert: aGame boardState equals: expectedResult 
]
