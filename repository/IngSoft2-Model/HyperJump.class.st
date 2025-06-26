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

{ #category : 'instance creation' }
HyperJump class >> inBoardOfSize: aBoardSize at: aPosition [

	^ self new initializeInBoardOfSize: aBoardSize at: aPosition
]

{ #category : 'action' }
HyperJump >> applyEffectTo: aShip in: aGame [

	aGame move: aShip byParsecs: self parsecsToMove
]

{ #category : 'initialization' }
HyperJump >> initialize [

	super initialize.

	parsecList := OrderedCollection new.
	parsecListSize := 5.
	currentIndex := 1
]

{ #category : 'initialization' }
HyperJump >> initializeInBoardOfSize: aBoardSize at: position [

	| boardSizeInParsecs |
	
	super initializeAtPosition: position.
	boardSizeInParsecs := (CellUnit of: aBoardSize) convertToParsecs.
	
	1 to: parsecListSize do: [ :i |
	parsecList add: boardSizeInParsecs / (i + 1) ]
]

{ #category : 'accessing' }
HyperJump >> parsecsToMove [

	| returnValue |
	
	returnValue := parsecList at: currentIndex.
	currentIndex := currentIndex \\ parsecListSize + 1.

	^ returnValue
]
