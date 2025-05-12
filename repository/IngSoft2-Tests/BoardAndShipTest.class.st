Class {
	#name : 'BoardAndShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
BoardAndShipTest >> testIfIMoveShip2AndThen3PositionsOnTheBoardItsPositionChangesAccordingly [
	
	| aBoard aShip |
	
	aBoard:= Board withSize: 8.
	aShip := Ship new.
	
	aShip moveBy: 2 on: aBoard.
	aShip moveBy: 3 on: aBoard.

	self assert: aShip position equals: 5.
]

{ #category : 'running' }
BoardAndShipTest >> testIfIMoveShip2PositionsOnTheBoardItsPositionChangesAccordingly [
	
	| aBoard aShip numberToMove |
	
	aBoard:= Board withSize: 8.
	aShip := Ship new.
	numberToMove := 2.
	
	aShip moveBy: numberToMove on: aBoard.

	self assert: aShip position equals: numberToMove.
]

{ #category : 'running' }
BoardAndShipTest >> testIfIMoveShipByMorePositionsThanTheSizeOfTheBoardShipStaysInLastSquare [
	
	| aBoard aShip |
	
	aBoard:= Board withSize: 8.
	aShip := Ship new.
	
	aShip moveBy: 10 on: aBoard.

	self assert: aShip position equals: 8.
]
