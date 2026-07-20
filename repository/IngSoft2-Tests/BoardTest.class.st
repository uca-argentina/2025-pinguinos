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
BoardTest >> testCreatingBoardWithWormHoleEndBeingANonIntegerResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: -1 to: 5]
		raise: Error 
		withErrorMessage: 'WormHole must have both its ends leading to valid positions inside the limits of the board!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleEndingInLastSquareResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: 2 to: 8]
		raise: Error 
		withErrorMessage: 'Wormhole cannot lead out of/into last square!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleInsideItsLimitsIsSuccesful [
		
	| aBoard entrance exit wormHoleOrigin wormHoleEnd |
	
	entrance := 1.
	exit := 7.
	aBoard := Board withSize: 8 withWormHoleFrom: entrance to: exit.
	
	wormHoleOrigin := aBoard getSquareAt: entrance.
	wormHoleEnd := aBoard getSquareAt: exit.
	
	self assert: (wormHoleOrigin getDestination) equals: (exit).
	self assert: (wormHoleEnd getDestination) equals: (entrance).
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleLeadingOutsideItsLimitsResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: 2 to: 10]
		raise: Error 
		withErrorMessage: 'WormHole must have both its ends leading to valid positions inside the limits of the board!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleStartingAndEndingInTheSamePlaceResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: 2 to: 2]
		raise: Error 
		withErrorMessage: 'Wormhole cannot lead to itself!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleStartingAndEndingOutsideItsLimitsResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: -1 to: 14]
		raise: Error 
		withErrorMessage: 'WormHole must have both its ends leading to valid positions inside the limits of the board!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleStartingInLastSquareResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: 8 to: 2]
		raise: Error 
		withErrorMessage: 'Wormhole cannot lead out of/into last square!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleStartingOutsideItsLimitsResultsInError [
	
	self
		should: [Board withSize: 8 withWormHoleFrom: -1 to: 5]
		raise: Error 
		withErrorMessage: 'WormHole must have both its ends leading to valid positions inside the limits of the board!'
]

{ #category : 'tests' }
BoardTest >> testCreatingBoardWithWormHoleWithinLimitsWithEntranceBeingAfterExitIsSuccesful [
		
	| aBoard entrance exit wormHoleOrigin wormHoleEnd |
	
	entrance := 5.
	exit := 2.
	aBoard := Board withSize: 8 withWormHoleFrom: entrance to: exit.
	
	wormHoleOrigin := aBoard getSquareAt: entrance.
	wormHoleEnd := aBoard getSquareAt: exit.
	
	self assert: (wormHoleOrigin getDestination) equals: (exit).
	self assert: (wormHoleEnd getDestination) equals: (entrance).
]

{ #category : 'running' }
BoardTest >> testWhenBoardIsCreatedWithSize8ThenSizeIs8 [
	
	| aBoard |
	
	aBoard:= Board withSize: 8.
	
	self assert: (aBoard size) equals: 8.
]

{ #category : 'running' }
BoardTest >> testWhenXIsNegativeThenCreationFails [

	self
		should: [ Board withSize: -8 ]
		raise:  Error
		withErrorMessage: 'Size for the grid must be positive.'
]
