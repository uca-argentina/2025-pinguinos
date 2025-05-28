"
Wormhole in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'WormHole',
	#superclass : 'Square',
	#instVars : [
		'wormHoleExit'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
WormHole class >> areEndsDistinct: wormHoleOrigin and: wormHoleEnd [

	wormHoleOrigin = wormHoleEnd ifTrue: [
		Error signal: 'Wormhole cannot lead to itself!' ]
]

{ #category : 'instance creation' }
WormHole class >> from: origin to: end [

	self areEndsDistinct: origin and: end.
	
	Square validateXIsPositive: origin.
	Square validateXIsPositive: end.
	
	Square validateXIsInteger: origin.
	Square validateXIsInteger: end.
	
	^ { (self new) initializeTo: end from: origin . (self new) initializeTo: origin from: end }
]

{ #category : 'initialization' }
WormHole >> initializeTo: otherEnd from: origin [
	
	super initializeX: origin.
	wormHoleExit := otherEnd.
]

{ #category : 'getter' }
WormHole >> landingCoordinate [ 
	
	^ wormHoleExit
]
