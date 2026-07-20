"
Implementation of MoonWalk special square.
"
Class {
	#name : 'MoonWalk',
	#superclass : 'Square',
	#instVars : [
		'numberToMoveBackOtherShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
MoonWalk class >> by: aNumberOfSquares at: aPosition [

	^ self new initializeWith: aNumberOfSquares at: aPosition
]

{ #category : 'action' }
MoonWalk >> applyNormalEffectTo: aShip in: aGame [

	aGame
		moveAndIgnoreNewEffectsAllShipsBy: numberToMoveBackOtherShips
		exceptFor: aShip
]

{ #category : 'action' }
MoonWalk >> applyReverseEffectTo: aShip in: aGame [

	aGame
		moveAndIgnoreNewEffectsShip: aShip
		by: numberToMoveBackOtherShips
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: numberToMoveBack at: position [

	super initializeAt: position.
	numberToMoveBackOtherShips := -1 * numberToMoveBack "Me muevo para atras entonces negativo"
]
