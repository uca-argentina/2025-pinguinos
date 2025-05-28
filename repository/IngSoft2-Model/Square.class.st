"
Square in grid for the game; to be occupied with a ship.
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'status',
		'x'
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
	
	anXPosition isInteger ifFalse: [ Error signal: 'X position must be an integer.' ]
]

{ #category : 'validation' }
Square class >> validateXIsPositive: aXPosition [

	aXPosition < 0 ifTrue: [
		Error signal: 'X position must be positive.' ]
]

{ #category : 'creation' }
Square class >> x: aXPosition [
		
	self validateX: aXPosition.
		
	^self new initializeX: aXPosition.
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
Square >> getX [

	^ x
]

{ #category : 'initialization' }
Square >> initializeX: anXPosition [

	x := anXPosition.
	self setStatus: 'Free'.
]

{ #category : 'getter' }
Square >> landingCoordinate [

	^ x
]

{ #category : 'setter' }
Square >> occupy [ 
	
	status:= 'Occupied'.
]

{ #category : 'setter' }
Square >> setStatus: aStatus [

	status:= aStatus.
]
