Class {
	#name : 'DiceSetTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DiceSetTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : 'running' }
DiceSetTest >> testCreatingADiceSetWithA6SidedDieAndA10SidedDieAndThenRollingThemYieldsResultsInTheExpectedRange [

	| myDiceSet resultsOf50Rolls |
	
	resultsOf50Rolls := OrderedCollection new.
	
	myDiceSet := DiceSet withDice: {
			             (Die withSides: 6).
			             (Die withSides: 10) }.

	50 timesRepeat: [ resultsOf50Rolls add: myDiceSet roll ].

	self assert:
		(resultsOf50Rolls allSatisfy: [ :result | result between: 2 and: 16 ])
]

{ #category : 'running' }
DiceSetTest >> testCreatingADiceSetWithASingle6SidedDieAndThenRollingYieldsResultsInTheExpectedRange [

	| myDiceSet resultsOf50Rolls |
	
	resultsOf50Rolls := OrderedCollection new.
	
	myDiceSet := DiceSet withDice: { Die withSides: 6 }.

	50 timesRepeat: [ resultsOf50Rolls add: myDiceSet roll ].

	self assert:
		(resultsOf50Rolls allSatisfy: [ :result | result between: 1 and: 6 ])
]

{ #category : 'running' }
DiceSetTest >> testTryingToCreateADiceSetWithObjectsOtherThanDiceResultsInAnErrorBeingThrown [

	self
		should: [ DiceSet withDice: { 'Not a die' } ]
		raise: Error
		withMessageText: 'Dice set must contain only dice!'
]

{ #category : 'running' }
DiceSetTest >> testTryingToCreateAnEmptyDiceSetResultsInAnErrorBeingThrown [

	self
		should: [ DiceSet withDice: { } ]
		raise: Error
		withMessageText: 'Dice set must contain at least 1 die!'
]
