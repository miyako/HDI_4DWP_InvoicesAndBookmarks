//%attributes = {"invisible":true}
var $i; $n : Integer
var $NewName : Text

SET QUERY DESTINATION:C396(Into variable:K19:4; $n)

$NewName:="New Template"
QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Name:3=$NewName)
If ($n>0)
	$i:=0
	Repeat 
		$i:=$i+1
		$NewName:="New Template"+String:C10($i)
		QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Name:3=$NewName)
	Until ($n=0)
End if 

CREATE RECORD:C68([TEMPLATES:1])
[TEMPLATES:1]Name:3:=$NewName
[TEMPLATES:1]Language:5:=Get database localization:C1009(User system localization:K5:23)
SAVE RECORD:C53([TEMPLATES:1])


// rebuild named selection
SET QUERY DESTINATION:C396(Into current selection:K19:1)

SelectTemplates

// use duplicated record
SET QUERY DESTINATION:C396(Into set:K19:2; "$templateSet")
QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Name:3=$NewName)
USE SET:C118("$templateSet")  // current record !

// back to current selection (for what comes next)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

