//%attributes = {"invisible":true}
var $folder; $Path; $resourcesPath : Text
var $i; $n : Integer

$resourcesPath:=Get 4D folder:C485(Current resources folder:K5:16)

If (ok=1)
	ALL RECORDS:C47([TUTORIAL:6])
	$n:=Records in selection:C76([TUTORIAL:6])
	
	
	For ($i; 1; $n)
		GOTO SELECTED RECORD:C245([TUTORIAL:6]; $i)
		
		$Path:=$resourcesPath+[TUTORIAL:6]Language:2+".lproj"+Folder separator:K24:12
		If (Not:C34(Test path name:C476($Path)=Is a folder:K24:2))
			CREATE FOLDER:C475($Path)
		End if 
		
		$Path:=$path+"tutorial.4wp"
		WP EXPORT DOCUMENT:C1337([TUTORIAL:6]Tuto:3; $Path)
		
	End for 
End if 