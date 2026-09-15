//%attributes = {"invisible":true}
C_TEXT:C284($1)

C_TEXT:C284($folder; $templateName)
C_TEXT:C284($language)

C_LONGINT:C283($i; $n)

If (Count parameters:C259=0)
	$language:=""
	$folder:=Select folder:C670("Select import folder")
Else 
	$language:=$1
	$folder:=Get 4D folder:C485(Current resources folder:K5:16)+$language+".lproj"+Folder separator:K24:12+"Templates"+Folder separator:K24:12
	If (Not:C34(Test path name:C476($folder)=Is a folder:K24:2))
		ok:=0
	End if 
End if 

If (ok=1)
	DOCUMENT LIST:C474($folder; $_docs; Ignore invisible:K24:16)
	$n:=Size of array:C274($_docs)
	For ($i; 1; $n)
		
		$templateName:=Substring:C12($_docs{$i}; 1; Length:C16($_docs{$i})-4)
		QUERY:C277([TEMPLATES:1]; [TEMPLATES:1]Name:3=$templateName; *)
		QUERY:C277([TEMPLATES:1];  & ; [TEMPLATES:1]Language:5=$language)
		
		If (Records in selection:C76([TEMPLATES:1])>0)
			LOAD RECORD:C52([TEMPLATES:1])
		Else 
			CREATE RECORD:C68([TEMPLATES:1])
		End if 
		
		[TEMPLATES:1]WP:2:=WP Import document:C1318($folder+$_docs{$i})
		[TEMPLATES:1]Name:3:=Substring:C12($_docs{$i}; 1; Length:C16($_docs{$i})-4)
		[TEMPLATES:1]Language:5:=$language
		
		SAVE RECORD:C53([TEMPLATES:1])
	End for 
End if 
