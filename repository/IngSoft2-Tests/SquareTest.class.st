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
SquareTest >> testWhenXIsNegativeThenCreationFails [

	self
		should: [ Square x: -8 ]
		raise:  Error
		withErrorMessage: 'X position must be positive.'
]

{ #category : 'running' }
SquareTest >> testWhenXIsNotAnIntegerThenCreationFails [

	self
		should: [ Square x: 0.4 ]
		raise:  Error
		withErrorMessage: 'X position must be an integer.'
]
