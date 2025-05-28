"
Blackhole in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'BlackHole',
	#superclass : 'Square',
	#instVars : [
		'destination'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
BlackHole class >> at: aSquare in: aBoard [

	| exit |
	exit := (aBoard getSquareAt: aSquare - 4) getX .
	^ self new initializeTo: exit from: aSquare
]

{ #category : 'intialization' }
BlackHole >> initializeTo: otherEnd from: origin [
	
	super initializeX: origin.
	destination := otherEnd.
]

{ #category : 'getter' }
BlackHole >> landingCoordinate [

	^ destination
]
