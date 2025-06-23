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

{ #category : 'instance creation' }
MoonWalk class >> by: aNumberOfSquares at: aPosition [

	^ self new initializeWith: aNumberOfSquares at: aPosition
]

{ #category : 'instance creation' }
MoonWalk class >> by: aNumberOfSquares at: aPosition in: aBoard [

	| exit |
	
	exit := (aBoard getSquareAt: aPosition - aNumberOfSquares) getPosition.

	^ self new initializeTo: exit from: aPosition
]

{ #category : 'action' }
MoonWalk >> applyEffectTo: aShip in: aGame [

	aGame moveAllShipsBy: numberToMoveBackOtherShips exceptFor: aShip
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: numberToMoveBack at: position [

	super initializeAtPosition: position.
	numberToMoveBackOtherShips := -1 * numberToMoveBack "Me muevo para atras entonces negativo"
]
