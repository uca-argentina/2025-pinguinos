"
Implementation of a loaded die, that responds to the message: 'roll', and returns a pre defined number N.
"
Class {
	#name : 'LoadedDie',
	#superclass : 'Die',
	#instVars : [
		'index'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
LoadedDie class >> withSides: arg1 [

	^ self new initializeWith: arg1
]

{ #category : 'initialization' }
LoadedDie >> initializeWith: arg1 [

	sideNumber := arg1.
	index := 1
]

{ #category : 'random' }
LoadedDie >> roll [

	| tmp1 |
	sideNumber isInteger ifTrue: [ ^ sideNumber ].
	nil.
	tmp1 := sideNumber at: index.
	index := index \\ sideNumber size + 1.
	^ tmp1
]
