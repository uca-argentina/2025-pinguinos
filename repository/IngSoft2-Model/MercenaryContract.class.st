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

{ #category : 'action' }
MercenaryContract >> applyNormalContractTo: aShip against: anOpponent [

	aShip == contractorShip ifTrue: [ ^ contractedShip ].
	^ nil
]

{ #category : 'action' }
MercenaryContract >> applyReverseContractTo: aShip against: anOpponent [

	anOpponent == contractorShip ifTrue: [ ^ contractedShip ].
	^ nil
]

{ #category : 'getter' }
MercenaryContract >> getAllyOf: aShip against: anOpponent [

	^ permanentEffectState getAllyOf: aShip against: anOpponent from: self.
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
