//%attributes = {"invisible":true}
C_TEXT:C284($1)

C_TEXT:C284($bookmarkName)
C_LONGINT:C283($p)
C_OBJECT:C1216($wpRange)

$bookmarkName:=$1

ARRAY TEXT:C222($_bookmarks; 0)
WP GET BOOKMARKS:C1417(WParea; $_bookmarks)

$p:=Find in array:C230($_bookmarks; $bookmarkName)
If ($p>0)
	WP DELETE BOOKMARK:C1419(WParea; $bookmarkName)
End if 

$wpRange:=WP Selection range:C1340(WParea)
WP NEW BOOKMARK:C1415($wpRange; $bookmarkName)

