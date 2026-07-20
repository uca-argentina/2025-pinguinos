"
Represents the state of an entity.
"
Class {
	#name : 'State',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
State class >> isAbstract [

	^ self == State
]

{ #category : 'adding' }
State >> addMovementFrom: anAdditionalSquares to: aShip [
	
	self subclassResponsibility 
]

{ #category : 'action' }
State >> applyEffectFrom: aSquare to: aShip in: aGame [ 
	
	self subclassResponsibility 
]

{ #category : 'action' }
State >> getAllyOf: aShip against: anOpponent from: aContract [

	self subclassResponsibility 
]

{ #category : 'highlighting' }
State >> reverse [

	self subclassResponsibility 
]
