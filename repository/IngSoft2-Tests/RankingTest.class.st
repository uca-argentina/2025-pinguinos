Class {
	#name : 'RankingTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RankingTest >> testWhenTwoShipsCompeteAndBothAreInTheSameSpotThenRankingIsOverridden [

	| aGame aWeighedDie shipSet expectedRanking |
	
	aWeighedDie := LoadedDie withSides: 5.
	shipSet := {
		           (Ship named: 'player 1').
		           (Ship named: 'player 2') }.

	aGame := ShipBattleGame
		         inSize: 8
		         rounds: 3
		         with: { aWeighedDie }
		         and: shipSet
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 4 } }) }). "1 Worm de 2 a 4"

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	expectedRanking := 'player 2 ranked: 1 - round: 2 - position: 3'
	                   , String lf
	                   , 'player 1 ranked: 2 - round: 2 - position: 3'.

	self assert: aGame rankingReport equals: expectedRanking
]

{ #category : 'tests' }
RankingTest >> testWhenTwoShipsCompeteAndDontFinishThenItShowsRanking [
	| aGame aWeighedDie shipSet expectedRanking |

   aWeighedDie := LoadedDie withSides: 3.
   shipSet := { Ship named: 'player 1'. Ship named: 'player 2' }.

   aGame := Game inSize: 8
		withWormHoleFrom: 2 to: 6
      with: { aWeighedDie }
      and: shipSet.

   aGame nextTurn.
   aGame nextTurn.
   aGame nextTurn.

   expectedRanking := 'player 1 ranked: 1 - round: 1 - position: 7', 
		String lf, 
		'player 2 ranked: 2 - round: 1 - position: 4'.


   self assert: aGame rankingReport equals: expectedRanking.

]

{ #category : 'tests' }
RankingTest >> testWhenTwoShipsCompeteAndOneGoesToNextRoundThenIsHigher [

	| aGame aWeighedDie shipSet expectedRanking |
	
	aWeighedDie := LoadedDie withSides: 5.
	shipSet := {
		           (Ship named: 'player 1').
		           (Ship named: 'player 2') }.

	aGame := ShipBattleGame
		         inSize: 8
		         rounds: 3
		         with: { aWeighedDie }
		         and: shipSet
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 4 } }) }).

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	expectedRanking := 'player 1 ranked: 1 - round: 2 - position: 3'
	                   , String lf
	                   , 'player 2 ranked: 2 - round: 1 - position: 6'.

	self assert: aGame rankingReport equals: expectedRanking
]

{ #category : 'tests' }
RankingTest >> testWhenTwoShipsCompeteAndOneWinsThenItIsCalledAsWinner [

	| aGame aWeighedDie shipSet expectedRanking |
	
	aWeighedDie := LoadedDie withSides: 6.
	shipSet := {
		           (Ship named: 'player 1').
		           (Ship named: 'player 2') }.

	aGame := ShipBattleGame
		         inSize: 8
		         rounds: 2
		         with: { aWeighedDie }
		         and: shipSet
		         withSpecialSquaresAt:
		         (Dictionary newFrom: { ('WormHoles' -> { { 2. 4 } }) }).

	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.

	expectedRanking := 'player 1 ranked: 1 - round: 3 - position: 3 -> We have a winner!'
	                   , String lf
	                   , 'player 2 ranked: 2 - round: 2 - position: 5'.


	self assert: aGame rankingReport equals: expectedRanking
]
