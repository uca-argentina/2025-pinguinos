"
Implementation of CardGiver special square.
"
Class {
	#name : 'CardGiver',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CardGiver class >> at: aPosition [

	^self new initializeAt: aPosition
]

{ #category : 'action' }
CardGiver >> applyNormalEffectTo: aShip in: aGame [

	aGame drawCardFor: aShip
]

{ #category : 'action' }
CardGiver >> applyReverseEffectTo: aShip in: aGame [

	aGame drawCardsForEveryoneExceptFor: aShip
]
