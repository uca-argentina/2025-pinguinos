"
Represents the normal state of an entity.
"
Class {
	#name : 'NormalState',
	#superclass : 'State',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
NormalState >> addMovementFrom: anAdditionalSquares to: aShip [

	^ anAdditionalSquares addNormalMovementTo: aShip
]

{ #category : 'action' }
NormalState >> applyEffectFrom: aSquare to: aShip in: aGame [

	aSquare applyNormalEffectTo: aShip in: aGame
]

{ #category : 'action' }
NormalState >> getAllyOf: aShip against: anOpponent from: aContract [

	^ aContract applyNormalContractTo: aShip against: anOpponent
]

{ #category : 'highlighting' }
NormalState >> reverse [ 

	^ ReversedState new
]
