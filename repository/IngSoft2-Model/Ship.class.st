"
A class featuring the ship, which will be moving through the board in the game.
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Ship >> initialize [
    super initialize. 
    position := 1.
    ^ self.

]

{ #category : 'accessing' }
Ship >> move: aRolledNumber [

	position:= position + aRolledNumber.
]

{ #category : 'accessing' }
Ship >> moveBy: aRolledNumber on: aBoard [
	
	| intendedPosition |
	
	intendedPosition := position + aRolledNumber.
	position := aBoard resolveMovementOf: intendedPosition.
]

{ #category : 'accessing' }
Ship >> position [
	^ position.
]
