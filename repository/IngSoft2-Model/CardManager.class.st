"
Implementation of a card manager that applies effects and checks values.
"
Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'activeCardEffects',
		'deck',
		'ships',
		'board',
		'discardPile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardManager class >> ships: aSetOfShips board: aBoard deck: aDeck [

	^ self new initializeWithShips: aSetOfShips withBoard: aBoard withDeck: aDeck
]

{ #category : 'adding' }
CardManager >> addEffect: aCardEffect [

	activeCardEffects add: aCardEffect
]

{ #category : 'adding' }
CardManager >> addMovement: aShip [

	| extraMovement |
	
	extraMovement := 0.
	^ extraMovement + (activeCardEffects collect: [ :cardEffect |
		   cardEffect addMovement: aShip ]) sumNumbers
]

{ #category : 'getter' }
CardManager >> getAlliesOf: aShip [

	| alliedShips |
	
	alliedShips := activeCardEffects collect: [ :cardEffect |
		               cardEffect getAllyOf: aShip ].
	alliedShips := alliedShips select: [ :alliedShip | alliedShip isNotNil ].

	^ alliedShips
]

{ #category : 'getter' }
CardManager >> getContractedShips [

	| contractedShips |
	
	contractedShips := activeCardEffects collect: [ :cardEffect |
		               cardEffect getContractedMercenary ].
	contractedShips := contractedShips select: [ :alliedShip | alliedShip isNotNil ].

	^ contractedShips
]

{ #category : 'getter' }
CardManager >> getLastUsedCards [
	
	^ discardPile 
	
]

{ #category : 'initialization' }
CardManager >> initializeWithShips: aSetOfShips withBoard: aBoard withDeck: aDeck [

	activeCardEffects := OrderedCollection new.
	deck := aDeck.
	ships := aSetOfShips.
	board := aBoard.
	discardPile := OrderedCollection new.
	^ self
]

{ #category : 'card usage' }
CardManager >> playCard: aCard by: aShip target: aTarget [

	aShip hasAny: aCard.
	aCard managedBy: self from: aShip target: aTarget.

	aShip removeCard: aCard.
	discardPile add: aCard.
]

{ #category : 'adding' }
CardManager >> removeEffectOf: aCard [

	| filteredEffectList |
	
	filteredEffectList := activeCardEffects reject: [ :activeCardEffect |
		                      activeCardEffect getCardThatAppliedEffect
		                      = aCard ].
	
	filteredEffectList size = activeCardEffects size ifTrue: [
		Error signal:
			'The selected card is not active at the moment, so it cannot be removed!' ].
	activeCardEffects := filteredEffectList
]
