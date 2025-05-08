"
implementation of a die, that responds to the message: 'roll', and returns a random integer value between 1 and N.
"
Class {
	#name : 'Die',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'random' }
Die >> roll [
 ^ (1 to: 6) atRandom
]
