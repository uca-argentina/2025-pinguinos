Extension { #name : 'HyperSpaceJumpTest' }

{ #category : '*BaselineOfIngSoft2' }
HyperSpaceJumpTest >> testHyperSpaceJumpAtPosition2ThenPlayerGetsSentToPosition4AndLoses1Shield [

	| aGame expectedResult jorgeShip |
	
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { jorgeShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('HyperSpaceJumps' -> { 2 }) }).

	aGame nextTurn. "Jorge mueve hasta 2"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 6).
				 ('lap' -> 1)}).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2
]
