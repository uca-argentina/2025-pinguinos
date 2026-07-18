"
Implementation of speed card effect, which gives the ship an extra square position.
"
Class {
	#name : 'MercenaryContract',
	#superclass : 'PermanentEffect',
	#instVars : [
		'contractorShip',
		'contractedShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
MercenaryContract class >> from: aShip with: aContractedShip usedBy: aCard [

	^ self new initializeFrom: aShip with: aContractedShip usedBy: aCard
]

{ #category : 'getter' }
MercenaryContract >> getAllyOf: aShip against: anOpponent [

	isReversed
		ifFalse: [ aShip == contractorShip ifTrue: [ ^ contractedShip ] ]
		ifTrue: [ anOpponent == contractorShip ifTrue: [ ^ contractedShip ] ].
	
	^ nil
]

{ #category : 'getter' }
MercenaryContract >> getContractedMercenary [

	^ contractedShip 
]

{ #category : 'initialization' }
MercenaryContract >> initializeFrom: aShip with: aContractedShip usedBy: aCard [

	super initialize.

	contractorShip := aShip.
	contractedShip := aContractedShip.
	usedBy := aCard.
	^ self
]
