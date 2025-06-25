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
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
CardManager >> addEffect: aCardEffect [

	activeCardEffects add: aCardEffect
]

{ #category : 'adding' }
CardManager >> addMovement: aShip [

	^ (activeCardEffects collect: [ :cardEffect |
		   cardEffect addMovement: aShip ]) sumNumbers
]
