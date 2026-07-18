"
Represents the reversed state of a permanent effect
"
Class {
	#name : 'ReversedAdditionalSquaresState',
	#superclass : 'AdditionalSquaresState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
ReversedAdditionalSquaresState >> addMovementFrom: anAdditionalSquares to: aShip [

	^ anAdditionalSquares addReverseMovementTo: aShip
]

{ #category : 'highlighting' }
ReversedAdditionalSquaresState >> reverse [ 

	^ NormalAdditionalSquaresState new
]
