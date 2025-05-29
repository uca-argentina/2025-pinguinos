"
Implementation of AtomicBomb special square.
"
Class {
	#name : 'AtomicBomb',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
AtomicBomb class >> at: aPosition [
	
	^ self new initializeAt: aPosition.
]

{ #category : 'action' }
AtomicBomb >> applyEffectTo: aShip in: aGame [
	
	aGame moveAllShipsBackToStart.
	aGame breakShieldsOfAllShips.
	
]

{ #category : 'initialization' }
AtomicBomb >> initializeAt: aPosition [
	
	super initializeX: aPosition .
]
