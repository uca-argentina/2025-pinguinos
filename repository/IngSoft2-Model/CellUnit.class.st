"
Length dimension in units of board cells/squares
"
Class {
	#name : 'CellUnit',
	#superclass : 'Dimension',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'converting' }
CellUnit >> convertToLightYears [ 

	^ LightYear of:
		  value * (Dimension conversionRateFrom: 'CellUnit' to: 'LightYear')
]

{ #category : 'converting' }
CellUnit >> convertToParsecs [

	^ Parsec of:
		  value * (Dimension conversionRateFrom: 'CellUnit' to: 'Parsec')
]
