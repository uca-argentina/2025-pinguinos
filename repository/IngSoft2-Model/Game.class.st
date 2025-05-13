"
The class which will manage rest of features to configure a game setting.
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'diceSet',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> in: aBoard with: dice and: ships [

	^self new initializeIn: aBoard with: dice and: ships
]

{ #category : 'initialization' }
Game >> initializeIn: aBoard with: aDiceSet and: aSetOfShips [

	board:= aBoard.
	diceSet := aDiceSet.
	ships := aSetOfShips.
]

{ #category : 'game controls' }
Game >> nextTurn [
	
	(ships at: 1) moveBy: diceSet roll on: board.
	 
]

{ #category : 'accessing' }
Game >> start [
	self validateElements.
	
	^true
	
	
]

{ #category : 'accessing - structure variables' }
Game >> state [
	
	| currentGameState |
	currentGameState := Dictionary new.
	ships do: [ :ship | currentGameState at: (ship name) put: (ship position) ].
	
	^ currentGameState 
]

{ #category : 'validation' }
Game >> validateElements [
	board ifNil: [ ^false ].
	diceSet ifNil: [ ^false ].
	^ true
]
