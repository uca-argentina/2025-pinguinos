"
Implementation of a card.
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action handling' }
Card >> managedBy: aCardManager target: aTarget [

	self subclassResponsibility
]
