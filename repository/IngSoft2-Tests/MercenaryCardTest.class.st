Class {
	#name : 'MercenaryCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
MercenaryCardTest >> should: anErrorBlock raise: anErrorClass withErrorMessage: aMessage [

	self
		should: anErrorBlock 
		raise: anErrorClass
		withExceptionDo: [ :error |
			self assert: ( error messageText ) 
			equals: aMessage ]
]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> test2ShipsCanContractOneAnotherAsMercenaries [

	| aGame jorgeShip julianShip joseShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 2. 2. 2. 2. 1 }) } "Jorge mueve 3, Julian mueve 2, Jose mueve 2, En la pelea Jose sacaria 2, y Julian sacaria 3 2<3"
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.
	aGame playCard: aCard by: jorgeShip target: julianShip. "Jorge contrata a Julian como mercenario"
	aGame nextTurn. "Jorge avanza hasta 4"

	
	aDeck := aGame cardsOf: julianShip.
	aCard := aDeck first.
	
	self assert: (aGame playCard: aCard by: julianShip target: jorgeShip) equals: aGame
	
	

	
]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testMercenaryCardCannotBePlayedOutsideOfPlayersTurn [

	| aGame expectedResult jorgeShip julianShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.

	aGame nextTurn. "Jorge juega su turno"
	
	"Jorge intenta usar carta permanente en turno de otro y falla"
	self
		should: [ aGame playCard: aCard by: jorgeShip ]
		raise: Error
		withErrorMessage: 'This ship cannot play this card because it is not his turn!'.

	aGame nextTurn.

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).

	self assert: aGame boardStateWithCards equals: expectedResult
]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testShipCannotContractAShipThatHasAlreadyBeenContracted [

	| aGame jorgeShip julianShip joseShip pabloShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.
	pabloShip := Ship named: 'Pablo'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 2. 2. 5. 2. 1. 1 }) }
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip.
				         pabloShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw). "Jorge mueve 3, Julian mueve 2, Jose mueve 2, En la pelea Jose saca 5, Julian saca 2, Jorge saca 1, y Pablo 1 5>2+1+1"

	aDeck := aGame cardsOf: jorgeShip .
	aCard := aDeck first.
	aGame playCard: aCard by: jorgeShip target: julianShip. "Jorge contrata a Julian como mercenario"
	aGame nextTurn. "Jorge avanza hasta 4"


	aGame nextTurn. "Julian avanza hasta 3"
	
	
	aDeck := aGame cardsOf: joseShip.
	aCard := aDeck first.
	
	self
		should: [ aGame playCard: aCard by: joseShip target: julianShip ]
		raise: Error
		withErrorMessage:
		'A ship cannot contract as mercenary a ship that has already been contracted by someone else!'
]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testShipCannotContractItselfAsMercenary [

	| aGame jorgeShip julianShip joseShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: 3) }
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).

	aDeck := aGame cardsOf: jorgeShip.
	aCard := aDeck first.

	self
		should: [ aGame playCard: aCard by: jorgeShip target: jorgeShip ]
		raise: Error
		withErrorMessage:
		'A ship cannot contract itself as a mercenary!'
]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testWhenShipUsesMercenaryCardFightsAndLosesShieldsAreReducedFromHisAlliesTooAndOnlyContractorShipGetsMovedBack [

	| aGame jorgeShip julianShip joseShip aDeck aCard cardsToDraw expectedResult |
	
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 2. 3. 1. 1. 3 }) } "Jorge mueve 3, Julian mueve 2, Jose mueve 3, En la pelea Jose saca 1, Julian saca 1, Jorge saca 3, 1+1<3"
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw). 

	aGame nextTurn. "Jorge avanza hasta 4"
	aGame nextTurn. "Julian avanza hasta 3"

	aDeck := aGame cardsOf: joseShip.
	aCard := aDeck first.

	aGame playCard: aCard by: joseShip target: julianShip. "Jose contrata a Julian como mercenario"
	aGame nextTurn. "Jose avanza y junto con Julian, pelean con Jorge, ellos pierden"
	
	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jose').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 1)}).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 2)}).

	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 2.
	self assert: joseShip remainingShields equals: 2
]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testWhenShipUsesMercenaryCardOn2TargetShipsThenTheContractedShipsFightWithHimIfTheContractorIsAttacked [

	| aGame expectedResult jorgeShip julianShip joseShip pabloShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.
	pabloShip := Ship named: 'Pablo'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 2. 2. 5. 2. 1. 1 }) }
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip.
				         pabloShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw). "Jorge mueve 3, Julian mueve 2, Jose mueve 2, En la pelea Jose saca 5, Julian saca 2, Jorge saca 1, y Pablo 1 5>2+1+1"

	aGame nextTurn. "Jorge avanza hasta 4"

	aDeck := aGame cardsOf: julianShip.
	aCard := aDeck first.

	aGame playCard: aCard by: julianShip target: jorgeShip. "Julian contrata a Jorge como mercenario"
	
	aCard := aDeck second.
	aGame playCard: aCard by: julianShip target: pabloShip . "Julian contrata a Pablo como mercenario"
	aGame nextTurn. "Julian avanza hasta 3"

	aGame nextTurn. "Jose avanza y pelea con Julian, el quien es defendido por Jorge y Pablo, Jose gana"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jose').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Pablo').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2) }).
	expectedResult at: '4°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 0) }).

	self assert: aGame boardStateWithCards equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
	self assert: julianShip remainingShields equals: 2.
	self assert: joseShip remainingShields equals: 3.
	self assert: pabloShip remainingShields equals: 2
]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testWhenShipUsesMercenaryCardOnATargetShipThenTheContractedShipFightsWithHimIfTheContractorIsAttacked [

	| aGame expectedResult jorgeShip julianShip joseShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 2. 2. 2. 2. 1 }) } "Jorge mueve 3, Julian mueve 2, Jose mueve 2, En la pelea Jose saca 2, Julian saca 2, Jorge saca 1, 2<2+1"
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aGame nextTurn. "Jorge avanza hasta 4"
	
	aDeck := aGame cardsOf: julianShip.
	aCard := aDeck first.

	aGame playCard: aCard by: julianShip target: jorgeShip. "Julian contrata a Jorge como mercenario"
	aGame nextTurn. "Julian avanza hasta 3"
	
	aGame nextTurn. "Jose avanza y pelea con Julian, el quien es defendido por Jorge, ellos ganan"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 1)}).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Jose').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2)}).

	self assert: aGame boardStateWithCards equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 3.
	self assert: joseShip remainingShields equals: 2.

]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testWhenShipUsesMercenaryCardOnATargetShipThenTheContractedShipFightsWithHimIfTheContractorIsAttackedAndTheyCanDraw [

	| aGame expectedResult jorgeShip julianShip joseShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 2. 2. 2. 1. 1 }) } "Jorge mueve 3, Julian mueve 2, Jose mueve 2, En la pelea Jose saca 2, Julian saca 1, Jorge saca 1, 2=2+1"
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aGame nextTurn. "Jorge avanza hasta 4"
	
	aDeck := aGame cardsOf: julianShip.
	aCard := aDeck first.

	aGame playCard: aCard by: julianShip target: jorgeShip. "Julian contrata a Jorge como mercenario"
	aGame nextTurn. "Julian avanza hasta 3"
	
	aGame nextTurn. "Jose avanza y pelea con Julian, el quien es defendido por Jorge, ellos ganan"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jose').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 2)}).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 1)}).

	self assert: aGame boardStateWithCards equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 3.
	self assert: joseShip remainingShields equals: 3.

]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testWhenShipUsesMercenaryCardOnATargetShipThenTheContractedShipFightsWithHimLoserGetsMovedBackAndAlliesLoseShieldsToo [

	| aGame expectedResult jorgeShip julianShip joseShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 3. 1. 2. 2 }) } "Jorge mueve 3, Julian mueve 3, En la pelea Julian saca 1, Jose saca 2, Jorge saca 2, 1+2>2"
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aGame nextTurn. "Jorge avanza hasta 4"
	
	aDeck := aGame cardsOf: julianShip.
	aCard := aDeck first.

	aGame playCard: aCard by: julianShip target: joseShip. "Julian contrata a Jose como mercenario"
	aGame nextTurn. "Julian avanza y junto con Jose, pelea con Jorge, ellos ganan"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 1)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jose').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2)}).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 1).
				 ('lap' -> 1).
				 ('card count' -> 2)}).

	self assert: aGame boardStateWithCards equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 2.
	self assert: julianShip remainingShields equals: 3.
	self assert: joseShip remainingShields equals: 3.

]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testWhenShipUsesMercenaryCardOnATargetShipThenTheyDontFightIfTheyLandOnSameSquare [

	| aGame expectedResult jorgeShip julianShip joseShip aDeck aCard cardsToDraw |
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 2. 2. 2. 2. 1 }) } "Jorge mueve 3, Julian mueve 2, Jose mueve 2, En la pelea Jose sacaria 2, y Julian sacaria 3 2<3"
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aGame nextTurn. "Jorge avanza hasta 4"
	
	aGame nextTurn. "Julian avanza hasta 3"
	
	aDeck := aGame cardsOf: joseShip .
	aCard := aDeck first.

	aGame playCard: aCard by: joseShip target: julianShip. "Jose contrata a Julian como mercenario"
	aGame nextTurn. "Jose avanza hasta 3 y no pelea con Julian"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jose').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 1)}).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 2)}).

	self assert: aGame boardStateWithCards equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 3.
	self assert: joseShip remainingShields equals: 3.

]

