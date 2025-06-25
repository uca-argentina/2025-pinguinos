"
A type of CardManager that does nothing.
"
Class {
	#name : 'NullCardManager',
	#superclass : 'CardManager',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
NullCardManager >> addEffect: aCardEffect [

	^ self
]

{ #category : 'adding' }
NullCardManager >> addMovement: aShip [

	^ 0
]

{ #category : 'getter' }
NullCardManager >> getAlliesOf: aShip [

	^ OrderedCollection new.
]

{ #category : 'getter' }
NullCardManager >> getContractedShips [

	^ OrderedCollection new
]

{ #category : 'initialization' }
NullCardManager >> initializeWithShips: aSetOfShips withBoard: aBoard withDeck: aDeck [

	^ self
]

{ #category : 'card usage' }
NullCardManager >> playCard: aCard by: aShip target: aTarget [

	^ self
]
