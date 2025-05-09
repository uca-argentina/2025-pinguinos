Class {
	#name : 'DiceSetTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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
