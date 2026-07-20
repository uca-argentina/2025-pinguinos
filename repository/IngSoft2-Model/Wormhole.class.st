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

{ #category : 'accessing' }
Wormhole class >> from: anOriginPosition to: aDestiny [

	self areEndsDistinct: anOriginPosition and: aDestiny.

	self validateXIsPositive: anOriginPosition.
	self validateXIsPositive: aDestiny.

	self validateXIsInteger: anOriginPosition.
	self validateXIsInteger: aDestiny.

	^ {
		  (self new initializeTo: aDestiny from: anOriginPosition).
		  (self new initializeTo: anOriginPosition from: aDestiny) }
]

{ #category : 'validation' }
Wormhole class >> validateXIsInteger: anXPosition [

	anXPosition isInteger ifFalse: [
		Error signal: 'X position must be an integer.' ]
]

{ #category : 'validation' }
Wormhole class >> validateXIsPositive: aXPosition [

	aXPosition < 0 ifTrue: [
		Error signal: 'X position must be positive.' ]
]

{ #category : 'action' }
Wormhole >> applyNormalEffectTo: aShip in: aGame [

	aGame moveShip: aShip to: destination
]

{ #category : 'action' }
Wormhole >> applyReverseEffectTo: aShip in: aGame [

	aGame moveEveryShipExcept: aShip to: destination
]

{ #category : 'getter' }
Wormhole >> getDestination [

	^ destination
]

{ #category : 'initialization' }
Wormhole >> initializeTo: aDestination from: anOriginPosition [
	
	super initializeAt: anOriginPosition.
	destination := aDestination.
]
