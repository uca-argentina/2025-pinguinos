"
Implementation of a card.
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Card class >> isAbstract [

	^ self == Card
]

{ #category : 'testing' }
Card >> isRepeatable [

	self subclassResponsibility 
]

{ #category : 'testing' }
Card >> isTurnRestricted [

	self subclassResponsibility 
]

{ #category : 'action handling' }
Card >> managedBy: aCardManager from: anActivatorShip target: aTargetShip [

	self subclassResponsibility
]
