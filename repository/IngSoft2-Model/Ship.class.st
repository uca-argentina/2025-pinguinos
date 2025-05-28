"
A class featuring the ship, which will be moving through the board in the game.
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'shipName',
		'laps',
		'shields',
		'turnsToSkip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Ship class >> named: aName [

	^ self new initializeName: aName
]

{ #category : 'accessing' }
Ship >> canIPlayTurn [
	
	^ turnsToSkip = 0
]

{ #category : 'actions' }
Ship >> completeLaps: aNumberOfLaps [
	
	laps := laps + aNumberOfLaps.
]

{ #category : 'initialization' }
Ship >> initialize [

	super initialize.
	position := 1.
	laps := 1.
	shields := 3.
	turnsToSkip := 0.
]

{ #category : 'initialization' }
Ship >> initializeName: aName [
	
	shipName := aName.
]

{ #category : 'accessing' }
Ship >> laps [

	^ laps
]

{ #category : 'actions' }
Ship >> loseFight [

	position := 1.
	shields >= 1 ifTrue: [ self loseShield ].
	shields = 0 ifTrue: [ turnsToSkip := turnsToSkip + 2 ].
]

{ #category : 'actions' }
Ship >> loseShield [
	
	 shields := shields - 1.
]

{ #category : 'actions' }
Ship >> moveBackwardTo: aSquare [

	position := aSquare getX. "Dont care about effect"
]

{ #category : 'actions' }
Ship >> moveBy: aRolledNumber on: aBoard [

	| intendedPosition |
	intendedPosition := position + aRolledNumber.
	position := aBoard resolveMovementOf: intendedPosition.
]

{ #category : 'actions' }
Ship >> moveBy: aRolledNumber onCircularBoard: aCircularBoard of: aGame [
	"Nuevo metodo para que sepan moverse sobre tablero circular"

	| intendedPosition resultingPosition resultingSquare completedLaps |
	intendedPosition := position + aRolledNumber.

	resultingPosition := aCircularBoard resolveMovementOf: intendedPosition. "Devuelve cuadrado en el que cai y la cantidad de vueltas que complete en este turno"

	resultingSquare := resultingPosition first.
	completedLaps := resultingPosition second.

	intendedPosition > position
		ifTrue: [
			self moveForwardTo: resultingSquare.
			resultingSquare applyEffectTo: self in: aGame ]
		ifFalse: [ self moveBackwardTo: resultingSquare ].
		
	self completeLaps: completedLaps
]

{ #category : 'actions' }
Ship >> moveForwardTo: aSquare [

	position := aSquare landingCoordinate.
]

{ #category : 'getter' }
Ship >> name [

	^ shipName
]

{ #category : 'getter' }
Ship >> position [

	^ position
]

{ #category : 'actions' }
Ship >> recoverShields [

	shields := 3.
]

{ #category : 'getter' }
Ship >> remainingShields [

	^ shields 
]

{ #category : 'actions' }
Ship >> turnSkipped [
	
	self recoverShields.
	turnsToSkip := turnsToSkip - 1.
]
