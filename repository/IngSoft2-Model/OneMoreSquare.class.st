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

{ #category : 'initialization' }
OneMoreSquare >> initializeWith: aTargetShip usedBy: aCard [

	targetShip := aTargetShip.
	usedBy := aCard.
	^ self
]
