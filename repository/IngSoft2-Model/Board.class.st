"
Board class for board game.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'gridSize',
		'squareMap',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Board class >> validateSizeIsPositive: aSize [
	aSize < 0 ifTrue: [ Error signal: 'Size for the grid must be positive.' ]
]

{ #category : 'creation' }
Board class >> withGridSize: aSize [ 
	self validateSizeIsPositive: aSize.
	^self new initializeWithGridSize: aSize.
]

{ #category : 'accessing' }
Board >> size [ 
	^ gridSize.
]

{ #category : 'squareMethods' }
Board >> squareStatus: aPosition [ 

	| aSquare |

	aSquare:= squareMap at: aPosition.

	^ aSquare checkStatus.
]
