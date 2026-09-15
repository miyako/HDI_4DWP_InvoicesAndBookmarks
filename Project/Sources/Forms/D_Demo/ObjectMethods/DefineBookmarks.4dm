//%attributes = {"invisible":true}
var $i; $n; $p : Integer
var $menu; $value : Text
var $WP_widgetPtr : Pointer

ARRAY TEXT:C222(_CurrentBookmarks; 0)
WP GET BOOKMARKS:C1417(WParea; _CurrentBookmarks)

$n:=Size of array:C274(_bookmarkNames)

$menu:=Create menu:C408

For ($i; 1; $n)
	APPEND MENU ITEM:C411($menu; _MenuNames{$i})
	SET MENU ITEM PARAMETER:C1004($menu; -1; _bookmarkNames{$i})
	
	$p:=Find in array:C230(_CurrentBookmarks; _bookmarkNames{$i})
	If ($p>0)
		SET MENU ITEM ICON:C984($menu; -1; "File:Icons/Done.png")
	Else 
		If (_mandatory{$i}=True:C214)
			SET MENU ITEM ICON:C984($menu; -1; "File:Icons/Missing.png")
		Else 
			SET MENU ITEM ICON:C984($menu; -1; "File:Icons/Option.png")
		End if 
	End if 
	
End for 

$value:=Dynamic pop up menu:C1006($menu)

If ($value#"")
	UpdateBookMark($value)  // create or update
	
	// update widget
	
	$WP_widgetPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPwidget")
	$WP_widgetPtr->:=$WP_widgetPtr->
	
End if 

RELEASE MENU:C978($menu)

CheckBookmarks

