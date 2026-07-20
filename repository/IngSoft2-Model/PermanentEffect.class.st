"
Implementation of various permanent card effects, which will be stored for using in a turn.
"
Class {
	#name : 'PermanentEffect',
	#superclass : 'Object',
	#instVars : [
		'usedBy',
		'permanentEffectState'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'one more square' }
PermanentEffect >> addMovement: aShip [

	^ 0
]

{ #category : 'getter' }
PermanentEffect >> getAllyOf: aShip against: anOpponent [
	
	^ nil
]

{ #category : 'getter' }
PermanentEffect >> getCardThatAppliedEffect [

	^ usedBy 
]

{ #category : 'getter' }
PermanentEffect >> getContractedMercenary [
	
	^ nil
]

{ #category : 'initialization' }
PermanentEffect >> initialize [

	super initialize.
	permanentEffectState := NormalState new
]

{ #category : 'action' }
PermanentEffect >> reverseEffect [
	
	permanentEffectState := permanentEffectState reverse.
]
