"
The class which will manage rest of features to configure a game setting.
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'die'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> in: aBoard with: aDie and: aShip [

	^self new initializeIn: aBoard with: aDie and: aShip
]

{ #category : 'initialization' }
Game >> initializeIn: aBoard with: aDie and: aShip [

	board:= aBoard.
	die:= aDie.
	
	board placeShip: aShip at: 0.
]

{ #category : 'accessing' }
Game >> start [
	self validateElements.
	
	^true
	
	
]

{ #category : 'validation' }
Game >> validateElements [
	board ifNil: [ ^false ].
	die ifNil: [ ^false ].
	^ true
]
