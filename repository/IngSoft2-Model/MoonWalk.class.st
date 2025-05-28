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
	
	^ self new initializeWith: aNumberOfSquares at: aPosition.
]

{ #category : 'action' }
MoonWalk >> applyEffectTo: aShip in: aGame [
	
	aGame moveAllShipsBackBy: numberToMoveBackOtherShips exceptFor: aShip.
	
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: numberToMoveBack at: position [
	
	super initializeX: position.
	numberToMoveBackOtherShips := numberToMoveBack.
]
