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
	Board validateSizeIsPositive: aSize.
	^ self new initializeWithSize: aSize rounds: aRoundNumber
]

{ #category : 'creation' }
CircularBoard class >> withSize: aSize rounds: aRoundNumber withWormHoleFrom: wormHoleOrigin to: wormHoleEnd [

	self validateRoundNumberIsPositive: aRoundNumber.
	Board validateSizeIsPositive: aSize.
	
	self is: wormHoleOrigin and: wormHoleEnd withinBoundsOf: aSize.
	self areEnds: wormHoleOrigin and: wormHoleEnd inGoal: aSize.
	
	^ (self withSize: aSize rounds: aRoundNumber)
		initializeWithWormHoleFrom: wormHoleOrigin
		to: wormHoleEnd
]

{ #category : 'initialization' }
CircularBoard >> initializeWithSize: aSize rounds: aRoundNumber [ 
	
	super initializeWithSize: aSize. "Llamo a funcion de clase padre"

	rounds := aRoundNumber. 
]

{ #category : 'process' }
CircularBoard >> resolveMovementOf: anIntendedPosition [

	| finalPosition completedLaps |	
	
	completedLaps := 0.
	anIntendedPosition > boardSize ifTrue: [ completedLaps := (anIntendedPosition - 1 // boardSize) ]. "Si quiero moverme mas alla del tamaño, o sea si completo una vuelta, digo a la nave que completo una vuelta. anIntendedPosition -1 ya que las posiciones empiezan en 1 no en 0."
	finalPosition := ((anIntendedPosition - 1) \\ boardSize) + 1.

	^ {(map at: finalPosition) landingCoordinate . completedLaps } "Devuelvo tupla de ubicacion final a la que debe ir el Ship y vuelta en la que esta"
]

{ #category : 'validation' }
CircularBoard >> wasThisTheLastRoundFor: aShip [

	^ aShip laps >= (rounds + 1) "+1 Ya que conisderamos que las naves empiezan en la lap 1"
		
]
