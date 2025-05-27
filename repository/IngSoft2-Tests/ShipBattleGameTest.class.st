Class {
	#name : 'ShipBattleGameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
ShipBattleGameTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsFightIfTheLoserHad0ShieldsThenHeLoses2Turns [

	| aGame expectedResult lucianoShip jorgeShip |
	
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: { 4 . 4  .5. 4.  4  .4. 5.  4  .4. 5.  4  .4. 5.  1 . 1 . 3}) }
		         and: {
				         jorgeShip.
				         lucianoShip }.

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 4 y Luciano gana"
	
	aGame nextTurn. "Jorge mueve hasta 5, se pelea, Jorge saca 4, Luciano 5 y Luciano gana"
	aGame skipTurn. "Luciano saltea su turno"
	
	aGame nextTurn. "Jorge mueve hasta 5, se pelea, Jorge saca 4, Luciano 5 y Luciano gana"
	aGame skipTurn. "Luciano saltea su turno"
	
	aGame nextTurn. "Jorge mueve hasta 5, se pelea, Jorge saca 4, Luciano 5 y Luciano gana, Jorge no tenia mas escudos, asi que perdera los proximos dos turnos"
	aGame skipTurn. "Luciano saltea su turno"
	
	self assert: jorgeShip remainingShields equals: 0.
	aGame nextTurn. "Jorge no puede mover"
	self assert: jorgeShip remainingShields equals: 3. "Ya recupera sus escudos aunque no juegue"
	
	aGame nextTurn. "Luciano mueve hasta 6"
	
	aGame nextTurn. "Jorge no puede mover"
	aGame nextTurn. "Luciano mueve hasta 1"
	
	aGame nextTurn. "Jorge mueve hasta 4"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Luciano'). ('position' -> 1). ('lap' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 4). ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsLandInSameSquareAndFightThenLoserCanSkipTurnToRecoverShields [

	| aGame lucianoShip jorgeShip expectedResult |
	
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 4
		         with: { (LoadedDie withSides: { 4. 4. 5. 4 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }.

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 4 y Luciano gana"
	aGame skipTurn. "Jorge saltea su turno y recupera todos sus escudos"
	aGame nextTurn. "Luciano se mueve 4 hasta 3"
	
	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Luciano'). ('position' -> 3). ('lap' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 1). ('lap' -> 1) }).
	
	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsLandInSameSquareTheFighterWinsCorrectly [

	| aGame expectedResult lucianoShip jorgeShip |
	
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: { 4. 4. 5. 4 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }.

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 4 y Luciano gana"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Luciano'). ('position' -> 5). ('lap' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 1). ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
	self assert: lucianoShip remainingShields equals: 3.
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsLandInSameSquareTheShipBeingFoughtCanWinCorrectly [

	| aGame expectedResult lucianoShip jorgeShip |
	
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: { 4. 4. 4. 6 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }.

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 4, Jorge 6 y Jorge gana"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 5). ('lap' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: { ('name' -> 'Luciano'). ('position' -> 1). ('lap' -> 1) }).
	
	self assert: aGame boardState equals: expectedResult.
	self assert: lucianoShip remainingShields equals: 2.
	self assert: jorgeShip remainingShields equals: 3.
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsLandInSameSquareTheyCanDrawCorrectly [

	| aGame expectedResult lucianoShip jorgeShip |
	
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: { 4. 4. 5. 5 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }.

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 5 y hay empate"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { ('name' -> 'Luciano'). ('position' -> 5). ('lap' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: { ('name' -> 'Jorge'). ('position' -> 5). ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.
	self assert: lucianoShip remainingShields equals: 3.
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedThenGameDoesntEndIfShipDoesntCrossGoal [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 1
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 3) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self deny: aGame getWinner equals: 'player 1'
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedThenGameEndsAfterOneTurn [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 1
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 6) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWith2RoundsGameDoesntEndIfShipReachesLastSquareIn2ndRound [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 134) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWith2RoundsGameEndsIfShipCrossesGoal2TimesIn2Turns [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 4) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.
	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWith2RoundsGameEndsIfShipCrossesGoal2TimesInSameTurn [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 100) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWithMoreThanOneRoundThenGameIsNotFinishedAfterFirstTurn [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 6) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.

	self deny: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWithMoreThanOneRoundThenIsFinished [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 4) }
		         and: { (Ship named: 'player 1') }.

	aGame nextTurn.
	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWithMoreThanOneShipThenTheFirstOneWins [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 6) }
		         and: {
				         (Ship named: 'player 1').
				         (Ship named: 'player 2') }.

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'running' }
ShipBattleGameTest >> testWith2ShipsInPlayWeCanGetRankedPositionOfShipsCorrectly [

	| aGame expectedResult |
	aGame := ShipBattleGame
		         inSize: 5
		         rounds: 2
		         withWormHoleFrom: 2
		         to: 3
		         with: { (LoadedDie withSides: 4) }
		         and: {
				         (Ship named: 'Jorge').
				         (Ship named: 'Luciano') }.

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: { 'name' -> 'Jorge' . 'position' -> 4 . 'lap' -> 2 }).
	expectedResult at: '2°' put: (Dictionary newFrom: { 'name' -> 'Luciano' . 'position' -> 5 . 'lap' -> 1 }).

	self assert: aGame boardState equals: expectedResult
]
