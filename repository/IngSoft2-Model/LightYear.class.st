"
lightyear units

"
Class {
	#name : 'LightYear',
	#superclass : 'Dimension',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'converting' }
LightYear >> convertToCellUnits [

	^ CellUnit of:
		  value * ((Dimension conversionRates at: 'Parsec') at: 'CellUnit')
]

{ #category : 'converting' }
LightYear >> convertToParsecs [

	^ Parsec of:
		  value * ((Dimension conversionRates at: 'Parsec') at: 'LightYears')
]
