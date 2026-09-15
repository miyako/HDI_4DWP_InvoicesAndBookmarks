//%attributes = {"invisible":true}
[TEMPLATES:1]WP:2:=WParea
SAVE RECORD:C53([TEMPLATES:1])

COPY SET:C600("$templateSet"; "$tempSet")

SelectTemplates

COPY SET:C600("$tempSet"; "$templateSet")
USE SET:C118("$templateSet")
CLEAR SET:C117("$tempSet")
