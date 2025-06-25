"
A type of CardManager that does nothing.
"
Class {
	#name : 'EmptyCardManager',
	#superclass : 'CardManager',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
EmptyCardManager >> addEffect: aCardEffect [

	^ self
]

{ #category : 'adding' }
EmptyCardManager >> addMovement: aShip [

	^ 0
]

{ #category : 'getter' }
EmptyCardManager >> getAlliesOf: aShip [

	^ OrderedCollection new.
]

{ #category : 'initialization' }
EmptyCardManager >> initializeWithShips: aSetOfShips withBoard: aBoard withDeck: aDeck [

	^ self
]

{ #category : 'card usage' }
EmptyCardManager >> playCard: aCard by: aShip target: aTarget [

	^ self
]
