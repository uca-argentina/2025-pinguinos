"
HyperSpaceJump in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
HyperSpaceJump class >> at: aPosition [
	
	^ self new initializeAt: aPosition.
]

{ #category : 'action' }
HyperSpaceJump >> applyNormalEffectTo: aShip in: aGame [

	aGame moveAndIgnoreNewEffectsShip: aShip by: 4.
	aShip loseShield
]

{ #category : 'action' }
HyperSpaceJump >> applyReverseEffectTo: aShip in: aGame [

	aGame moveAndIgnoreNewEffectsAllShipsBy: 4 exceptFor: aShip.
	aGame breakShieldsOfAllShipsExceptFor: aShip
]
