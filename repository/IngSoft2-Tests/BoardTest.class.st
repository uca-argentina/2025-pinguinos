Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BoardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleLeadingOutsideItsLimitsResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: 2 to: 10]
		raise: Error 
		withErrorMessage: 'WormHole must have both its ends inside the limits of the board!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleStartingAndEndingOutsideItsLimitsResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: -1 to: 14]
		raise: Error 
		withErrorMessage: 'WormHole must have both its ends inside the limits of the board!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleStartingOutsideItsLimitsResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: -1 to: 5]
		raise: Error 
		withErrorMessage: 'WormHole must have both its ends inside the limits of the board!'
]

{ #category : 'running' }
BoardTest >> testWhenBoardIsCreatedWithSize8ThenSizeIs8 [
	
	| aBoard |
	
	aBoard:= Board withSize: 8.
	
	self assert: (aBoard size) equals: 8.
]

{ #category : 'tests' }
BoardTest >> testWhenBoardIsCreatedWithSquareListThenSquareIsOccupied [

	| aBoard |
	
	aBoard:= Board withSize: 8.
	
	self deny: (aBoard squareStatus: 6) equals: 'Occupied'
]

{ #category : 'running' }
BoardTest >> testWhenXIsNegativeThenCreationFails [

	self
		should: [ Board withSize: -8 ]
		raise:  Error
		withErrorMessage: 'Size for the grid must be positive.'
]
