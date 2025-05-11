Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ShipTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedThenIsPositionedIn0 [

	| aShip aBoard aDie aGame |
	
	aBoard := Board withGridSize: 5.
	aDie := Die withSides: 4.
	aShip := Ship new.
	aGame := Game in: aBoard with: aDie and: aShip.

	self assert: (aBoard positionOf: aShip) equals: 0
]

{ #category : 'running' }
ShipTest >> testWhenAShipIsNotOnTheBoardThenIsInvalid [


	self
		should: [ (Board withGridSize:8) moveShip: Ship new by: 5. ] 
		raise: Error
		withErrorMessage: 'Ship is not on the board'
]

{ #category : 'running' }
ShipTest >> testWhenAShipRollsADieThenIsRepositioned [

	| aShip aBoard aDie aGame |
	
	aBoard := Board withGridSize: 5.
	aDie := Die withSides: 4.
	aShip := Ship new.
	aGame := Game in: aBoard with: aDie and: aShip.

	aBoard moveShip: aShip by: aDie roll.

	self deny: (aBoard positionOf: aShip) equals: 0
]
