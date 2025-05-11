Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedThenIsPositionedIn0 [

	| aShip |

	aShip := Ship new.

	self assert: aShip position equals: 0
]

{ #category : 'running' }
ShipTest >> testWhenAShipRollsADieThenIsRepositioned [

	| aShip a3SidedDie aRolledNumber |

	aShip := Ship new.
	
	a3SidedDie := Die withSides: 4.

	aRolledNumber := a3SidedDie roll.
	
	aShip move: aRolledNumber.

	self assert: aShip position equals: aRolledNumber.
]
