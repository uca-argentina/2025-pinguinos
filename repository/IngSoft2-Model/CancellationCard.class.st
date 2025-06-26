"
Implementation of Cancellation card, from the instantaneous type of cards.
"
Class {
	#name : 'CancellationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
CancellationCard >> isRepeatable [

	^ true
]

{ #category : 'testing' }
CancellationCard >> isTurnRestricted [

	^ false
]

{ #category : 'action handling' }
CancellationCard >> managedBy: aCardManager from: anActivatorShip target: aTargetCard [

	aCardManager removeEffectOf: aTargetCard.
]
