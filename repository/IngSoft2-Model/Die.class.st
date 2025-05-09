"
implementation of a die, that responds to the message: 'roll', and returns a random integer value between 1 and N.
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

	numberOfSides > 0 ifFalse: [
		Error signal: 'Number of sides should be a positive integer!' ]
]

{ #category : 'instance creation' }
Die class >> withSides: numberOfSides [

	self isAPositiveInteger: numberOfSides.

	^ self new initializeWith: numberOfSides
]

{ #category : 'initialization' }
Die >> initialize [
	self initializeWith: 6.
]

{ #category : 'initialization' }
Die >> initializeWith: numberOfSides [ 
	sideNumber := numberOfSides.
]

{ #category : 'random' }
Die >> roll [
 ^ (1 to: sideNumber) atRandom
]
