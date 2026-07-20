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
Board class >> areEnds: awormHoleOrigin and: wormHoleEnd inGoal: aSize [

	(awormHoleOrigin = aSize or: wormHoleEnd = aSize) ifTrue: [
		Error signal: 'Wormhole cannot lead out of/into last square!' ]
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

	aSize <= 0 ifTrue: [
		Error signal: 'Size for the grid must be positive.' ]
]

{ #category : 'validation' }
Board class >> validateWormHoleFrom: anOrigin to: aDestination in: aBoardSize [
	
	self is: anOrigin and: aDestination withinBoundsOf: aBoardSize.
	self areEnds: anOrigin and: aDestination inGoal: aBoardSize.
]

{ #category : 'creation' }
Board class >> withSize: aSize [

	self validateSizeIsPositive: aSize.
	^ self new initializeWithSize: aSize
]

{ #category : 'creation' }
Board class >> withSize: aSize withWormHoleFrom: wormHoleOrigin to: wormHoleEnd [

	self validateWormHoleFrom: wormHoleOrigin to: wormHoleEnd in: aSize. 

	^ (self withSize: aSize)
		  initializeWithWormHoleFrom: wormHoleOrigin
		  to: wormHoleEnd
]

{ #category : 'accessing' }
Board >> getSquareAt: aPosition [

	^ map at: aPosition - 1 \\ boardSize + 1
]

{ #category : 'initialization' }
Board >> initializeWithSize: aSize [

	boardSize := aSize.

	map := OrderedCollection new.

	1 to: boardSize do: [ :x | map add: (EmptySquare at: x) ].
	
]

{ #category : 'initialization' }
Board >> initializeWithWormHoleFrom: wormHoleOrigin to: wormHoleEnd [

	| wormHoleEnds |
	wormHoleEnds := Wormhole from: wormHoleOrigin to: wormHoleEnd.

	map at: wormHoleOrigin put: wormHoleEnds first.
	map at: wormHoleEnd put: wormHoleEnds second
]

{ #category : 'squareMethods' }
Board >> isThisSquareTheGoal: aSquare [

	^ aSquare = boardSize
]

{ #category : 'process' }
Board >> resolveMovementOf: anIntendedPosition [

	| anIntendedPositionWithinBounds |
	
	anIntendedPositionWithinBounds := anIntendedPosition min: boardSize.
	^ (map at: anIntendedPositionWithinBounds)
]

{ #category : 'accessing' }
Board >> size [

	^ boardSize
]
