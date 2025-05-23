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
Board class >> areEnds: wormHoleOrigin and: wormHoleEnd inGoal: aSize [
	
	((wormHoleOrigin = aSize) or: (wormHoleEnd = aSize))
		ifTrue: [
			Error signal:
				'Wormhole cannot lead out of/into last square!' ]
]

{ #category : 'validation' }
Board class >> areEndsDistinct: wormHoleOrigin and: wormHoleEnd [

	wormHoleOrigin = wormHoleEnd ifTrue: [
		Error signal: 'Wormhole cannot lead to itself!' ]
]

{ #category : 'testing' }
Board class >> is: startPoint and: endPoint withinBoundsOf: size [

	| range |
	range := 1 to: size.
	((range includes: startPoint) and: (range includes: endPoint))
		ifFalse: [
			Error signal:
				'WormHole must have both its ends leading to valid positions inside the limits of the board!' ]
]

{ #category : 'validation' }
Board class >> validateSizeIsPositive: aSize [

	aSize < 0 ifTrue: [
		Error signal: 'Size for the grid must be positive.' ]
]

{ #category : 'creation' }
Board class >> withSize: aSize [

	self validateSizeIsPositive: aSize.
	^ self new initializeWithSize: aSize
]

{ #category : 'creation' }
Board class >> withSize: aSize withWormHoleFrom: wormHoleOrigin to: wormHoleEnd [

	self is: wormHoleOrigin and: wormHoleEnd withinBoundsOf: aSize.
	self areEndsDistinct: wormHoleOrigin and: wormHoleEnd.
	self areEnds: wormHoleOrigin and: wormHoleEnd inGoal: aSize.
	
	^ (self withSize: aSize)
		initializeWithWormHoleFrom: wormHoleOrigin
		to: wormHoleEnd
]

{ #category : 'getter' }
Board >> getSquareAt: aPosition [

	^ (map at: aPosition)
]

{ #category : 'initialization' }
Board >> initializeWithSize: aSize [ 
	
	boardSize := aSize.
	
   map := OrderedCollection new.

   1 to: boardSize do: [:x | map add: (Square x: x)].



]

{ #category : 'initialization' }
Board >> initializeWithWormHoleFrom: wormHoleOrigin to: wormHoleEnd [
	
	(map at: wormHoleOrigin) pointTo: wormHoleEnd.
	(map at: wormHoleEnd ) pointTo: wormHoleOrigin.


]

{ #category : 'squareMethods' }
Board >> isThisSquareTheGoal: aSquareNumber [

	^ aSquareNumber = boardSize
]

{ #category : 'process' }
Board >> resolveMovementOf: anIntendedPosition [

	| anIntendedPositionWithinBounds |
	anIntendedPositionWithinBounds := anIntendedPosition min: boardSize.
	^ (map at: anIntendedPositionWithinBounds) pointsTo
]

{ #category : 'accessing' }
Board >> size [ 
	^ boardSize
]

{ #category : 'squareMethods' }
Board >> squareStatus: aPosition [

	| aSquare |
	aSquare := map at: aPosition.

	^ aSquare checkStatus
]
