"
Implementation of speed card effect, which gives the ship an extra square position.
"
Class {
	#name : 'OneMoreSquare',
	#superclass : 'PermanentEffects',
	#instVars : [
		'targetShip',
		'applyToEveryone'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
OneMoreSquare class >> to: aTargetShip usedBy: aCard [

	^ self new initializeWith: aTargetShip usedBy: aCard
]

{ #category : 'creation' }
OneMoreSquare class >> toAnyUsedBy: aCard [

	^ self new initializeToAnyUsedBy: aCard
]

{ #category : 'one more square' }
OneMoreSquare >> addMovement: aShip [

	^ (applyToEveryone or: targetShip name = aShip name)
		  ifTrue: [ 1 ]
		  ifFalse: [ 0 ]
]

{ #category : 'initialization' }
OneMoreSquare >> initializeToAnyUsedBy: aCard [

	applyToEveryone := true.
	targetShip := NullShip new.
	usedBy := aCard.
	^ self
]

{ #category : 'initialization' }
OneMoreSquare >> initializeWith: aTargetShip usedBy: aCard [
	
	applyToEveryone := false.
	targetShip := aTargetShip.
	usedBy := aCard.
	^ self
]
