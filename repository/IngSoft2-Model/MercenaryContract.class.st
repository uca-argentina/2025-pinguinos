"
Implementation of speed card effect, which gives the ship an extra square position.
"
Class {
	#name : 'MercenaryContract',
	#superclass : 'PermanentEffects',
	#instVars : [
		'usedBy',
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
MercenaryContract >> getAllyOf: aShip [
	
	contractorShip = aShip 
		  ifTrue: [ ^ contractedShip ].
	
	^ nil

]

{ #category : 'getter' }
MercenaryContract >> getContractedMercenary [

	^ contractedShip 
]

{ #category : 'initialization' }
MercenaryContract >> initializeFrom: aShip with: aContractedShip usedBy: aCard [
	
	contractorShip := aShip.
	contractedShip := aContractedShip.
	usedBy := aCard.
	^ self
]
