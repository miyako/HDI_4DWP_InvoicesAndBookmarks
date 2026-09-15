

If (Records in set:C195("$templateSet")=1)
	
	USE SET:C118("$templateSet")
	DELETE RECORD:C58([TEMPLATES:1])
	
	SelectTemplates
	
	LOAD RECORD:C52([TEMPLATES:1])
	WParea:=[TEMPLATES:1]WP:2
	
	CREATE EMPTY SET:C140([TEMPLATES:1]; "$templateSet")
	ADD TO SET:C119([TEMPLATES:1]; "$templateSet")
	
	
Else 
	ALERT:C41("Select template to delete first !")
End if 