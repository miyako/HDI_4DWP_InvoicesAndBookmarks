C_POINTER:C301($WP_widgetPtr)
C_TEXT:C284($user; $session; $psname)
C_LONGINT:C283($ps)

Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		If (Records in set:C195("$templateSet")#0)
			
			USE SET:C118("$templateSet")
			
			LOAD RECORD:C52([TEMPLATES:1])
			If (Locked:C147([TEMPLATES:1]))
				ALERT:C41("Locked record")
				LOCKED BY:C353([TEMPLATES:1]; $ps; $user; $session; $psname)
			End if 
			
			WParea:=[TEMPLATES:1]WP:2
			
			$WP_widgetPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPwidget")
			$WP_widgetPtr->:=$WP_widgetPtr->
			
			CheckBookmarks
			GOTO OBJECT:C206(*; "WPArea")
			
			OBJECT SET ENTERABLE:C238(*; "WPArea"; True:C214)
		Else 
			
			UNLOAD RECORD:C212([TEMPLATES:1])
			WPArea:=WP New:C1317
			OBJECT SET ENTERABLE:C238(*; "WPArea"; False:C215)
			
		End if 
		
	: (Form event code:C388=On Getting Focus:K2:7)
		
		SaveTemplate
		
End case 