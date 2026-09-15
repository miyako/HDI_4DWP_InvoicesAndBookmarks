//%attributes = {}
#DECLARE($params : Object)

var $currentMethodName : Text
var $ps; $win : Integer

If (Count parameters:C259=0)
	
	$currentMethodName:=Current method name:C684
	$ps:=Process number:C372($currentMethodName)
	
	If ($ps=0)
		CALL WORKER(1; $currentMethodName; New object)
	Else 
		BRING TO FRONT:C326($ps)
	End if 
	
Else 
	
	READ ONLY:C145(*)
	READ WRITE:C146([TEMPLATES:1])
	$win:=Open form window:C675("D_Demo"; Plain form window:K39:10; On the right:K39:3; At the bottom:K39:6; *)
	DIALOG:C40("D_Demo"; *)
	
End if 
