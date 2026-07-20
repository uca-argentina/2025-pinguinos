"
Implementation of HyperJump special square.
"
Class {
	#name : 'HyperJump',
	#superclass : 'Square',
	#instVars : [
		'parsecList',
		'parsecListSize',
		'currentIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperJump class >> at: aPosition [

	^ self new initializeAt: aPosition
]

{ #category : 'action' }
HyperJump >> applyNormalEffectTo: aShip in: aGame [

	aGame hyperJump: aShip byParsecs: self parsecsToMove
]

{ #category : 'action' }
HyperJump >> applyReverseEffectTo: aShip in: aGame [

	aGame hyperJumpEveryoneExcept: aShip byParsecs: self parsecsToMove
]

{ #category : 'initialization' }
HyperJump >> initializeAt: position [

	parsecList := OrderedCollection new.
	parsecListSize := 5.
	currentIndex := 1.

	super initializeAt: position.

	1 to: parsecListSize do: [ :i | parsecList add: i + 1 ]
]

{ #category : 'accessing' }
HyperJump >> parsecsToMove [

	| returnValue |
	
	returnValue := parsecList at: currentIndex.
	currentIndex := currentIndex \\ parsecListSize + 1.

	^ returnValue
]
