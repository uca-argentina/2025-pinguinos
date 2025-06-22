"
Blackhole in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'Blackhole',
	#superclass : 'MoverSquare',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Blackhole class >> at: aSquare in: aBoard [

	| exit |
	
	exit := (aBoard getSquareAt: aSquare - 4) getX .
	^ self new initializeTo: exit from: aSquare
]

{ #category : 'action' }
Blackhole >> applyEffectTo: aShip in: aGame [

	destination >= x ifTrue: [ aShip completeLaps: -1 ]
]
