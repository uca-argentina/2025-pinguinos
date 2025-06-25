"
Implementation of Acceleration card, from the permanent type of cards.
"
Class {
	#name : 'AccelerationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
AccelerationCard >> isTurnRestricted [

	^ true
]

{ #category : 'action handling' }
AccelerationCard >> managedBy: aCardManager from: anActivatorShip target: aTargetShip [

	aCardManager addEffect:
		(OneMoreSquare toAnyUsedBy: self)
]
