"
A permanent card that inverts the target of a particular square.
"
Class {
	#name : 'ReversePolarityCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
ReversePolarityCard >> isRepeatable [

	^ true
]

{ #category : 'testing' }
ReversePolarityCard >> isTurnRestricted [

	^ true
]

{ #category : 'action handling' }
ReversePolarityCard >> managedBy: aCardManager from: anActivatorShip target: aSquare [

	aSquare reversePolarity.
]
