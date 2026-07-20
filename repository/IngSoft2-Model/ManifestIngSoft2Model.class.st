"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestIngSoft2Model',
	#superclass : 'PackageManifest',
	#category : 'IngSoft2-Model-Manifest',
	#package : 'IngSoft2-Model',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestIngSoft2Model class >> ruleReClassNotCategorizedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'IngSoft2-Model')) #'2026-07-20T16:28:35.795593-03:00') )
]

{ #category : 'code-critics' }
ManifestIngSoft2Model class >> ruleSendsDifferentSuperRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AdditionalSquares #initializeOf:usedBy: #false)) #'2026-07-18T04:16:00.277516-03:00') #(#(#RGPackageDefinition #(#'IngSoft2-Model')) #'2026-07-20T16:29:02.42342-03:00') )
]
