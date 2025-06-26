"
Square in grid for the game; to be occupied with a ship.
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'status',
		'origin'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Square class >> validateX: x [
	
	self validateXIsPositive: x.
	self validateXIsInteger: x.
]

{ #category : 'validation' }
Square class >> validateXIsInteger: anXPosition [

	anXPosition isInteger ifFalse: [
		Error signal: 'X position must be an integer.' ]
]

{ #category : 'validation' }
Square class >> validateXIsPositive: aXPosition [

	aXPosition < 0 ifTrue: [
		Error signal: 'X position must be positive.' ]
]

{ #category : 'creation' }
Square class >> x: aXPosition [
		
	self validateX: aXPosition.
		
	^self new initializeAtPosition: aXPosition.
]

{ #category : 'action' }
Square >> applyEffectTo: aShip in: aGame [ 

	^ true
]

{ #category : 'getter' }
Square >> checkStatus [

	^ status
]

{ #category : 'getter' }
Square >> getPosition [

	^ origin
]

{ #category : 'initialization' }
Square >> initializeAtPosition: anXPosition [

	origin := anXPosition.

]

{ #category : 'getter' }
Square >> landingCoordinate [

	^ origin
]
