"
Implementation of mercenary card, from the permanent type of cards.
"
Class {
	#name : 'AccelerationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action handling' }
AccelerationCard >> managedBy: aCardManager from: anActivatorShip target: aTargetShip [

	aCardManager addEffect:
		(OneMoreSquare toAnyUsedBy: self)
]
