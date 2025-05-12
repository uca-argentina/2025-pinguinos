"
Special squares in which a position might be shifted between two squares.
"
Class {
	#name : 'Wormhole',
	#superclass : 'Square',
	#instVars : [
		'y',
		'z'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Wormhole class >> validateYIsPositive: aYPosition [
	aYPosition < 0 ifTrue: [ Error signal: 'Y position must be positive.' ]
]

{ #category : 'validation' }
Wormhole class >> validateZIsPositive: aZPosition [
	aZPosition < 0 ifTrue: [ Error signal: 'Z position must be positive.' ]
]

{ #category : 'creation' }
Wormhole class >> y: aYPosition z: aZPosition [ 
		
	self validateYIsPositive: aYPosition.
	self validateZIsPositive: aZPosition.
		
	^self new initializeY: aYPosition z: aZPosition.
]

{ #category : 'initialization' }
Wormhole >> initializeY: aYPosition z: aZPosition [ 

	y:= aYPosition.
	z:= aZPosition.	
	self setStatus: 'Free'.

]

{ #category : 'accessing' }
Wormhole >> pointsTo [

	^ z
]

{ #category : 'accessing' }
Wormhole >> y [
	^y.
]

{ #category : 'accessing' }
Wormhole >> z [
	^z 
]
