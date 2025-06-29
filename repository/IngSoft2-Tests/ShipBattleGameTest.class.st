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
ShipBattleGameTest >> testGameWithSemiRandomlyDistributedSpecialSquaresIsCreatedSuccessfully [

	| aGame |
	
	aGame := ShipBattleGame
		         inSize: 50
		         rounds: 5
		         with: { (Die withSides: 6) . Die withSides: 4 }
		         and: {
				         (Ship named: 'Jorge').
				         (Ship named: 'Luciano').
							(Ship named: 'Julian')}.
							
	aGame nextTurn.
	aGame skipTurn.

   "Observo que no hay errores al jugar"
	self assert: aGame nextTurn equals: aGame.
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsFightIfTheLoserHad0ShieldsThenHeLoses2Turns [

	| aGame expectedResult lucianoShip jorgeShip |
	
	expectedResult := OrderedDictionary new.
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with:
		         { (LoadedDie withSides:
			          { 4. 4. 5. 4. 4. 4. 5. 4. 4. 5. 5. 4 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 4 y Luciano gana"

	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 5).
				 ('lap' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.



	aGame nextTurn. "Jorge mueve hasta 5, se pelea, Jorge saca 4, Luciano 5 y Luciano gana"
	aGame skipTurn. "Luciano saltea su turno"

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 1.



	aGame nextTurn. "Jorge mueve hasta 5, se pelea, Jorge saca 4, Luciano 5 y Luciano gana, Jorge no tiene mas escudos y perdera 2 turnos"
	aGame skipTurn. "Luciano saltea su turno"

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 0.



	aGame nextTurn. "Jorge no puede mover, recupera sus escudos"
	aGame nextTurn. "Luciano mueve hasta 4"

	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 4).
				 ('lap' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.



	aGame nextTurn. "Jorge no puede mover"
	aGame skipTurn. "Luciano saltea su turno"

	self assert: aGame boardState equals: expectedResult.



	aGame nextTurn. "Jorge se mueve hasta 5"

	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 4).
				 ('lap' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsLandInSameSquareAndFightThenLoserCanSkipTurnToRecoverShields [

	| aGame lucianoShip jorgeShip expectedResult |
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: { 4. 4. 5. 4 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 4 } }) }).

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 4 y Luciano gana"
	aGame skipTurn. "Jorge saltea su turno y recupera todos sus escudos"
	aGame nextTurn. "Luciano se mueve 4 hasta 3"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 3).
				 ('lap' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsLandInSameSquareTheFighterWinsCorrectly [

	| aGame expectedResult lucianoShip jorgeShip |
	
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: { 4. 4. 5. 4 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 4 } }) }).

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 4 y Luciano gana"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 5).
				 ('lap' -> 1)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
	self assert: lucianoShip remainingShields equals: 3
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsLandInSameSquareTheShipBeingFoughtCanWinCorrectly [

	| aGame expectedResult lucianoShip jorgeShip |
	
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: { 4. 4. 4. 6 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 4, Jorge 6 y Jorge gana"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 1).
				 ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
	self assert: lucianoShip remainingShields equals: 2.
	self assert: jorgeShip remainingShields equals: 3
]

{ #category : 'running' }
ShipBattleGameTest >> testWhen2ShipsLandInSameSquareTheyCanDrawCorrectly [

	| aGame expectedResult lucianoShip jorgeShip |
	
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with: { (LoadedDie withSides: { 4. 4. 5. 5 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 5 y hay empate"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 5).
				 ('lap' -> 1) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1)  }).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.
	self assert: lucianoShip remainingShields equals: 3
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenCreatingGameWith0RoundsAnErrorIsRaised [

	self
		should: [
			ShipBattleGame
				inSize: 1
				rounds: 0
				with: { (LoadedDie withSides: 6) }
				and: { (Ship named: 'player 1') }
				withSpecialSquaresAt: Dictionary new ]
		raise: Error
		withErrorMessage: 'Round number for the board must be positive.'
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenCreatingGameWithCircularBoardOfSize0AnErrorIsRaised [

	self
		should: [
			ShipBattleGame
				inSize: 0
				rounds: 1
				with: { (LoadedDie withSides: 6) }
				and: { (Ship named: 'player 1') }
				withSpecialSquaresAt: Dictionary new ]
		raise: Error
		withErrorMessage: 'Size for the grid must be positive.'
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenCreatingGameWithCircularBoardOfSizeNegativeAnErrorIsRaised [

	self
		should: [
			ShipBattleGame
				inSize: -2
				rounds: 1
				with: { (LoadedDie withSides: 6) }
				and: { (Ship named: 'player 1') }
				withSpecialSquaresAt: Dictionary new ]
		raise: Error
		withErrorMessage: 'Size for the grid must be positive.'
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenCreatingGameWithNegativeRoundsAnErrorIsRaised [

	self
		should: [
			ShipBattleGame
				inSize: 1
				rounds: -4
				with: { (LoadedDie withSides: 6) }
				and: { (Ship named: 'player 1') }
				withSpecialSquaresAt: Dictionary new ]
		raise: Error
		withErrorMessage: 'Round number for the board must be positive.'
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedThenGameDoesntEndIfShipDoesntCrossGoal [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 1
		         with: { (LoadedDie withSides: 3) }
		         and: { (Ship named: 'player 1') }
					withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn.

	self deny: aGame getWinner equals: 'player 1'
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedThenGameEndsAfterOneTurn [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 1
		         with: { (LoadedDie withSides: 6) }
		         and: { (Ship named: 'player 1') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWith2RoundsGameDoesntEndIfShipReachesLastSquareIn2ndRound [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         with: { (LoadedDie withSides: 134) }
		         and: { (Ship named: 'player 1') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ( 'WormHoles' -> { { 2. 3 } } ) }).

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWith2RoundsGameEndsIfShipCrossesGoal2TimesIn2Turns [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         with: { (LoadedDie withSides: 4) }
		         and: { (Ship named: 'player 1') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 4 } }) }).

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
		         with: { (LoadedDie withSides: 100) }
		         and: { (Ship named: 'player 1') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWithMoreThanOneRoundThenGameIsNotFinishedAfterFirstTurn [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         with: { (LoadedDie withSides: 6) }
		         and: { (Ship named: 'player 1') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn.

	self deny: aGame getWinner equals: 'player 1'
]

{ #category : 'tests' }
ShipBattleGameTest >> testWhenShipBattleGameIsCreatedWithMoreThanOneRoundThenIsFinished [

	| aGame |
	aGame := ShipBattleGame
		         inSize: 4
		         rounds: 2
		         with: { (LoadedDie withSides: 4) }
		         and: { (Ship named: 'player 1') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

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
		         with: { (LoadedDie withSides: 6) }
		         and: {
				         (Ship named: 'player 1').
				         (Ship named: 'player 2') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	self assert: aGame getWinner equals: 'player 1'
]

{ #category : 'running' }
ShipBattleGameTest >> testWhenShipFightsShipWithNoShieldsAndWinsLoserWillLose2MoreTurns [

	| aGame expectedResult lucianoShip jorgeShip |
	expectedResult := OrderedDictionary new.
	lucianoShip := Ship named: 'Luciano'.
	jorgeShip := Ship named: 'Jorge'.

	aGame := ShipBattleGame
		         inSize: 6
		         rounds: 2
		         with:
		         { (LoadedDie withSides:
			          { 4. 4. 5. 4. 4. 4. 5. 4. 4. 5. 2. 4. 3. 4 }) }
		         and: {
				         jorgeShip.
				         lucianoShip }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).


	aGame nextTurn. "Jorge mueve hasta 5"
	aGame nextTurn. "Luciano mueve hasta 5, pelean, Luciano saca 5, Jorge 4 y Luciano gana"

	aGame nextTurn. "Jorge mueve hasta 5, se pelea, Jorge saca 4, Luciano 5 y Luciano gana"
	aGame skipTurn. "Luciano saltea su turno"



	aGame nextTurn. "Jorge mueve hasta 5, se pelea, Jorge saca 4, Luciano 5 y Luciano gana, Jorge no tiene mas escudos y perdera 2 turnos"
	aGame nextTurn. "Luciano avanza 2 hasta 1 en la segunda vuelta, pelea y gana"

	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 1).
				 ('lap' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1) }).

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 0.



	aGame nextTurn. "Jorge no puede mover, recupera sus escudos"
	aGame skipTurn. "Luciano saltea su turno"

	self assert: aGame boardState equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.


	aGame nextTurn. "Jorge no puede mover"
	aGame skipTurn. "Luciano saltea su turno"

	self assert: aGame boardState equals: expectedResult.


	aGame nextTurn. "Jorge no puede mover"
	aGame skipTurn. "Luciano saltea su turno"

	self assert: aGame boardState equals: expectedResult.


	aGame nextTurn. "Jorge no puede mover"
	aGame skipTurn. "Luciano saltea su turno"

	self assert: aGame boardState equals: expectedResult.


	aGame nextTurn. "Jorge se mueve hasta 5"

	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 1).
				 ('lap' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 5).
				 ('lap' -> 1)}).

	self assert: aGame boardState equals: expectedResult
]

{ #category : 'running' }
ShipBattleGameTest >> testWith2ShipsInPlayWeCanGetRankedPositionOfShipsCorrectly [

	| aGame expectedResult |
	aGame := ShipBattleGame
		         inSize: 5
		         rounds: 2
		         with: { (LoadedDie withSides: 4) }
		         and: {
				         (Ship named: 'Jorge').
				         (Ship named: 'Luciano') }
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 3 } }) }).

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Luciano').
				 ('position' -> 5).
				 ('lap' -> 1)}).

	self assert: aGame boardState equals: expectedResult
]
