Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
WormholeTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
WormholeTest >> testWhenPositionWithNegativeYThenCreationFails [

	self
		should: [ Wormhole y: -4 z: 5 ]
		raise:  Error
		withErrorMessage: 'Y position must be positive.'
]

{ #category : 'tests' }
WormholeTest >> testWhenPositionWithNegativeZThenCreationFails [

	self
		should: [ Wormhole y: 4 z: -5 ]
		raise:  Error
		withErrorMessage: 'Z position must be positive.'
]

{ #category : 'tests' }
WormholeTest >> testWhenWormholeIsCreatedThenItIsFree [

	| aSquare |
	
	aSquare:= Wormhole y: 3 z: 10.
	
	self assert: (aSquare checkStatus) equals: 'Free'
]
