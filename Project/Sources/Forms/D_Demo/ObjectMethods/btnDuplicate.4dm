//%attributes = {"invisible":true}
var $i; $n : Integer
var $NewName : Text

If (Records in set:C195("$templateSet")=1)
	
	USE SET:C118("$templateSet")
	DUPLICATE RECORD:C225([TEMPLATES:1])
	
	SET QUERY DESTINATION:C396(Into variable:K19:4; $n)
	
	$NewName:=[TEMPLATES:1]Name:3+"-Copy"
	QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Name:3=$NewName)
	If ($n>0)
		$i:=0
		Repeat 
			$i:=$i+1
			$NewName:=[TEMPLATES:1]Name:3+"-Copy-"+String:C10($i)
			QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Name:3=$NewName)
		Until ($n=0)
	End if 
	
	[TEMPLATES:1]Name:3:=$NewName
	SAVE RECORD:C53([TEMPLATES:1])
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	SelectTemplates  // rebuild named selection
	
	// use duplicated record
	SET QUERY DESTINATION:C396(Into set:K19:2; "$templateSet")
	QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Name:3=$NewName)
	USE SET:C118("$templateSet")  // current record !
	
	// back to current selection (for what comes next)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	WParea:=[TEMPLATES:1]WP:2
	
Else 
	ALERT:C41("Select template to duplicate first !")
End if 
