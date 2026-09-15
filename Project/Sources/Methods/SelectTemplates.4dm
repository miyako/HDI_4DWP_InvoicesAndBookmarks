//%attributes = {}
var $language : Text

$language:=Get database localization:C1009(User system localization:K5:23)

QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Language:5=$language)

If (Records in selection:C76([TEMPLATES:1])=0)  // no templates for current language
	QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Language:5="EN")
End if 

ORDER BY:C49([TEMPLATES:1]; [TEMPLATES:1]Name:3; >)
COPY NAMED SELECTION:C331([TEMPLATES:1]; "$allTemplates")
