Class {
	#name : 'CircularBoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
CircularBoardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
CircularBoardTest >> testWhenCreatingCircularBoardWithNegativeRoundsThenItFails [
	
	self
		should: [ CircularBoard withSize: 10 rounds: -1 ]
		raise: Error 
		withErrorMessage: 'Round number for the board must be positive.'

]

{ #category : 'tests' }
CircularBoardTest >> testWhenCreatingCircularBoardWithNegativeSizeAnErrorIsRaised [
	
	self
		should: [ CircularBoard withSize: -2 rounds: 1 ]
		raise: Error 
		withErrorMessage: 'Size for the grid must be positive.'

]

{ #category : 'tests' }
CircularBoardTest >> testWhenCreatingCircularBoardWithSize0AnErrorIsRaised [
	
	self
		should: [ CircularBoard withSize: 0 rounds: 1 ]
		raise: Error 
		withErrorMessage: 'Size for the grid must be positive.'

]
