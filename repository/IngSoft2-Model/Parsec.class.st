"
Parsec length units
"
Class {
	#name : 'Parsec',
	#superclass : 'Dimension',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'converting' }
Parsec >> convertToCellUnits [ 

	^ CellUnit of:
		  value * (Dimension conversionRateFrom: 'Parsec' to: 'CellUnit')
]

{ #category : 'converting' }
Parsec >> convertToLightYears [ 

	^ LightYear of:
		  value * (Dimension conversionRateFrom: 'Parsec' to: 'LightYear')
]
