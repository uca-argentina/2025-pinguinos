"
Implementation of a set of dice, that is initialized with a set of individual dice of any size, and which then can calculate the total sum of the results of rolling said dice.
"
Class {
	#name : 'DiceSet',
	#superclass : 'Object',
	#instVars : [
		'setOfDice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
DiceSet class >> areAllDice: anArrayOfObjects [

	^ anArrayOfObjects allSatisfy: [ :object | object isKindOf: Die ]
]

{ #category : 'instance creation' }
DiceSet class >> withDice: aSetOfDice [

	(self areAllDice: aSetOfDice) ifFalse: [
		Error signal: 'Dice set must contain only dice!' ].

	aSetOfDice ifEmpty: [
		Error signal: 'Dice set must contain at least 1 die!' ].

	^ self new initializeWith: aSetOfDice
]

{ #category : 'initialization' }
DiceSet >> initializeWith: diceSet [

	setOfDice := diceSet
]

{ #category : 'random' }
DiceSet >> roll [

	^ setOfDice inject: 0 into: [ :sum :die | sum + (die roll) ]

]
