"
Implementation of repeat card, from the instantaneous type of cards.
"
Class {
	#name : 'RepeatCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
RepeatCard >> isRepeatable [

	^ false
]

{ #category : 'testing' }
RepeatCard >> isTurnRestricted [

	^ false
]

{ #category : 'action handling' }
RepeatCard >> managedBy: aCardManager from: anActivatorShip target: aTargetShip [

	aCardManager applyLastSquareEffectTo: aTargetShip
]
