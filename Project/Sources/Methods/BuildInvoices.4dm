//%attributes = {"invisible":true,"preemptive":"capable"}

C_LONGINT:C283($i; $j; $n; $p)

C_LONGINT:C283($nbInvoices; $nbLines)

C_OBJECT:C1216($range; $buildRange; $empty; $RangeDoc; $invoiceLineDoc; $totalDoc; $bottomDoc)

vTotalHT:=0
vTotalVAT:=0
vTotalTTC:=0

ARRAY TEXT:C222($_BookmarkNames; 0)
WP GET BOOKMARKS:C1417([TEMPLATES:1]WP:2; $_BookmarkNames)

//init build invoice by coping template and deleting all text content
//(it should be better to have a ready copy yet of the empty invoice as invoice base template)

WPbuild:=OB Copy:C1225(WParea)
//WP SELECT(WPbuild;wk start text;wk end text)

$buildRange:=WP Text range:C1341(WPbuild; wk start text:K81:165; wk end text:K81:164)  // final invoice global range

$range:=WP Text range:C1341(WPbuild; wk start text:K81:165; wk start text:K81:165)
$empty:=WP New:C1317($range)  // empty document

WP Insert document body:C1411($buildRange; $empty; wk replace:K81:177)

QUERY:C277([INVOICE:3]; [INVOICE:3]CustomerReference:4=[CUSTOMER:2]CustomerNumber:9)
$nbInvoices:=Records in selection:C76([INVOICE:3])

For ($j; 1; $nbInvoices)
	
	GOTO SELECTED RECORD:C245([INVOICE:3]; $j)
	
	$p:=Find in array:C230($_BookmarkNames; "Main_Header")
	If ($p>0)
		$Range:=WP Bookmark range:C1416(WParea; $_BookmarkNames{$p})
		$RangeDoc:=WP New:C1317($Range)
		WP Insert document body:C1411($buildRange; $RangeDoc; wk append:K81:179+wk freeze expressions:K81:184)  //1 = wk insert: after replacement, $buildRange is equal to end of replaced text
	End if 
	
	$nbLines:=0
	
	$p:=Find in array:C230($_BookmarkNames; "Invoice_Line")
	If ($p>0)
		$Range:=WP Bookmark range:C1416(WParea; $_BookmarkNames{$p})
		$invoiceLineDoc:=WP New:C1317($Range)
		
		QUERY:C277([INVOICE_LINES:4]; [INVOICE_LINES:4]InvoiceReference:2=[INVOICE:3]InvoiceNumber:2)
		
		vTotalHT:=0
		vTotalVAT:=0
		vTotalTTC:=0
		
		$n:=Records in selection:C76([INVOICE_LINES:4])
		$nbLines:=0
		For ($i; 1; $n)
			
			// ADD next invoice line
			
			GOTO SELECTED RECORD:C245([INVOICE_LINES:4]; $i)
			QUERY:C277([ARTICLES:5]; [ARTICLES:5]ArticleNumber:2=[INVOICE_LINES:4]ArticleReference:3)
			WP Insert document body:C1411($buildRange; $invoiceLineDoc; wk append:K81:179+wk freeze expressions:K81:184)
			
			vTotalHT:=vTotalHT+[ARTICLES:5]Price:6
			vTotalVAT:=vTotalVAT+(([ARTICLES:5]Price:6*[ARTICLES:5]VATrate:7)/100)
			vTotalTTC:=vTotalHT+vTotalVAT
			
			$nbLines:=$nbLines+1
			
			// IF max number of lines reached (and more to come)
			// THEN add an intermediate footer (if any) and an intermediate header (if any)
			
			If ([TEMPLATES:1]NbLines:4>0) & ($nbLines>=[TEMPLATES:1]NbLines:4) & ($i<$n)
				
				$p:=Find in array:C230($_BookmarkNames; "Sub_Total")
				If ($p>0)
					$Range:=WP Bookmark range:C1416(WParea; $_BookmarkNames{$p})
					$RangeDoc:=WP New:C1317($Range)
					WP Insert document body:C1411($buildRange; $RangeDoc; wk append:K81:179+wk freeze expressions:K81:184)  //1 = wk insert: after replacement, $buildRange is equal to end of replaced text
				End if 
				
				
				$p:=Find in array:C230($_BookmarkNames; "Secondary_Footer")
				
				If ($p<0)  // if no secondary footer, find main footer
					$p:=Find in array:C230($_BookmarkNames; "Main_Footer")
				End if 
				
				If ($p>0)
					$Range:=WP Bookmark range:C1416(WParea; $_BookmarkNames{$p})
					$RangeDoc:=WP New:C1317($Range)
					WP Insert document body:C1411($buildRange; $RangeDoc; wk append:K81:179+wk freeze expressions:K81:184)  //1 = wk insert: after replacement, $buildRange is equal to end of replaced text
				End if 
				
				WP Insert break:C1413($buildRange; wk page break:K81:188; wk append:K81:179)
				$buildRange:=WP Text range:C1341(WPbuild; wk end text:K81:164; wk end text:K81:164)
				
				$p:=Find in array:C230($_BookmarkNames; "Secondary_Header")
				If ($p<0)  // if no secondary header, use main header
					$p:=Find in array:C230($_BookmarkNames; "Main_Header")
				End if 
				If ($p>0)
					$Range:=WP Bookmark range:C1416(WParea; $_BookmarkNames{$p})
					$RangeDoc:=WP New:C1317($Range)
					WP Insert document body:C1411($buildRange; $RangeDoc; wk append:K81:179+wk freeze expressions:K81:184)  //1 = wk insert: after replacement, $buildRange is equal to end of replaced text
				End if 
				
				$nbLines:=0
			End if 
			
		End for 
		
	End if 
	
	// PRINT FINAL TOTAL
	
	$p:=Find in array:C230($_BookmarkNames; "Total")
	If ($p>0)
		$Range:=WP Bookmark range:C1416(WParea; $_BookmarkNames{$p})
		$totalDoc:=WP New:C1317($Range)
		WP Insert document body:C1411($buildRange; $totalDoc; wk append:K81:179+wk freeze expressions:K81:184)
	End if 
	
	// PRINT EMPTY LINES
	
	$p:=Find in array:C230($_BookmarkNames; "Filler")
	If ($p>0)
		$Range:=WP Bookmark range:C1416(WParea; $_BookmarkNames{$p})
		While ($nbLines<[TEMPLATES:1]NbLines:4)
			$RangeDoc:=WP New:C1317($Range)
			WP Insert document body:C1411($buildRange; $RangeDoc; wk append:K81:179)  //1 = wk insert: after replacement, $buildRange is equal to end of replaced text
			$nbLines:=$nbLines+1
		End while 
	End if 
	
	// PRINT MAIN FOOTER
	
	$p:=Find in array:C230($_BookmarkNames; "Main_Footer")
	If ($p>0)
		$Range:=WP Bookmark range:C1416(WParea; $_BookmarkNames{$p})
		$bottomDoc:=WP New:C1317($Range)
		WP Insert document body:C1411($buildRange; $bottomDoc; wk append:K81:179+wk freeze expressions:K81:184)
	End if 
	
	
	If ($j#$nbInvoices)  // insert page break except for last page
		WP Insert break:C1413($buildRange; wk page break:K81:188; wk append:K81:179)
		$buildRange:=WP Text range:C1341(WPbuild; wk end text:K81:164; wk end text:K81:164)
	End if 
	
	
End for 

//End if 
