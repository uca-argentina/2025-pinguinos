"
Represents the reversed state of an entity.
"
Class {
	#name : 'ReversedState',
	#superclass : 'State',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
ReversedState >> addMovementFrom: anAdditionalSquares to: aShip [

	^ anAdditionalSquares addReverseMovementTo: aShip
]

{ #category : 'action' }
ReversedState >> applyEffectFrom: aSquare to: aShip in: aGame [

	aSquare applyReverseEffectTo: aShip in: aGame
]

{ #category : 'action' }
ReversedState >> getAllyOf: aShip against: anOpponent from: aContract [

	^ aContract applyReverseContractTo: aShip against: anOpponent
]

{ #category : 'highlighting' }
ReversedState >> reverse [ 

	^ NormalState new
]
