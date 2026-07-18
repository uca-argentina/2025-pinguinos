"
Represents the normal state of a permanent effect
"
Class {
	#name : 'NormalAdditionalSquaresState',
	#superclass : 'AdditionalSquaresState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
NormalAdditionalSquaresState >> addMovementFrom: anAdditionalSquares to: aShip [

	^ anAdditionalSquares addNormalMovementTo: aShip
]

{ #category : 'highlighting' }
NormalAdditionalSquaresState >> reverse [ 

	^ ReversedAdditionalSquaresState new
]
