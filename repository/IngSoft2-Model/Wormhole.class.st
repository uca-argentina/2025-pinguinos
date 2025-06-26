"
Wormhole in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#instVars : [
		'destination'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Wormhole class >> areEndsDistinct: wormHoleOrigin and: wormHoleEnd [

	wormHoleOrigin = wormHoleEnd ifTrue: [
		Error signal: 'Wormhole cannot lead to itself!' ]
]

{ #category : 'instance creation' }
Wormhole class >> from: anOriginPosition to: aDestiny [

	self areEndsDistinct: anOriginPosition and: aDestiny.

	Square validateXIsPositive: anOriginPosition.
	Square validateXIsPositive: aDestiny.

	Square validateXIsInteger: anOriginPosition.
	Square validateXIsInteger: aDestiny.

	^ {
		  (self new initializeTo: aDestiny from: anOriginPosition).
		  (self new initializeTo: anOriginPosition from: aDestiny) }
]

{ #category : 'action' }
Wormhole >> applyEffectTo: aShip in: aGame [

	aGame moveShip: aShip to: destination.
]

{ #category : 'getter' }
Wormhole >> getDestination [

	^ destination
]

{ #category : 'initialization' }
Wormhole >> initializeTo: aDestination from: anOriginPosition [
	
	super initializeAtPosition: anOriginPosition.
	destination := aDestination.
]
