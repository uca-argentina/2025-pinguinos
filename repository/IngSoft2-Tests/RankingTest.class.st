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
   shipSet := { Ship named: 'player 1'. Ship named: 'player 2' }.

   aGame := ShipBattleGame inSize: 8 rounds: 3
      withWormHoleFrom: 2 to: 4
      with: { aWeighedDie }
      and: shipSet.

   aGame nextTurn.
   aGame nextTurn.
   aGame nextTurn.
   aGame nextTurn.

   expectedRanking := 'player 2: 1', String lf, 'player 1: 2'.

   self assert: aGame rankingReport equals: expectedRanking.
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

   expectedRanking := 'player 1: 1', String lf, 'player 2: 2'.

   self assert: aGame rankingReport equals: expectedRanking.

]

{ #category : 'tests' }
RankingTest >> testWhenTwoShipsCompeteAndOneGoesToNextRoundThenIsHigher [
   | aGame aWeighedDie shipSet expectedRanking |

   aWeighedDie := LoadedDie withSides: 5.
   shipSet := { Ship named: 'player 1'. Ship named: 'player 2' }.

   aGame := ShipBattleGame inSize: 8 rounds: 3
     withWormHoleFrom: 2 to: 4
     with: { aWeighedDie }
     and: shipSet.

   aGame nextTurn.
   aGame nextTurn.
   aGame nextTurn.

   expectedRanking := 'player 1: 1', String lf, 'player 2: 2'.
   self assert: aGame rankingReport equals: expectedRanking.
]

{ #category : 'tests' }
RankingTest >> testWhenTwoShipsCompeteAndOneWinsThenItIsCalledAsWinner [
	| aGame aWeighedDie shipSet expectedRanking |

    aWeighedDie := LoadedDie withSides: 6.
    shipSet := { Ship named: 'player 1'. Ship named: 'player 2' }.

    aGame := ShipBattleGame inSize: 8 rounds: 2
		withWormHoleFrom: 2 to: 4
      with: { aWeighedDie }
      and: shipSet.

   aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.
	aGame nextTurn.	

   expectedRanking := 'player 1: 1 -> We have a winner!', String lf, 'player 2: 2'.

   self assert: aGame rankingReport equals: expectedRanking.
]