{ #category : 'as yet unclassified' }
MercenaryCardTest >> testWhenShipUsesMercenaryCardOnATargetShipThenTheyDontFightIfTheyLandOnSameSquareEvenWhenContracteeIsTheOneStartingTheFight [

	| aGame expectedResult jorgeShip julianShip joseShip aDeck aCard cardsToDraw |
	
	cardsToDraw := OrderedCollection with: MercenaryCard new.
	jorgeShip := Ship named: 'Jorge'.
	julianShip := Ship named: 'Julian'.
	joseShip := Ship named: 'Jose'.

	aGame := ShipBattleGame
		         inSize: 10
		         rounds: 2
		         with: { (LoadedDie withSides: { 3. 2. 2. 2. 2. 1 }) } "Jorge mueve 3, Julian mueve 2, Jose mueve 2, En la pelea Jose sacaria 2, y Julian sacaria 3 2<3"
		         and: {
				         jorgeShip.
				         julianShip.
				         joseShip }
		         withSpecialSquaresAt: (Dictionary newFrom: {  })
		         withDeck: (LoadedDeck cards: cardsToDraw).
	
	aGame nextTurn. "Jorge avanza hasta 4"
	
	aDeck := aGame cardsOf: julianShip.
	aCard := aDeck first.

	aGame playCard: aCard by: julianShip target: joseShip. "Julian contrata a Jose como mercenario"
	aGame nextTurn. "Julian avanza hasta 3"
	
	aGame nextTurn. "Jose avanza hasta 3 y no pelea con Julian"

	expectedResult := OrderedDictionary new.
	expectedResult at: '1°' put: (Dictionary newFrom: {
				 ('name' -> 'Jorge').
				 ('position' -> 4).
				 ('lap' -> 1).
				 ('card count' -> 2)}).
	expectedResult at: '2°' put: (Dictionary newFrom: {
				 ('name' -> 'Jose').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 2)}).
	expectedResult at: '3°' put: (Dictionary newFrom: {
				 ('name' -> 'Julian').
				 ('position' -> 3).
				 ('lap' -> 1).
				 ('card count' -> 1)}).

	self assert: aGame boardStateWithCards equals: expectedResult.
	self assert: jorgeShip remainingShields equals: 3.
	self assert: julianShip remainingShields equals: 3.
	self assert: joseShip remainingShields equals: 3.

]
