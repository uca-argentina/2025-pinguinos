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
AtomicBomb >> applyNormalEffectTo: aShip in: aGame [

	aGame moveAllShipsBackToStart.
	aGame breakShieldsOfAllShips
]
