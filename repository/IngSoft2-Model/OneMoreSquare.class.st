"
Implementation of speed card effect, which gives the ship an extra square position.
"
Class {
	#name : 'OneMoreSquare',
	#superclass : 'PermanentEffects',
	#instVars : [
		'targetShip',
		'usedBy'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
OneMoreSquare class >> to: aTargetShip usedBy: aCard [

	^ self new initializeWith: aTargetShip usedBy: aCard
]

{ #category : 'one more square' }
OneMoreSquare >> addMovement: aShip [

	^ targetShip name = aShip name
		  ifTrue: [ 1 ]
		  ifFalse: [ 0 ]
]

{ #category : 'initialization' }
OneMoreSquare >> initializeWith: aTargetShip usedBy: aCard [

	targetShip := aTargetShip.
	usedBy := aCard.
	^ self
]
