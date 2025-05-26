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

{ #category : 'getter' }
Square >> checkStatus [

	^ status
]

{ #category : 'initialization' }
Square >> initializeX: aXPosition [

	x := aXPosition.	
	finalDestination := x.
	
	self setStatus: 'Free'.
]

{ #category : 'setter' }
Square >> occupy [ 
	
	status:= 'Occupied'.
]

{ #category : 'getter' }
Square >> pointsTo [

	^ x
]

{ #category : 'setter' }
Square >> setStatus: aStatus [

	status:= aStatus.
]
