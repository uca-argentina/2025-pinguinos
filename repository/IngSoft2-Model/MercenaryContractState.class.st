"
An abstract class that represents the state of a mercenary contract
"
Class {
	#name : 'MercenaryContractState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
MercenaryContractState class >> isAbstract [

	^ self == MercenaryContractState
]

{ #category : 'action' }
MercenaryContractState >> getAllyOf: aShip against: anOpponent from: aContract [

	^ self subclassResponsibility 

]

{ #category : 'highlighting' }
MercenaryContractState >> reverse [

	self subclassResponsibility 
]
