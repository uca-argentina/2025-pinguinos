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
ShipTest >> testWhenAShipIsCreatedThenIsPositionedIn1 [

	| aShip aBoard  |
	
	aBoard := Board withSize: 5.

	aShip := Ship new.

	self assert: aShip position equals: 1
]

{ #category : 'running' }
ShipTest >> testWhenAShipIsCreatedWithANameThenItIsValid [

	| aShip |

	aShip := Ship name: 'Valen Nave'.

	self assert: aShip name equals: 'Valen Nave'
]

{ #category : 'running' }
ShipTest >> testWhenAShipIsCreatedWithoutANameThenItIsPlayer1 [

	| aShip aBoard  |
	
	aBoard := Board withSize: 5.

	aShip := Ship new.
	
	aShip setPlayerNumber: 1.

	self assert: aShip name equals: 'player 1'
]
