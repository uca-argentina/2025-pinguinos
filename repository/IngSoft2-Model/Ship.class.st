"
A class featuring the ship, which will be moving through the board in the game.
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'shipName',
		'shipNumber'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Ship class >> name: aName [
	^self new initializeName: aName.
]

{ #category : 'initialization' }
Ship >> initialize [

	super initialize.
	position := 1
]

{ #category : 'initialization' }
Ship >> initializeName: aName [
	
	shipName := aName.
]

{ #category : 'actions' }
Ship >> moveBy: arg1 on: arg2 [

	| tmp1 |
	tmp1 := position + arg1.
	position := arg2 resolveMovementOf: tmp1
]

{ #category : 'getter' }
Ship >> name [
	shipName ifNil: [ shipName:= 'player ', shipNumber asString].
	^ shipName
]

{ #category : 'api' }
Ship >> number [

	^ shipNumber
]

{ #category : 'getter' }
Ship >> position [

	^ position
]

{ #category : 'setter' }
Ship >> setPlayerNumber: aPlayerNumber [
	
	shipNumber := aPlayerNumber asString.
]
