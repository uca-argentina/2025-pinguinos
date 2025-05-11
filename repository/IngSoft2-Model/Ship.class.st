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
    position := 0.
    ^ self.

]

{ #category : 'accessing' }
Ship >> move: aRolledNumber [

	position:= aRolledNumber.
]

{ #category : 'accessing' }
Ship >> position [
	^ position.
]
