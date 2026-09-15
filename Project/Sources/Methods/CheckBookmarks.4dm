//%attributes = {"invisible":true}
var $i; $n; $p : Integer
var $result : Boolean
var $format : Text

ARRAY TEXT:C222(_CurrentBookmarks; 0)
WP GET BOOKMARKS:C1417(WParea; _CurrentBookmarks)

$n:=Size of array:C274(_bookmarkNames)

$result:=True:C214  // optimistic result
For ($i; 1; $n)
	$p:=Find in array:C230(_CurrentBookmarks; _bookmarkNames{$i})
	
	If ($p<0) & (_mandatory{$i}=True:C214)  //not found and mandatory, exit loop
		$result:=False:C215
		$i:=$n
	End if 
	
End for 

If ($result=False:C215)
	$format:=Localized string("DefineBookmarks")+";#Icons/x-red.png;0;3;1;1;8;0;0;0;1;0;1"
Else 
	$format:=Localized string("DefineBookmarks")+";#Icons/Ckeck.png;0;3;1;1;8;0;0;0;1;0;1"
End if 

OBJECT SET FORMAT:C236(*; "DefineBookmarks"; $format)

