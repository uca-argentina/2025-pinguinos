"
Implementation of mercenary card, from the permanent type of cards.
"
Class {
	#name : 'MercenaryCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action handling' }
MercenaryCard >> managedBy: aCardManager from: aContractorShip target: aContractedShip [

	aCardManager addEffect:
		(MercenaryContract from: aContractorShip  with: aContractedShip usedBy: self)
]
