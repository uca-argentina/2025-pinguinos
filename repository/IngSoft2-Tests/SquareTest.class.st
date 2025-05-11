Class {
	#name : 'SquareTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
SquareTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'running' }
SquareTest >> testWhenSquareIsCreatedThenItIsFree [

	| aSquare |
	
	aSquare:= Square x: 8.
	
	self assert: (aSquare checkStatus) equals: 'Free'
]

{ #category : 'asserting' }
SquareTest >> testWhenSquareIsOccupiedThenItIsNotFree [

	| aSquare |
	
	aSquare:= Square x: 8.
	
	aSquare isOccupied.
	
	self deny: (aSquare checkStatus) equals: 'Free'
]

{ #category : 'running' }
SquareTest >> testWhenXIsNegativeThenCreationFails [

	self
		should: [ Square x: -8 ]
		raise:  Error
		withErrorMessage: 'X position must be positive.'
]
