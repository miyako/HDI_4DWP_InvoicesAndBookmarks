//%attributes = {}
var $language : Text

$language:=Get database localization:C1009(User system localization:K5:23)

// 1st try to load localised templates

QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Language:5=$language)

If (Records in selection:C76([TEMPLATES:1])=0)
	
	// 2nb  try to import localized templates
	
	Template_Import($language)  // try to import some
	
	QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Language:5=$language)
	
	If (Records in selection:C76([TEMPLATES:1])=0)
		
		// 3nd try to load english templates
		
		QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Language:5="EN")
		
		If (Records in selection:C76([TEMPLATES:1])=0)
			
			// 4th  try to import EN templates
			
			Template_Import("en")  // try to import some in english
			
		End if 
	End if 
End if 

UNLOAD RECORD:C212([TEMPLATES:1])
