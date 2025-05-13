"
A class featuring the ship, which will be moving through the board in the game.
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'shipName'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Ship >> initialize [

	super initialize.
	position := 1.

	^ self
]

{ #category : 'actions' }
Ship >> moveBy: aRolledNumber on: aBoard [
	
	| intendedPosition |
	
	intendedPosition := position + aRolledNumber.
	position := aBoard resolveMovementOf: intendedPosition.
]

{ #category : 'getter' }
Ship >> name [
	
	^ shipName
]

{ #category : 'getter' }
Ship >> position [
	
	^ position
]

{ #category : 'setter' }
Ship >> setPlayerNumber: aPlayerNumber [
	
	shipName := 'player ' , aPlayerNumber asString.
]
