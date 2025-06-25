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
MercenaryCard >> isContractor: aContractorShip theContractee: aContractedShip [

	aContractorShip = aContractedShip ifTrue: [ Error signal: 'A ship cannot contract itself as a mercenary!' ]
]

{ #category : 'action handling' }
MercenaryCard >> managedBy: aCardManager from: aContractorShip target: aContractedShip [

	self isContractor: aContractorShip theContractee: aContractedShip.
	aCardManager addEffect:
		(MercenaryContract from: aContractorShip  with: aContractedShip usedBy: self)
]
