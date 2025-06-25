"
Implementation of mercenary card, from the permanent type of cards.
"
Class {
	#name : 'MercenaryCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
MercenaryCard >> isContractedShipAlreadyContracted: aContractedShip in: aCardManager [

	(aCardManager getContractedShips includes: aContractedShip) ifTrue: [
		Error signal: 'A ship cannot contract as mercenary a ship that has already been contracted by someone else!' ]
]

{ #category : 'testing' }
MercenaryCard >> isContractor: aContractorShip theContractee: aContractedShip [

	aContractorShip = aContractedShip ifTrue: [ Error signal: 'A ship cannot contract itself as a mercenary!' ]
]

{ #category : 'testing' }
MercenaryCard >> isTurnRestricted [

	^ true
]

{ #category : 'action handling' }
MercenaryCard >> managedBy: aCardManager from: aContractorShip target: aContractedShip [

	self isContractor: aContractorShip theContractee: aContractedShip.
	self isContractedShipAlreadyContracted: aContractedShip in: aCardManager.
	
	aCardManager addEffect:
		(MercenaryContract from: aContractorShip  with: aContractedShip usedBy: self)
]
