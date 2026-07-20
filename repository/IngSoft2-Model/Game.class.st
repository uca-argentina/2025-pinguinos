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
Game class >> inSize: aSize withWormHoleFrom: aSquare to: anotherSquare with: aDiceSet and: aSetOfShips [

	^ self new
		  initializeIn:
		  (Board withSize: aSize withWormHoleFrom: aSquare to: anotherSquare)
		  with: aDiceSet
		  and: aSetOfShips
]

{ #category : 'getter' }
Game >> boardSize [

	^ board size
]

{ #category : 'accessing' }
Game >> boardState [

	| currentGameState |
	
	currentGameState := Dictionary new.
	ships do: [ :ship |
		currentGameState at: ship name put: ship position ].

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

	(board isThisSquareTheGoal: currentShip position) ifTrue: [
		gameOver := true.
		gameWinner := currentShip name ].

	^ gameOver
]

{ #category : 'initialization' }
Game >> initializeIn: aBoard with: aDiceSet and: aSetOfShips [

	aBoard ifNil: [ 
		Error signal: 'Cannot build a game without a board!' ].
	aDiceSet ifNil: [
		Error signal: 'Cannot build a game without any dice!' ].

	board := aBoard.
	diceSet := DiceSet withDice: aDiceSet.
	ships := self orderShips: aSetOfShips.

	shipToMove := 1.
	gameOver := false.
	gameWinner := nil
]

{ #category : 'getter' }
Game >> isGameOver [

	^ gameOver 

	
]

{ #category : 'game controls' }
Game >> moveEveryShipExcept: anExceptionShip to: destination [

	ships do: [ :ship |
		ship ~= anExceptionShip ifTrue: [
			ship moveTo: (board getSquareAt: destination) ] ]
]

{ #category : 'game controls' }
Game >> moveShip: aShip to: destination [

	aShip moveTo: (board getSquareAt: destination)
]

{ #category : 'game controls' }
Game >> nextTurn [

	| currentShip |
	
	self canIKeepPlaying.
	
	currentShip := ships at: shipToMove.
	currentShip moveBy: diceSet roll on: board of: self.

	self haveWeGotAWinner: currentShip.

	shipToMove := shipToMove \\ ships size + 1.

]

{ #category : 'setter' }
Game >> orderShips: aSetOfShips [

	| shipCollection |
	
	shipCollection := OrderedCollection new.

	aSetOfShips ifEmpty: [
		Error signal: 'Cannot build a game without any ships!' ].

	(aSetOfShips allSatisfy: [ :object | object isKindOf: Ship ])
		ifFalse: [ Error signal: 'Set of ships must contain only ships!' ].

	shipCollection addAll: aSetOfShips.
	^ shipCollection
]

{ #category : 'printing' }
Game >> printRanking: sortedShips [

	| stream |
	
	stream := WriteStream on: String new.

	sortedShips doWithIndex: [ :ship :index |
		stream nextPutAll: ship name asString.
		stream nextPutAll: ' ranked: '.
		stream nextPutAll: index asString.
		stream nextPutAll: ' - round: '.
		stream nextPutAll: ship laps asString.
		stream nextPutAll: ' - position: '.
		stream nextPutAll: ship position asString.

		(index = 1 and: (self haveWeGotAWinner: ship)) ifTrue: [
			stream nextPutAll: ' -> We have a winner!' ].
		index < sortedShips size ifTrue: [ stream nextPut: Character lf ] ].

	^ stream contents
]

{ #category : 'getter' }
Game >> rankingReport [

	| sortedShips |
	
	sortedShips := ships sorted: [ :aShip :anotherShip |
		               aShip laps > anotherShip laps or: [
			               aShip laps = anotherShip laps and: [
				               aShip position > anotherShip position ] ] ].

	^ self printRanking: sortedShips
]
