"
Implementation of an empty square.
"
Class {
	#name : 'EmptySquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
EmptySquare class >> at: aPosition [

	^self new initializeAt: aPosition
]

{ #category : 'action' }
EmptySquare >> applyEffectTo: aShip in: aGame [
		
	 ^ self
]

{ #category : 'accessing' }
EmptySquare >> initializeAt: aPosition [
	
	super initializeAtPosition: aPosition.
]
