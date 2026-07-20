"
Square in grid for the game; to be occupied with a ship.
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'origin',
		'squareState'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Square class >> isAbstract [

	^ self == Square
]

{ #category : 'action' }
Square >> applyEffectTo: aShip in: aGame [

	squareState applyEffectFrom: self to: aShip in: aGame
]

{ #category : 'action' }
Square >> applyNormalEffectTo: aShip in: aGame [ 

	^ self
]

{ #category : 'action' }
Square >> applyReverseEffectTo: aShip in: aGame [ 

	^ self
]

{ #category : 'getter' }
Square >> getPosition [

	^ origin
]

{ #category : 'initialization' }
Square >> initializeAt: anXPosition [

	origin := anXPosition.
	squareState := NormalState new.

]

{ #category : 'getter' }
Square >> landingCoordinate [

	^ origin
]

{ #category : 'action' }
Square >> reversePolarity [

	squareState := squareState reverse.
]
