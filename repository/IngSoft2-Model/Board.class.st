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

{ #category : 'initialization' }
Board >> initializeWithGridSize: aSize [ 
	
	gridSize:= aSize.
	
   squareMap := OrderedCollection new.
   0 to: gridSize do: [:x | squareMap add: (Square x: x)].

	ships := Dictionary new.



]

{ #category : 'movement' }
Board >> moveShip: aShip by: aRolledNumber [

    | currentPos newPos |
    
    currentPos := self positionOf: aShip.
    currentPos ifNil: [ Error signal: 'Ship is not on the board' ].

    newPos := currentPos + aRolledNumber.
    newPos >= gridSize ifTrue: [ newPos := gridSize - 1 ]. 

    ships removeKey: currentPos.
    ships at: newPos put: aShip.

]

{ #category : 'initialization' }
Board >> placeShip: aShip at: aPosition [
    ships at: aPosition put: aShip.

]

{ #category : 'accessing' }
Board >> positionOf: aShip [
    ^ ships keyAtValue: aShip ifAbsent: [ nil ].

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
