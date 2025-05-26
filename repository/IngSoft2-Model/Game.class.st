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

{ #category : 'instance creation' }
Game class >> inSize: aSize withWormHoleFrom: aSquare to: anotherSquare with: aDiceSet and: aNumberOfShips [
	^self new initializeInSize: aSize withWormholeFrom: aSquare to: anotherSquare with: aDiceSet and: aNumberOfShips
]

{ #category : 'instance creation' }
Game class >> inSize: aSize withWormhole: aWormhole with: aDiceSet and: aNumberOfShips [
	^self new initializeInSize: aSize withWormhole: aWormhole with: aDiceSet and: aNumberOfShips
]

{ #category : 'getter' }
Game >> boardState [
	
	| currentGameState |
	currentGameState := Dictionary new.
	ships do: [ :ship | currentGameState at: (ship name) put: (ship position) ].
	
	^ currentGameState 
]

{ #category : 'validation' }
Game >> canIKeepPlaying [

	gameOver ifTrue: [ Error signal: gameWinner , ' has won, game over!' ].
]

{ #category : 'getter' }
Game >> getWinner [
	^ gameWinner 
]

{ #category : 'validation' }
Game >> haveWeGotAWinner: currentShip [

	(board isThisSquareTheGoal: (currentShip position)) ifFalse: [ ^false ].
	
	gameOver := true.
	gameWinner := currentShip name.
	^ true.
	
]

{ #category : 'initialization' }
Game >> initializeIn: aBoard with: aDiceSet and: aSetOfShips [

	board ifNil: [ Error signal: 'Cannot build a game without a board!' ].
	ships ifEmpty: [ Error signal: 'Cannot build a game without any ships!' ].
	diceSet ifNil: [ Error signal: 'Cannot build a game without any dice!' ].

	board:= aBoard.
	diceSet := DiceSet withDice: aDiceSet.
	ships := aSetOfShips.
	
	shipToMove := 1.
	gameOver := false.
	gameWinner := nil.
]

{ #category : 'initialization' }
Game >> initializeInSize: aSize withWormholeFrom: aSquare to: anotherSquare with: aDiceSet and: aNumberOfShips [

	board:= Board withSize: aSize withWormHoleFrom: aSquare to: anotherSquare.
	
	diceSet := DiceSet withDice: aDiceSet.
	
	ships := OrderedCollection new.
	1 to: aNumberOfShips do: [:shipNumber | 
    ships add: ((Ship new) setPlayerNumber: shipNumber)
	].

	board ifNil: [ Error signal: 'Cannot build a game without a board!' ].
	ships ifEmpty: [ Error signal: 'Cannot build a game without any ships!' ].
	diceSet ifNil: [ Error signal: 'Cannot build a game without any dice!' ].
	
	shipToMove := 1.
	gameOver := false.
	gameWinner := nil.
]

{ #category : 'getter' }
Game >> isGameOver [

	^ gameOver 

	
]

{ #category : 'game controls' }
Game >> nextTurn [

	| currentShip |
	self canIKeepPlaying.
	
	currentShip := ships at: shipToMove.
	currentShip moveBy: diceSet roll on: board.

	(self haveWeGotAWinner: currentShip) ifTrue: [ ^ gameWinner , ' has won the game!' ].

	shipToMove := shipToMove \\ ships size + 1.

]
