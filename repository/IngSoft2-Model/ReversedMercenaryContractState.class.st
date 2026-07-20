"
Represents the reversed state of a mercenary contract
"
Class {
	#name : 'ReversedMercenaryContractState',
	#superclass : 'MercenaryContractState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
ReversedMercenaryContractState >> getAllyOf: aShip against: anOpponent from: aContract [

	^ aContract applyReverseContractTo: aShip against: anOpponent
]

{ #category : 'highlighting' }
ReversedMercenaryContractState >> reverse [ 

	^ NormalMercenaryContractState new
]
