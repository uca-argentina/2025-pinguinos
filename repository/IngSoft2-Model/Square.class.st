"
Square in grid for the game; to be occupied with a ship.
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'status',
		'x',
		'finalDestination'
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
		
	self validateXIsPositive: aXPosition.
	self validateXIsInteger: aXPosition.
		
	^self new initializeX: aXPosition.
]

{ #category : 'accessing' }
Square >> checkStatus [
	^status.
]

{ #category : 'initialization' }
Square >> initializeX: aXPosition [

	x:= aXPosition.	
	self setStatus: 'Free'.
]

{ #category : 'setter' }
Square >> occupy [ 
	
	status:= 'Occupied'.
]

{ #category : 'setter' }
Square >> pointTo: whereToPoint [
	
	finalDestination := whereToPoint.
]

{ #category : 'accessing' }
Square >> pointsTo [

	^ finalDestination
]

{ #category : 'initialization' }
Square >> setStatus: aStatus [

	status:= aStatus.
]
