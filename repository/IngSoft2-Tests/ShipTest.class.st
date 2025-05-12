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

	| aShip numberToMove |

	aShip := Ship new.
	numberToMove := 2.
	
	aShip move: numberToMove.

	self assert: aShip position equals: numberToMove.
]
