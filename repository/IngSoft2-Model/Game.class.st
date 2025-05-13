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
		'shipToMove',
		'gameOver',
		'gameWinner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> in: aBoard with: dice and: ships [

	^self new initializeIn: aBoard with: dice and: ships
]

{ #category : 'accessing - structure variables' }
Game >> boardState [
	
	| currentGameState |
	currentGameState := Dictionary new.
	ships do: [ :ship | currentGameState at: (ship name) put: (ship position) ].
	
	^ currentGameState 
]

{ #category : 'testing' }
Game >> canIKeepPlaying [

	gameOver ifTrue: [ Error signal: gameWinner , ' has won, game over!' ]
]

{ #category : 'initialization' }
Game >> initializeIn: aBoard with: aDiceSet and: aSetOfShips [

	board:= aBoard.
	diceSet := aDiceSet.
	ships := aSetOfShips.
	
	shipToMove := 1.
	gameOver := false.
	gameWinner := nil.
]

{ #category : 'testing' }
Game >> isGameOver [

	^ gameOver 

	
]

{ #category : 'game controls' }
Game >> nextTurn [

	| currentShip winner |
	self canIKeepPlaying.
	
	winner := nil.
	currentShip := ships at: shipToMove.
	currentShip moveBy: diceSet roll on: board.

	(board isThisSquareTheGoal: (currentShip position)) ifTrue: [
		gameOver := true.
		gameWinner := currentShip name.
		winner := gameWinner , ' has won the game!'.
		].

	shipToMove := shipToMove \\ ships size + 1.
	^ winner
]

{ #category : 'accessing' }
Game >> start [
	self validateElements.
	
	^true
	
	
]

{ #category : 'validation' }
Game >> validateElements [
	board ifNil: [ ^false ].
	diceSet ifNil: [ ^false ].
	^ true
]
