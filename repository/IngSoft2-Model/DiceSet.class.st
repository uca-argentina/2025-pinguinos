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

{ #category : 'instance creation' }
DiceSet class >> withDice: diceSet [
	
	^ (self new) initializeWith: diceSet.
]

{ #category : 'initialization' }
DiceSet >> initializeWith: diceSet [
	setOfDice := diceSet.
]

{ #category : 'random' }
DiceSet >> roll [
	| finalSum |
	
	finalSum := 0.
	
	setOfDice do: [ :die | finalSum := finalSum + (die roll) ].
	
	^ finalSum
]
