"
Blackhole in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'Blackhole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
Blackhole >> applyEffectTo: aShip in: aGame [

	| boardSize originalPosition aDestination |
	boardSize := aGame boardSize.
	originalPosition := aShip position.
	aDestination := originalPosition - 4.

	(aDestination < 1) ifTrue: [
		aShip completeLaps: -1.
		aDestination := boardSize + aDestination 
	].

	aGame moveShip: aShip to: aDestination.

	
]
