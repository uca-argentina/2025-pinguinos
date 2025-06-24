"
Implementation of a deck of cards.
"
Class {
	#name : 'Deck',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
Deck >> drawCard [

	| cardType |
	cardType := {Card new}.
	^ cardType atRandom
]
