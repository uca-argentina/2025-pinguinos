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
	shields >= 1
		ifTrue: [ shields := shields - 1 ]
		ifFalse: [ turnsToSkip := turnsToSkip + 2 ].
]

{ #category : 'actions' }
Ship >> moveBy: aRolledNumber on: aBoard [

	| intendedPosition |
	intendedPosition := position + aRolledNumber.
	position := aBoard resolveMovementOf: intendedPosition.
]

{ #category : 'actions' }
Ship >> moveBy: aRolledNumber onCircularBoard: aCircularBoard [
	"Nuevo metodo para que sepan moverse sobre tablero circular"
	| intendedPosition resultingPosition |
	
	intendedPosition := position + aRolledNumber. 
	
	resultingPosition := aCircularBoard resolveMovementOf: intendedPosition.
	
	position := resultingPosition first.
	laps := laps + resultingPosition second. "Devuelve posicion final y la cantidad de vueltas que complete en este turno"
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
