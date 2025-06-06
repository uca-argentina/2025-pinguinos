"
Implementation of a die, that responds to the message: 'roll', and returns a random integer value between 1 and N.
"
Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'sideNumber'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Die class >> isAPositiveInteger: numberOfSides [

	| isPositive isAnInteger |
	
	isPositive := numberOfSides > 0.
	isAnInteger := numberOfSides isInteger.

	(isPositive and: isAnInteger) ifFalse: [
		Error signal: 'Number of sides should be a positive integer!' ]
]

{ #category : 'instance creation' }
Die class >> withSides: numberOfSides [

	self isAPositiveInteger: numberOfSides.

	^ (self new) initializeWith: numberOfSides
]

{ #category : 'initialization' }
Die >> initialize [
	
	super initialize. 
	self initializeWith: 6
]

{ #category : 'initialization' }
Die >> initializeWith: numberOfSides [

	sideNumber := numberOfSides.
]

{ #category : 'random' }
Die >> roll [

	^ (1 to: sideNumber) atRandom
]
