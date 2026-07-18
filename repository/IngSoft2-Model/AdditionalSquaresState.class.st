"
An abstract class that represents the state of a permanent effect

"
Class {
	#name : 'AdditionalSquaresState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
AdditionalSquaresState >> addMovementFrom: anAdditionalSquares to: aShip [
	
	self subclassResponsibility 
]

{ #category : 'highlighting' }
AdditionalSquaresState >> reverse [

	self subclassResponsibility 
]
