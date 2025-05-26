"
Implementation of a loaded die, that responds to the message: 'roll', and returns a pre defined number N.
"
Class {
	#name : 'LoadedDie',
	#superclass : 'Die',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'random' }
LoadedDie >> roll [

	^ sideNumber
]
