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

	| a10SidedDie |
	a10SidedDie := Die withSides: 10.

	self assert: (a10SidedDie roll between: 1 and: 10)
]

{ #category : 'tests' }
DieTest >> test6SidedDieCanOnlyRollValuesBetween1And6 [

	| aDie |
	aDie := Die new.

	self assert: (aDie roll between: 1 and: 6)
]

{ #category : 'tests' }
DieTest >> testTryingToCreateADieWithANonPositiveNumberOfSidesResultsInError [

	self
		should: [ Die withSides: -2 ]
		raise: Error
		withMessageText: 'Number of sides should be a positive integer!'
]
