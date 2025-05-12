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

	self assert: aShip position equals: 6.
]

{ #category : 'running' }
BoardAndShipTest >> testIfIMoveShip2PositionsOnTheBoardItsPositionChangesAccordingly [
	
	| aBoard aShip numberToMove |
	
	aBoard:= Board withSize: 8.
	aShip := Ship new.
	numberToMove := 2.
	
	aShip moveBy: numberToMove on: aBoard.

	self assert: aShip position equals: numberToMove + 1.
]

{ #category : 'running' }
BoardAndShipTest >> testIfIMoveShipByMorePositionsThanTheSizeOfTheBoardShipStaysInLastSquare [
	
	| aBoard aShip |
	
	aBoard:= Board withSize: 8.
	aShip := Ship new.
	
	aShip moveBy: 10 on: aBoard.
	aShip position.

	self assert: aShip position equals: 8.
]

{ #category : 'running' }
BoardAndShipTest >> testIfIMoveShipIntoEntranceOfWormHoleThenItEndsUpOnOtherSide [
	
	| aBoard aShip numberToMove |
	
	aBoard:= Board withSize: 8 withWormHoleFrom: 2 to: 5.
	aShip := Ship new.
	numberToMove := 1. 
	
	aShip moveBy: numberToMove on: aBoard. "Moving 1 position from 1 to the wormhole at 2"
	
	self assert: aShip position equals: 5.
]

{ #category : 'running' }
BoardAndShipTest >> testIfIMoveShipIntoExitOfWormHoleThenItEndsUpOnOtherSide [
	
	| aBoard aShip numberToMove |
	
	aBoard:= Board withSize: 8 withWormHoleFrom: 2 to: 5.
	aShip := Ship new.
	numberToMove := 4. 
	
	aShip moveBy: numberToMove on: aBoard. "Moving 4 positions from 1 to the wormhole at 5"
	
	self assert: aShip position equals: 2.
]
