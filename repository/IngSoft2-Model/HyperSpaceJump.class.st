"
HyperSpaceJump in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
HyperSpaceJump >> applyEffectTo: aShip in: aGame [


	| boardSize originalPosition aDestination |
	boardSize := aGame boardSize.
	originalPosition := aShip position.
	aDestination := originalPosition + 4.

	(aDestination > boardSize) ifTrue: [
		aShip completeLaps: 1.
		aDestination := aDestination - boardSize
	].

	aGame moveShip: aShip to: aDestination.
	aShip loseShield.

]
