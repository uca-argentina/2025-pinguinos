"
Implementation of speed card effect, which gives the ship n extra square positions.
"
Class {
	#name : 'AdditionalSquares',
	#superclass : 'PermanentEffect',
	#instVars : [
		'numberOfSquares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
AdditionalSquares class >> isAbstract [

	^ self == AdditionalSquares
]

{ #category : 'one more square' }
AdditionalSquares >> addMovement: aShip [
	
	^ permanentEffectState addMovementFrom: self to: aShip
	
]

{ #category : 'adding' }
AdditionalSquares >> addNormalMovementTo: aShip [

	^ self subclassResponsibility 	
]

{ #category : 'adding' }
AdditionalSquares >> addReverseMovementTo: aShip [

	^ self subclassResponsibility 	
]

{ #category : 'initialization' }
AdditionalSquares >> initializeOf: aNumber usedBy: aCard [

	super initialize.
	
	numberOfSquares := aNumber.
	usedBy := aCard.
	
	^ self
]
