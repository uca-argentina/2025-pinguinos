"
Blackhole in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'BlackHole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
BlackHole class >> at: aPosition [
	
	^ self new initializeAt: aPosition.
]

{ #category : 'action' }
BlackHole >> applyNormalEffectTo: aShip in: aGame [

	aGame moveAndIgnoreNewEffectsShip: aShip by: -4
]

{ #category : 'action' }
BlackHole >> applyReverseEffectTo: aShip in: aGame [

	aGame moveAndIgnoreNewEffectsAllShipsBy: -4 exceptFor: aShip
]
