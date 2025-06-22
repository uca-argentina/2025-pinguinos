Class {
	#name : 'RandomDistributionOfSpecialSquaresTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RandomDistributionOfSpecialSquaresTest >> testAfterCreatingABoardOfSize100WithSemiRandomlyDistributedSpecialSquaresWeSeeTheDistributionOfTypesIsAsExpected [

	| aBoard classCounts |
	classCounts := Dictionary new.

	"dict['nombre clase'] = { numero de ocurrencias . probabilidad de aparecer de cada clase de cuadrado }"
	classCounts at: 'EmptySquare' put: { 0. 38 }.
	"Cambiado a 38 para última entrega"
	classCounts at: 'Blackhole' put: { 0. 20 }.
	classCounts at: 'HyperSpaceJump' put: { 0. 20 }.
	classCounts at: 'MoonWalk' put: { 0. 10 }.
	classCounts at: 'HyperJump' put: { 0. 8 }.
	classCounts at: 'AtomicBomb' put: { 0. 2 }.
	classCounts at: 'CardGiver' put: { 0. 10 }.

	aBoard := CircularBoard
		          withRandomSpecialSquaresAndSize: 100
		          rounds: 2.

	1 to: 100 do: [ :i |
		| className |
		className := (aBoard getSquareAt: i) class asString.
		(classCounts at: className) at: 1 put: (classCounts at: className) first + 1 ].
	
	"Observo que cada cuadrado aparezca ± 10 veces del valor esperado"
	classCounts keysAndValuesDo: [ :className :value |
		self assert: (value first >= (value second - 10) and:
				 value first <= (value second + 10)) ]
]
