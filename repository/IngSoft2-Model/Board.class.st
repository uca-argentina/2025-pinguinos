"
Board class for board game.
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'boardSize',
		'map',
		'rounds'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Board class >> areEnds: arg1 and: arg2 inGoal: arg3 [

	(arg1 = arg3 or: arg2 = arg3) ifTrue: [
		Error signal: 'Wormhole cannot lead out of/into last square!' ]
]

{ #category : 'testing' }
Board class >> is: arg1 and: arg2 withinBoundsOf: arg3 [

	| tmp1 |
	tmp1 := 1 to: arg3.
	((tmp1 includes: arg1) and: (tmp1 includes: arg2)) ifFalse: [
		Error signal:
			'WormHole must have both its ends leading to valid positions inside the limits of the board!' ]
]

{ #category : 'validation' }
Board class >> validateSizeIsPositive: arg1 [

	arg1 < 0 ifTrue: [
		Error signal: 'Size for the grid must be positive.' ]
]

{ #category : 'creation' }
Board class >> withSize: arg1 [

	self validateSizeIsPositive: arg1.
	^ self new initializeWithSize: arg1
]

{ #category : 'creation' }
Board class >> withSize: aSize withWormHoleFrom: wormHoleOrigin to: wormHoleEnd [

	self is: wormHoleOrigin and: wormHoleEnd withinBoundsOf: aSize.
	self areEnds: wormHoleOrigin and: wormHoleEnd inGoal: aSize.
	
	^ (self withSize: aSize)
		initializeWithWormHoleFrom: wormHoleOrigin
		to: wormHoleEnd
]

{ #category : 'creation' }
Board class >> withWormhole: aWormhole [

	^ self new initializeWithWormhole: aWormhole
]

{ #category : 'getter' }
Board >> getSquareAt: arg1 [

	^ map at: arg1
]

{ #category : 'initialization' }
Board >> initializeWithSize: aSize [ 
	
	boardSize := aSize.
	
	rounds:= 1.
	
   map := OrderedCollection new.

   1 to: boardSize do: [:x | map add: (Square x: x)].



]

{ #category : 'initialization' }
Board >> initializeWithWormHoleFrom: wormHoleOrigin to: wormHoleEnd [
	
	| wormHoleEnds |
	wormHoleEnds := Wormhole from: wormHoleOrigin to: wormHoleEnd.
	
	map at: wormHoleOrigin put: (wormHoleEnds first).
	map at: wormHoleEnd put: (wormHoleEnds second).


]

{ #category : 'squareMethods' }
Board >> isThisSquareTheGoal: aSquare [

	^ aSquare = boardSize
]

{ #category : 'testing' }
Board >> isThisTheLastRoundFor: aShip [
	aShip laps = rounds ifTrue: [ ^true ] ifFalse: [ aShip lapCounter . ^false ]

]

{ #category : 'process' }
Board >> resolveMovementOf: anIntendedPosition [

	| anIntendedPositionWithinBounds |
	anIntendedPositionWithinBounds := anIntendedPosition min: boardSize.
	^ (map at: anIntendedPositionWithinBounds) landingCoordinate
]

{ #category : 'accessing' }
Board >> size [

	^ boardSize
]

{ #category : 'squareMethods' }
Board >> squareStatus: arg1 [

	| tmp1 |
	tmp1 := map at: arg1.
	^ tmp1 checkStatus
]
