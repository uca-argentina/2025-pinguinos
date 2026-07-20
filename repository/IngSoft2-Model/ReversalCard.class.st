"
Implementation of card that reverses effects of a permanent card previously played
"
Class {
	#name : 'ReversalCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
ReversalCard >> isRepeatable [

	^ true
]

{ #category : 'testing' }
ReversalCard >> isTurnRestricted [

	^ false
]

{ #category : 'action handling' }
ReversalCard >> managedBy: aCardManager from: anActivatorShip target: aTargetCard [

	aCardManager reverseEffectOf: aTargetCard.
]
