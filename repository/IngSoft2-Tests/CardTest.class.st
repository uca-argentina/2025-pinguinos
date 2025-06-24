Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> testWhenCardGiverAtPosition2ThenShipGetsCardsAddedToTheirCount [

	| aGame expectedResult |
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { (Ship named: 'Jorge') }
		         withSpecialSquaresAt: (Dictionary newFrom: { ('CardGivers' -> { 2 }) }).

	aGame nextTurn.

   "self assert: 'Jorge' cards size equals: 2."

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 2).
				 ('lap' -> 1) .
				 ('card count' -> 3)}).
				
	self assert: aGame boardState equals: expectedResult 
]

{ #category : 'running' }
CardTest >> testWhenShipIsCreatedItHasTwoRandomCards [

	| aShip |
	aShip := Ship new.
   self assert: aShip cards size equals: 2.
]
