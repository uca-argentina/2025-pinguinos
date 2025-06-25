"
A dimension class that represents units of length
"
Class {
	#name : 'Dimension',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#classInstVars : [
		'conversionRates'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Dimension class >> conversionRateFrom: aUnit to: anotherUnit [

	 ^ (conversionRates at: aUnit) at: anotherUnit 
	
]

{ #category : 'instance creation' }
Dimension class >> conversionRates [

	 ^ conversionRates 
	
]

{ #category : 'instance creation' }
Dimension class >> of: value [

	^ self new initializeWith: value
]

{ #category : 'instance creation' }
Dimension class >> setRates [

	conversionRates := Dictionary newFrom: {
			                   ('CellUnit' -> (Dictionary newFrom: {
					                     ('LightYear' -> 60).
					                     ('Parsec' -> 20) })).
			                   ('LightYear' -> (Dictionary newFrom: {
					                     ('CellUnit' -> 4).
					                     ('Parsec' -> (1 / 3)) })).
			                   ('Parsec' -> (Dictionary newFrom: {
					                     ('CellUnit' -> (1 / 20)).
					                     ('LightYear' -> 3) })) }
]

{ #category : 'arithmetic' }
Dimension >> + aNumber [

	^ (self class of: (self value + aNumber))
]

{ #category : 'arithmetic' }
Dimension >> / aNumber [

	^ (self class of: (self value / aNumber))
]

{ #category : 'converting' }
Dimension >> convertToCellUnits [

	^ CellUnit of: value
]

{ #category : 'converting' }
Dimension >> convertToLightYears [

	^ LightYear of: value
]

{ #category : 'converting' }
Dimension >> convertToParsecs [

	^ Parsec of: value
]

{ #category : 'arithmetic' }
Dimension >> floor [

	^ (self class of: (self value floor))
]

{ #category : 'initialization' }
Dimension >> initializeWith: aValue [

	value := aValue.
]

{ #category : 'evaluating' }
Dimension >> value [ 

	^ value
]
