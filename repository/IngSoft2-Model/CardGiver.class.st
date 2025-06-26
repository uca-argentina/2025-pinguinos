"
Implementation of CardGiver special square.
"
Class {
	#name : 'CardGiver',
	#superclass : 'Square',
	#instVars : [
		'deck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CardGiver class >> at: aPosition with: aDeck [

	^self new initializeAt: aPosition with: aDeck
]

{ #category : 'action' }
CardGiver >> applyEffectTo: aShip in: aBoard [

	aShip receive: deck drawCard
]

{ #category : 'accessing' }
CardGiver >> initializeAt: aPosition with: aDeck [
	
	super initializeAtPosition: aPosition.
	deck:= aDeck.
]
