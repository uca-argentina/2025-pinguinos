Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameTest >> testWhenAGameIsStartedWithABoardAshipAndADieThenItStarts [

	| aGame aShip aDie |
	
	aDie := Die withSides: 4.
	aShip := Ship new.
	aGame := Game in: (Board withGridSize: 8) with: aDie and: aShip.
	
	self assert: (aGame start)
]
