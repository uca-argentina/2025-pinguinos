"
Board class for board game.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'map'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Board class >> validateSizeIsPositive: aSize [
	aSize < 0 ifTrue: [ Error signal: 'Size for the grid must be positive.' ]
]

{ #category : 'creation' }
Board class >> withSize: aSize [ 
	self validateSizeIsPositive: aSize.
	^self new initializeWithSize: aSize.
]

{ #category : 'initialization' }
Board >> initializeWithSize: aSize [ 
	
	boardSize := aSize.
	
   map := OrderedCollection new.

   1 to: boardSize do: [:x | map add: (Square x: x)].



]

{ #category : 'process' }
Board >> resolveMovementOf: anIntendedPosition [
	
	| returnValue |
	
	returnValue := anIntendedPosition.
	anIntendedPosition > boardSize ifTrue: [ returnValue := boardSize ].
	
	^ returnValue
]

{ #category : 'accessing' }
Board >> size [ 
	^ boardSize
]

{ #category : 'squareMethods' }
Board >> squareStatus: aPosition [ 

	| aSquare |

	aSquare:= map at: aPosition.

	^ aSquare checkStatus.
]
