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
		'discardPile',
		'game'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardManager class >> ships: aSetOfShips board: aBoard deck: aDeck [

	^ self new
		  initializeWithShips: aSetOfShips
		  withBoard: aBoard
		  withDeck: aDeck
		  inGame: nil
]

{ #category : 'creation' }
CardManager class >> ships: aSetOfShips board: aBoard deck: aDeck game: aGame [

	^ self new
		  initializeWithShips: aSetOfShips
		  withBoard: aBoard
		  withDeck: aDeck
		  inGame: aGame
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

{ #category : 'card usage' }
CardManager >> applyLastSquareEffectTo: aShip [

	board applyLastSquareEffectTo: aShip in: game
]

{ #category : 'actions' }
CardManager >> drawCard [
	^ deck drawCard 
]

{ #category : 'getter' }
CardManager >> getAlliesOf: aShip against: anOpponent [

	| alliedShips |
	
	alliedShips := activeCardEffects collect: [ :cardEffect |
		               cardEffect getAllyOf: aShip against: anOpponent ].
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
CardManager >> getLastRepeatableUsedCard [

	| cardHistory |
	cardHistory := self getLastUsedCards.
	cardHistory := cardHistory select: [ :usedCard |
		               usedCard isRepeatable ].

	cardHistory ifEmpty: [
		Error signal: 'No cards have been played yet!' ].

	^ cardHistory last
]

{ #category : 'getter' }
CardManager >> getLastUsedCards [
	
	^ discardPile 
	
]

{ #category : 'initialization' }
CardManager >> initializeWithShips: aSetOfShips withBoard: aBoard withDeck: aDeck inGame: aGame [

	activeCardEffects := OrderedCollection new.
	deck := aDeck.
	ships := aSetOfShips.
	board := aBoard.
	game:= aGame.
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
		                      == aCard ].

	filteredEffectList size = activeCardEffects size ifTrue: [
		Error signal:
			'The selected card is not active at the moment, so it cannot be removed!' ].
	activeCardEffects := filteredEffectList
]

{ #category : 'adding' }
CardManager >> reverseEffectOf: aCard [

	| filteredEffectList |
	filteredEffectList := activeCardEffects select: [ :activeCardEffect |
		                      activeCardEffect getCardThatAppliedEffect
		                      == aCard ].

	filteredEffectList ifEmpty: [
		Error signal:
			'The selected card is not active at the moment, so it cannot be reversed!' ].
	filteredEffectList size ~= 1 ifTrue: [
		Error signal:
			'The selected card has more than 1 effect active at the moment!' ].

	filteredEffectList first reverseEffect
]

{ #category : 'validation' }
CardManager >> validateContractBetween: aContractorShip and: aContractedShip [
	
	aContractorShip = aContractedShip ifTrue: [ Error signal: 'A ship cannot contract itself as a mercenary!' ].
	
	(self getContractedShips includes: aContractedShip) ifTrue: [
		Error signal: 'A ship cannot contract as mercenary a ship that has already been contracted by someone else!' ].
]
