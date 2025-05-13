"
The class which will manage rest of features to configure a game setting.
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'diceSet',
		'ships',
		'shipToMove'
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
	
	shipToMove := 1.
]

{ #category : 'game controls' }
Game >> nextTurn [
	
	(ships at: shipToMove) moveBy: diceSet roll on: board.
	shipToMove := (shipToMove \\ ships size) + 1.
	 
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
