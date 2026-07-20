"
Represents the normal state of a mercenary contract
"
Class {
	#name : 'NormalMercenaryContractState',
	#superclass : 'MercenaryContractState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
NormalMercenaryContractState >> getAllyOf: aShip against: anOpponent from: aContract [

	^ aContract applyNormalContractTo: aShip against: anOpponent
]

{ #category : 'highlighting' }
NormalMercenaryContractState >> reverse [ 

	^ ReversedMercenaryContractState new
]
