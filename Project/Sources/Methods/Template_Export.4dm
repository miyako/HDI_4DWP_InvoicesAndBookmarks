//%attributes = {"invisible":true}

C_TEXT:C284($folder; $Path; $localizedFolder)
C_LONGINT:C283($i; $n)
C_BOOLEAN:C305($allRecords)

CONFIRM:C162("Export all templates or localized ?"; "Localized only"; "All records")

If (ok=1)  // localized only
	$allRecords:=False:C215
	SelectTemplates
	USE NAMED SELECTION:C332("$allTemplates")
	
	$localizedFolder:=Request:C163("Export into…"; Get database localization:C1009(User system localization:K5:23)+".lproj"; "Ok"; "Cancel")
	If (ok=1)
		$folder:=Get 4D folder:C485(Current resources folder:K5:16)+$localizedFolder+Folder separator:K24:12+"Templates"+Folder separator:K24:12
		If (Not:C34(Test path name:C476($folder)=Is a folder:K24:2))
			CREATE FOLDER:C475($folder)
		End if 
	End if 
	
Else   // all records
	
	$allRecords:=True:C214
	ALL RECORDS:C47([TEMPLATES:1])
	$folder:=Select folder:C670("Select export folder")
	
End if 

If (ok=1)
	
	$n:=Records in selection:C76([TEMPLATES:1])
	
	For ($i; 1; $n)
		GOTO SELECTED RECORD:C245([TEMPLATES:1]; $i)
		
		$Path:=$folder
		$Path:=$Path+[TEMPLATES:1]Name:3
		
		If ($allRecords)
			$Path:=$Path+"("+[TEMPLATES:1]Language:5+")"
		End if 
		$Path:=$Path+".4wp"
		
		WP EXPORT DOCUMENT:C1337([TEMPLATES:1]WP:2; $Path)
		
	End for 
	
	ALERT:C41("Explort complete!")
	
End if 