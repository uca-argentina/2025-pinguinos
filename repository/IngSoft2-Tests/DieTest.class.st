Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DieTest >> testDie [
	| aDie |
	
	aDie := Die new.
	
	self assert: (aDie roll between: 1 and: 6)
]
