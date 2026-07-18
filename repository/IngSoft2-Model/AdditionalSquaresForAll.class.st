"
Additional squares effect to every ship
"
Class {
	#name : 'AdditionalSquaresForAll',
	#superclass : 'AdditionalSquares',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
AdditionalSquaresForAll class >> of: aNumber usedBy: aCard [

	^ self new
		  initializeOf: aNumber
		  usedBy: aCard
]

{ #category : 'one more square' }
AdditionalSquaresForAll >> addNormalMovementTo: aShip [

	^ numberOfSquares
]

{ #category : 'adding' }
AdditionalSquaresForAll >> addReverseMovementTo: aShip [

	^ numberOfSquares negated
]
