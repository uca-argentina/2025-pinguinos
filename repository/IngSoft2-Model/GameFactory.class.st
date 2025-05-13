"
A builder class that builds games.
"
Class {
	#name : 'GameFactory',
	#superclass : 'Object',
	#instVars : [
		'board',
		'ships',
		'diceSet'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'building' }
GameFactory >> build [
	
	board ifNil: [ Error signal: 'Cannot build a game without a board!' ].
	ships ifEmpty: [ Error signal: 'Cannot build a game without any ships!' ].
	diceSet ifNil: [ Error signal: 'Cannot build a game without any dice!' ].
]

{ #category : 'initialization' }
GameFactory >> initialize [
	
	ships := OrderedCollection new.
]

{ #category : 'accessing' }
GameFactory >> ships: aNumberOfShips [ 
	
	1 to: aNumberOfShips do: [:ship | ships add: (Ship new)].
]

{ #category : 'instance creation' }
GameFactory >> withBoardSize: aSize withWormHoleFrom: aSquare to: anotherSquare [ 
	
	board := Board withSize: aSize withWormHoleFrom: aSquare to: anotherSquare.
]

{ #category : 'instance creation' }
GameFactory >> withDice: aSetOfDice [ 
	^ true
]
