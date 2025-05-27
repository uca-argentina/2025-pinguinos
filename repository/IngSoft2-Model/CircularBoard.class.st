"
Circular board class for board game; has a number of rounds to play in the same board.
"
Class {
	#name : 'CircularBoard',
	#superclass : 'Board',
	#instVars : [
		'rounds'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
CircularBoard class >> validateRoundNumberIsPositive: aRoundNumber [

	aRoundNumber < 1 ifTrue: [
		Error signal: 'Round number for the board must be positive.' ]
]

{ #category : 'creation' }
CircularBoard class >> withSize: aSize rounds: aRoundNumber [ 
	self validateRoundNumberIsPositive: aRoundNumber.
	^ self new initializeWithSize: aSize rounds: aRoundNumber 
]

{ #category : 'creation' }
CircularBoard class >> withSize: aSize rounds: aRoundNumber withWormHoleFrom: wormHoleOrigin to: wormHoleEnd [

	self validateRoundNumberIsPositive: aRoundNumber.
	
	self is: wormHoleOrigin and: wormHoleEnd withinBoundsOf: aSize.
	self areEnds: wormHoleOrigin and: wormHoleEnd inGoal: aSize.
	
	^ (self withSize: aSize rounds: aRoundNumber)
		initializeWithWormHoleFrom: wormHoleOrigin
		to: wormHoleEnd
]

{ #category : 'initialization' }
CircularBoard >> initializeWithSize: aSize rounds: aRoundNumber [ 
	
	super initializeWithSize: aSize.

	rounds := aRoundNumber.
]

{ #category : 'process' }
CircularBoard >> resolveMovementOf: anIntendedPosition [

	| finalPosition finalLapNumber |
	
	finalPosition := anIntendedPosition first.
	finalLapNumber := anIntendedPosition second.
	
	finalPosition > boardSize ifTrue: [ finalLapNumber := finalLapNumber + (finalPosition - 1 // boardSize) ].
	finalPosition := finalPosition \\ boardSize + 1.

	^ {(map at: finalPosition) landingCoordinate . finalLapNumber }
]

{ #category : 'validation' }
CircularBoard >> wasThisTheLastRoundFor: aShip [

	^ aShip laps >= rounds
		
]
