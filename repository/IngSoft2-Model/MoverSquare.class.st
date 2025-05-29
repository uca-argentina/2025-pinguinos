"
An abstract class with all the methods and values shared by all special squares that move ships.
"
Class {
	#name : 'MoverSquare',
	#superclass : 'Square',
	#instVars : [
		'destination'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
MoverSquare class >> isAbstract [

	^ self == MoverSquare
]

{ #category : 'initialization' }
MoverSquare >> initializeTo: otherEnd from: origin [
	
	super initializeX: origin.
	destination := otherEnd.
]

{ #category : 'getter' }
MoverSquare >> landingCoordinate [

	^ destination
]
