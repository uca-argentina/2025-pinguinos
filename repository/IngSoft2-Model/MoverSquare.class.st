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

{ #category : 'action' }
MoverSquare >> applyEffectTo: aShip in: aGame [

	aGame moveShip: aShip to: destination.
]

{ #category : 'getter' }
MoverSquare >> getDestination [

	^ destination
]

{ #category : 'initialization' }
MoverSquare >> initializeTo: aDestination from: anOriginPosition [
	
	super initializeAtPosition: anOriginPosition.
	destination := aDestination.
]
