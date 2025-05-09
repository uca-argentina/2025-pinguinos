Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DieTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
DieTest >> test10SidedDieCanOnlyRollValuesBetween1And10 [
	
	| a10SidedDie resultsOf50Rolls |
	
	resultsOf50Rolls := OrderedCollection new.
	a10SidedDie := Die withSides: 10.
	
	50 timesRepeat: [ resultsOf50Rolls add: a10SidedDie roll ].

	self assert:
		(resultsOf50Rolls allSatisfy: [ :result | result between: 1 and: 10 ])
]

{ #category : 'tests' }
DieTest >> test1SidedDieCanOnlyRoll1 [

	| a1SidedDie resultsOf50Rolls |
	
	resultsOf50Rolls := OrderedCollection new.
	a1SidedDie := Die withSides: 1.
	
	50 timesRepeat: [ resultsOf50Rolls add: a1SidedDie roll ].

	self assert:
		(resultsOf50Rolls allSatisfy: [ :result | result = 1 ])
]

{ #category : 'tests' }
DieTest >> test6SidedDieCanOnlyRollValuesBetween1And6 [

	| a6SidedDie resultsOf50Rolls |
	
	resultsOf50Rolls := OrderedCollection new.
	a6SidedDie := Die new.
	
	50 timesRepeat: [ resultsOf50Rolls add: a6SidedDie roll ].

	self assert:
		(resultsOf50Rolls allSatisfy: [ :result | result between: 1 and: 6 ])
]

{ #category : 'tests' }
DieTest >> testAfterRollingA6SidedDie1000TimesTheDistributionOfResultingNumbersIsUniform [

	| aDie resultsOf1000Rolls partialResult |
	aDie := Die new.
	resultsOf1000Rolls := Dictionary new.

	1000 timesRepeat: [
		partialResult := aDie roll.
		
		resultsOf1000Rolls 
			at: partialResult 
			ifAbsentPut: [ 0 ].
		
		resultsOf1000Rolls
			at: partialResult
			put: (resultsOf1000Rolls at: partialResult) + 1 ].

	resultsOf1000Rolls keysAndValuesDo: [ :number :count |
		self assert: count > 100 ].
]

{ #category : 'tests' }
DieTest >> testTryingToCreateADieWith0SidesResultsInError [

	self
		should: [ Die withSides: 0 ]
		raise: Error
		withMessageText: 'Number of sides should be a positive integer!'
]

{ #category : 'tests' }
DieTest >> testTryingToCreateADieWithANonIntegerNumberOfSidesResultsInError [

	self
		should: [ Die withSides: 2.5 ]
		raise: Error
		withMessageText: 'Number of sides should be a positive integer!'
]

{ #category : 'tests' }
DieTest >> testTryingToCreateADieWithANonPositiveNumberOfSidesResultsInError [

	self
		should: [ Die withSides: -2 ]
		raise: Error
		withMessageText: 'Number of sides should be a positive integer!'
]
