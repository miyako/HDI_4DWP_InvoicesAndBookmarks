//%attributes = {}
//ALL RECORDS([ARTICLES])
//APPLY TO SELECTION([ARTICLES];[ARTICLES]BarCode:=Barcode_Create ("code128C";Substring([ARTICLES]ArticleNumber;1;16);True;True;True))


//$path:=Get 4D folder(Current resources folder)+"Icons"+Folder separator+"IconAudioBook.png"
//READ PICTURE FILE($path;$icon)
//QUERY([ARTICLES];[ARTICLES]Type="Audio book")
//APPLY TO SELECTION([ARTICLES];[ARTICLES]Icon:=$icon)


//$path:=Get 4D folder(Current resources folder)+"Icons"+Folder separator+"IconAudioCD.png"
//READ PICTURE FILE($path;$icon)
//QUERY([ARTICLES];[ARTICLES]Type="CD Audio")
//APPLY TO SELECTION([ARTICLES];[ARTICLES]Icon:=$icon)


//$path:=Get 4D folder(Current resources folder)+"Icons"+Folder separator+"IconBook.png"
//READ PICTURE FILE($path;$icon)
//QUERY([ARTICLES];[ARTICLES]Type="Book")
//APPLY TO SELECTION([ARTICLES];[ARTICLES]Icon:=$icon)


//$path:=Get 4D folder(Current resources folder)+"Icons"+Folder separator+"IconDVD.png"
//READ PICTURE FILE($path;$icon)
//QUERY([ARTICLES];[ARTICLES]Type="DVD")
//APPLY TO SELECTION([ARTICLES];[ARTICLES]Icon:=$icon)


//$path:=Get 4D folder(Current resources folder)+"Icons"+Folder separator+"IconCellPhone.png"
//READ PICTURE FILE($path;$icon)
//QUERY([ARTICLES];[ARTICLES]Type="Cell phone")
//APPLY TO SELECTION([ARTICLES];[ARTICLES]Icon:=$icon)

//$path:=Get 4D folder(Current resources folder)+"Icons"+Folder separator+"IconWatch.png"
//READ PICTURE FILE($path;$icon)
//QUERY([ARTICLES];[ARTICLES]Type="Watch")
//APPLY TO SELECTION([ARTICLES];[ARTICLES]Icon:=$icon)



//ALL RECORDS([INVOICE])
//APPLY TO SELECTION([INVOICE];[INVOICE]BarCode:=Barcode_Create ("code128C";Substring([INVOICE]InvoiceNumber;1;16);True;True;True))

//ALERT("Done")
