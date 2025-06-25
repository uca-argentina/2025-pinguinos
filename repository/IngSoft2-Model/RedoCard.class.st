"
Implementation of redo card, from the instantaneous type of cards.
"
Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
RedoCard >> isRepeatable [

	^ false
]

{ #category : 'testing' }
RedoCard >> isTurnRestricted [

	^ false
]

{ #category : 'action handling' }
RedoCard >> managedBy: aCardManager from: anActivatorShip target: aTarget [
	
	| cardHistory |
	
	cardHistory := aCardManager getLastUsedCards.
	cardHistory := cardHistory select: [ :usedCard | usedCard isRepeatable ].
	
	cardHistory ifEmpty: [ Error signal: 'No cards have been played yet, this card cannot be used!' ].
	
	(cardHistory last) managedBy: aCardManager from: anActivatorShip target: aTarget.
]
