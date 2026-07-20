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
		'turnsToSkip',
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Ship class >> named: aName [

	^ self new initializeName: aName
]

{ #category : 'adding' }
Ship >> addCards: aSetOfCards [

	cards:= aSetOfCards.
]

{ #category : 'accessing' }
Ship >> canIPlayTurn [

	^ turnsToSkip = 0
]

{ #category : 'accessing' }
Ship >> cards [
	^ cards.
]

{ #category : 'actions' }
Ship >> completeLaps: aNumberOfLaps [

	laps := laps + aNumberOfLaps
]

{ #category : 'testing' }
Ship >> hasAny: aCard [

	(cards includes: aCard) ifFalse: [
		Error signal: 'This ship cannot play this card because it does not have it!' ]
]

{ #category : 'initialization' }
Ship >> initializeName: aName [
	
	position := 1.
	laps := 1.
	shields := 3.
	turnsToSkip := 0.
	cards := OrderedCollection new.
	
	shipName := aName
]

{ #category : 'accessing' }
Ship >> laps [

	^ laps
]

{ #category : 'actions' }
Ship >> loseFight [

	position := 1.
	self loseShield.
	shields = 0 ifTrue: [ turnsToSkip := turnsToSkip + 2 ]
]

{ #category : 'actions' }
Ship >> loseShield [
	
	 shields >= 1 ifTrue: [ shields := shields - 1 ].
	 
]

{ #category : 'actions' }
Ship >> moveBy: aRolledNumber on: aBoard of: aGame [

	| intendedPosition landingSquare |
	intendedPosition := position + aRolledNumber.
	landingSquare := aBoard resolveMovementOf: intendedPosition.
	position := landingSquare landingCoordinate.
	landingSquare applyEffectTo: self in: aGame.
]

{ #category : 'actions' }
Ship >> moveBy: aRolledNumber onCircularBoard: aCircularBoard of: aGame [

	| intendedPosition resultingPosition resultingSquare completedLaps |

	intendedPosition := position + aRolledNumber.


	resultingPosition := aCircularBoard resolveMovementOf:
		                     intendedPosition.

	resultingSquare := resultingPosition first.
	completedLaps := resultingPosition second.

	aCircularBoard lastEffectUsed: resultingSquare.
	
	self moveTo: resultingSquare.
	
	intendedPosition >= position ifTrue: [
		resultingSquare applyEffectTo: self in: aGame ].

	self completeLaps: completedLaps
]

{ #category : 'actions' }
Ship >> moveTo: aSquare [

	position := aSquare landingCoordinate
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
Ship >> receive: aCard [

	cards add: aCard
]

{ #category : 'actions' }
Ship >> recoverShields [

	shields := 3.
]

{ #category : 'getter' }
Ship >> remainingShields [

	^ shields 
]

{ #category : 'removing' }
Ship >> removeCard: aCard [

	cards remove: aCard

]

{ #category : 'actions' }
Ship >> turnSkipped [
	
	self recoverShields.
	turnsToSkip := turnsToSkip - 1.
]

{ #category : 'actions' }
Ship >> withNoEffectsMoveBy: aRolledNumber onCircularBoard: aCircularBoard [

	| intendedPosition resultingPosition resultingSquare completedLaps |
	
	intendedPosition := position + aRolledNumber.

	resultingPosition := aCircularBoard resolveMovementOf:
		                     intendedPosition. "Devuelve cuadrado en el que cai y la cantidad de vueltas que complete en este turno"

	resultingSquare := resultingPosition first.
	completedLaps := resultingPosition second.

	position := resultingSquare getPosition.
	self completeLaps: completedLaps
]
