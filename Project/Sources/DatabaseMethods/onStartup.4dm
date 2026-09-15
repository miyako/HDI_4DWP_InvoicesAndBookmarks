//%attributes = {"invisible":true}
For each ($dataClass; ds:C1482)
	If (ds:C1482[$dataClass].getCount()=0)
		$project:=File:C1566("/RESOURCES/"+$dataClass+".4si").getText()
		$path:=File:C1566("/RESOURCES/"+$dataClass+".4ie").platformPath
		IMPORT DATA:C665($path; $project)
	End if 
End for each 

AllowMethods

InitTemplates

PS_Demo

