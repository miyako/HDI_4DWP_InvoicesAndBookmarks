C_TEXT:C284($tutoPath)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		// page 1
		
		//QUERY([TUTORIAL];[TUTORIAL]Language=Get database localization(User system localization))
		//If (Records in selection([TUTORIAL])=0)
		//QUERY([TUTORIAL];[TUTORIAL]Language="EN")
		//End if 
		
		$tutoPath:=""
		$tutoPath:=$tutoPath+Get 4D folder:C485(Current resources folder:K5:16)
		$tutoPath:=$tutoPath+Get database localization:C1009(User system localization:K5:23)+".lproj"+Folder separator:K24:12+"tutorial.4wp"
		
		If (Not:C34(Test path name:C476($tutoPath)=Is a document:K24:1))
			$tutoPath:=""
			$tutoPath:=$tutoPath+Get 4D folder:C485(Current resources folder:K5:16)
			$tutoPath:=$tutoPath+"en.lproj"+Folder separator:K24:12+"tutorial.4wp"
		End if 
		
		wpTutorial:=WP Import document:C1318($tutoPath)
		
		tab1:=1
		tab2:=0
		tab3:=0
		
		
		// page 2
		
		SelectTemplates
		
		vTotalHT:=0
		vTotalVAT:=0
		vTotalTTC:=0
		
		LOAD RECORD:C52([TEMPLATES:1])
		WParea:=[TEMPLATES:1]WP:2
		
		CREATE EMPTY SET:C140([TEMPLATES:1]; "$templateSet")
		ADD TO SET:C119([TEMPLATES:1]; "$templateSet")
		
		RandomInvoice
		
		//----------------------------------------------------------------
		
		ARRAY TEXT:C222(_MenuNames; 0)
		ARRAY TEXT:C222(_bookmarkNames; 0)
		ARRAY BOOLEAN:C223(_mandatory; 0)
		ARRAY TEXT:C222(_CurrentBookmarks; 0)
		
		APPEND TO ARRAY:C911(_MenuNames; "Define Main Header")
		APPEND TO ARRAY:C911(_MenuNames; "Define Secondary Header")
		APPEND TO ARRAY:C911(_MenuNames; "Define Invoice Line")
		APPEND TO ARRAY:C911(_MenuNames; "Define Filler")
		APPEND TO ARRAY:C911(_MenuNames; "Define Sub-Total")
		APPEND TO ARRAY:C911(_MenuNames; "Define Total")
		APPEND TO ARRAY:C911(_MenuNames; "Define Main Footer")
		APPEND TO ARRAY:C911(_MenuNames; "Define Secondary Footer")
		
		APPEND TO ARRAY:C911(_bookmarkNames; "Main_Header")
		APPEND TO ARRAY:C911(_bookmarkNames; "Secondary_Header")
		APPEND TO ARRAY:C911(_bookmarkNames; "Invoice_Line")
		APPEND TO ARRAY:C911(_bookmarkNames; "Filler")
		APPEND TO ARRAY:C911(_bookmarkNames; "Sub_Total")
		APPEND TO ARRAY:C911(_bookmarkNames; "Total")
		APPEND TO ARRAY:C911(_bookmarkNames; "Main_Footer")
		APPEND TO ARRAY:C911(_bookmarkNames; "Secondary_Footer")
		
		APPEND TO ARRAY:C911(_mandatory; False:C215)
		APPEND TO ARRAY:C911(_mandatory; False:C215)
		APPEND TO ARRAY:C911(_mandatory; True:C214)
		APPEND TO ARRAY:C911(_mandatory; False:C215)
		APPEND TO ARRAY:C911(_mandatory; False:C215)
		APPEND TO ARRAY:C911(_mandatory; True:C214)
		APPEND TO ARRAY:C911(_mandatory; False:C215)
		APPEND TO ARRAY:C911(_mandatory; False:C215)
		
		WP GET BOOKMARKS:C1417(WParea; _CurrentBookmarks)
		
		
		CheckBookmarks
		
		// Page 3
		
		ALL RECORDS:C47([CUSTOMER:2])
		ORDER BY:C49([CUSTOMER:2]; [CUSTOMER:2]Lastname:2; >)
		CREATE EMPTY SET:C140([CUSTOMER:2]; "$customersSet")
		ADD TO SET:C119([CUSTOMER:2]; "$customersSet")
		
		BuildInvoices
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
End case 