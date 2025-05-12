Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipIsCreatedThenIsPositionedIn1 [

	| aShip |

	aShip := Ship new.

	self assert: aShip position equals: 1
]

{ #category : 'running' }
ShipTest >> testWhenAShipRollsADieThenIsRepositioned [

	| aShip numberToMove |

	aShip := Ship new.
	numberToMove := 2.
	
	aShip move: numberToMove.

	self assert: aShip position equals: numberToMove + 1.
]
