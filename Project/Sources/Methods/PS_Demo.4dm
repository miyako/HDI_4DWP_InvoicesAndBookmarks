//%attributes = {}
C_LONGINT:C283($1)

C_TEXT:C284($currentMethodName)
C_LONGINT:C283($ps; $win)

If (Count parameters:C259=0)
	
	$currentMethodName:=Current method name:C684
	$ps:=Process number:C372($currentMethodName)
	
	If ($ps=0)
		$ps:=New process:C317($currentMethodName; 0; $currentMethodName; 1)
	Else 
		BRING TO FRONT:C326($ps)
	End if 
	
Else 
	
	READ ONLY:C145(*)
	READ WRITE:C146([TEMPLATES:1])
	$win:=Open form window:C675("D_Demo"; Plain form window:K39:10; On the right:K39:3; At the bottom:K39:6; *)
	DIALOG:C40("D_Demo")
	
End if 