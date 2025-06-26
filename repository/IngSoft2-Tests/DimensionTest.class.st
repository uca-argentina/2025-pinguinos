Class {
	#name : 'DimensionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DimensionTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'tests' }
DimensionTest >> testCannotCreateNegativeDimensionUnit [

	self should: [ CellUnit of: -1 ] raise: Error withErrorMessage: 'Cannot create a unit of negative value!'
]

{ #category : 'tests' }
DimensionTest >> testConvertingCellUnitsToCellUnitsWorksCorrectly [

	| units |
	
	units := CellUnit of: 2.

	self assert: units convertToCellUnits equals: (CellUnit of: 2)
]

{ #category : 'tests' }
DimensionTest >> testConvertingCellUnitsToLightYearsWorksCorrectly [

	| units |

	units := CellUnit of: 2.

	self assert: units convertToLightYears equals: (LightYear of: 120)
]

{ #category : 'tests' }
DimensionTest >> testConvertingCellUnitsToParsecsWorksCorrectly [

	| units |

	units := CellUnit of: 2.

	self assert: units convertToParsecs equals: (Parsec of: 40)
]

{ #category : 'tests' }
DimensionTest >> testConvertingLightYearsToCellUnitsWorksCorrectly [

	| units |
	
	"20 parsecs por unidad por default"
	units := LightYear of: 10.

	self assert: units convertToCellUnits equals: (CellUnit of: 1 / 6)
]

{ #category : 'tests' }
DimensionTest >> testConvertingLightYearsToLightYearsWorksCorrectly [

	| units |
	
	units := LightYear of: 10.

	self assert: units convertToLightYears equals: (LightYear of: 10)
]

{ #category : 'tests' }
DimensionTest >> testConvertingLightYearsToParsecsWorksCorrectly [

	| units |
	
	units := LightYear of: 10.

	self assert: units convertToParsecs equals: (Parsec of: 10 / 3)
]

{ #category : 'tests' }
DimensionTest >> testConvertingParsecsToCellUnitsWorksCorrectly [

	| units |
	
	units := Parsec of: 60. 

	self assert: units convertToCellUnits equals: (CellUnit of: 3)
]

{ #category : 'tests' }
DimensionTest >> testConvertingParsecsToLightYearsWorksCorrectly [

	| units |
	
	units := Parsec of: 60. 

	self assert: units convertToLightYears equals: (LightYear of: 180)
]

{ #category : 'tests' }
DimensionTest >> testConvertingParsecsToParsecsWorksCorrectly [

	| units |
	
	units := Parsec of: 60. 

	self assert: units convertToParsecs equals: (Parsec of: 60)
]
