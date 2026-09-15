//%attributes = {"invisible":true}

var $folder; $Path; $localizedFolder : Text
var $i; $n : Integer
var $allRecords : Boolean

CONFIRM:C162(Localized string("ConfirmExportPrompt"); Localized string("ButtonLocalizedOnly"); Localized string("ButtonAllRecords"))

If (ok=1)  // localized only
	$allRecords:=False:C215
	SelectTemplates
	USE NAMED SELECTION:C332("$allTemplates")
	
	$localizedFolder:=Request:C163(Localized string("RequestExportPrompt"); Get database localization:C1009(User system localization:K5:23)+".lproj"; Localized string("CommonOK"); Localized string("CommonCancel"))
	If (ok=1)
		$folder:=Get 4D folder:C485(Current resources folder:K5:16)+$localizedFolder+Folder separator:K24:12+"Templates"+Folder separator:K24:12
		If (Not:C34(Test path name:C476($folder)=Is a folder:K24:2))
			CREATE FOLDER:C475($folder)
		End if 
	End if 
	
Else   // all records
	
	$allRecords:=True:C214
	ALL RECORDS:C47([TEMPLATES:1])
	$folder:=Select folder:C670(Localized string("SelectFolderPrompt"))
	
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
	
	ALERT:C41(Localized string("AlertExportComplete"))
	
End if 