//%attributes = {"invisible":true}
var $col; $row : Integer

Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		If (Records in set:C195("$customersSet")>0)
			
			LISTBOX GET CELL POSITION:C971(*; "LB_Customers"; $col; $row)
			
			If ($row>0) & ($row<Records in selection:C76([CUSTOMER:2]))
				
				//If (Records in set("$customersSet")>0)
				//USE SET("$customersSet")
				//LOAD RECORD([CUSTOMER])
				
				GOTO SELECTED RECORD:C245([CUSTOMER:2]; $row)
				BuildInvoices  // (_Customers)
				
			End if 
		End if 
		
End case 
