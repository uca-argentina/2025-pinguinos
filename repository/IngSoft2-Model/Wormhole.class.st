"
Wormhole in grid for the game; to be occupied with a ship, which comes out from the other end.
"
Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Wormhole class >> areEndsDistinct: wormHoleOrigin and: wormHoleEnd [

	wormHoleOrigin = wormHoleEnd ifTrue: [
		Error signal: 'Wormhole cannot lead to itself!' ]
]

{ #category : 'accessing' }
Wormhole class >> firstPosition: aFirstPosition secondPosition: aSecondPosition [

	self validateFirstPositionIsPositive: aFirstPosition.
	self validateSecondPositionIsPositive: aSecondPosition.
	
	self areEndsDistinct: aFirstPosition and: aSecondPosition.
	
	^self new initializeFirstPosition: aFirstPosition secondPosition: aSecondPosition.
]

{ #category : 'validation' }
Wormhole class >> validateFirstPositionIsPositive: aPosition [

	aPosition < 0 ifTrue: [
		Error signal: 'First position position must be positive.' ]
]

{ #category : 'validation' }
Wormhole class >> validateSecondPositionIsPositive: aPosition [

	aPosition < 0 ifTrue: [
		Error signal: 'Second position position must be positive.' ]
]

{ #category : 'accessing' }
Wormhole >> firstPosition [
	^x
]

{ #category : 'initialization' }
Wormhole >> initializeFirstPosition: aFirstPosition secondPosition: aSecondPosition [

	x := aFirstPosition.	
	finalDestination := aSecondPosition.
	
	self setStatus: 'Free'.
]

{ #category : 'accessing' }
Wormhole >> secondPosition [
	^finalDestination.
]
