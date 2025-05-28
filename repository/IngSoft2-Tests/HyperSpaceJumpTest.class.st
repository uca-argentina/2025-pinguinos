Class {
	#name : 'HyperSpaceJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
HyperSpaceJumpTest >> testHyperSpaceJumpAtPosition2ThenPlayerGetsSentToPosition4AndLoses1Shield [

	| aGame expectedResult jorgeShip |

	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { jorgeShip }
					withSpecialSquaresAt: {{}. {2}. {}. {}. {}}.

	aGame nextTurn. "Jorge mueve hasta 2"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 6). ('lap' -> 1) }).
	
	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
]

{ #category : 'running' }
HyperSpaceJumpTest >> testHyperSpaceJumpAtPosition2ThenPlayerGetsSentToPosition4ThenLandsOnAnotherHyperSpaceJumpAndDoesntMoveAndLoses1ShieldOnly [

	| aGame expectedResult jorgeShip |
	
	jorgeShip := Ship named: 'Jorge'.
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 1) }
		         and: { jorgeShip }
		         withSpecialSquaresAt: {{}. {2. 6}. {}. {}. {}}.

	aGame nextTurn.


	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 6).
				 ('lap' -> 1) }).
				
	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
]

{ #category : 'running' }
HyperSpaceJumpTest >> testHyperSpaceJumpAtPosition4ThenPlayerGetsSentToPosition2AndLoses1ShieldAndGains1Lap [

	| aGame expectedResult jorgeShip |

	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: { jorgeShip }
					withSpecialSquaresAt: {{}. {4}. {}. {}. {}}.

	aGame nextTurn. "Jorge mueve hasta 2"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 2). ('lap' -> 2) }).
	
	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
]

{ #category : 'running' }
HyperSpaceJumpTest >> testHyperSpaceJumpAtPosition4ThenPlayerGetsSentToPosition2AndLoses1ShieldAndWinsGame [

	| aGame jorgeShip |

	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 1
		         with: { (LoadedDie withSides: 3) }
		         and: { jorgeShip }
					withSpecialSquaresAt: {{}. {4}. {}. {}. {}}.

	aGame nextTurn. "Jorge mueve hasta 2"

	self assert: aGame getWinner equals: 'Jorge'.
]

{ #category : 'running' }
HyperSpaceJumpTest >> testHyperSpaceJumpAtPosition5ThenPlayerGetsSentAcrossTheGoalToPosition3Correctly [

	| aGame expectedResult jorgeShip |

	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: 4) }
		         and: { jorgeShip }
					withSpecialSquaresAt: {{}. {5}. {}. {}. {}}.

	aGame nextTurn. "Jorge mueve hasta 5"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 3). ('lap' -> 2) }).
	
	self assert: aGame boardState equals: expectedResult.
]
