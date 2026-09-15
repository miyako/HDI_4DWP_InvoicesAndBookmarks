//%attributes = {"invisible":true}
var $n : Integer

ALL RECORDS:C47([INVOICE:3])
$n:=Records in selection:C76([INVOICE:3])
GOTO SELECTED RECORD:C245([INVOICE:3]; 1+(Random:C100%$n))
// finds the customer
QUERY:C277([CUSTOMER:2]; [CUSTOMER:2]CustomerNumber:9=[INVOICE:3]CustomerReference:4)

// finds the lines for this invoice
QUERY:C277([INVOICE_LINES:4]; [INVOICE_LINES:4]InvoiceReference:2=[INVOICE:3]InvoiceNumber:2)  // 1st invoice line
$n:=Records in selection:C76([INVOICE_LINES:4])
GOTO SELECTED RECORD:C245([INVOICE_LINES:4]; 1+(Random:C100%$n))

QUERY:C277([ARTICLES:5]; [ARTICLES:5]ArticleNumber:2=[INVOICE_LINES:4]ArticleReference:3)  // line article

vTotalHT:=[ARTICLES:5]Price:6
vTotalVAT:=([ARTICLES:5]Price:6*[ARTICLES:5]VATrate:7/100)
vTotalTTC:=vTotalHT+vTotalVAT

ST COMPUTE EXPRESSIONS:C1285(*; "WParea"; ST Start text:K78:15; ST End text:K78:16)
