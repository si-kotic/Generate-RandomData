Function Generate-RandomData {
	Param (
		[Parameter(Mandatory,ValueFromPipeline)]
		[ValidateScript({Test-Path $_ -IsValid})]
		[String]$Path,
		[Int]$NumberOfOutputs = "1",
		[ValidateScript({Test-Path $_ -IsValid})]
		[String]$OutputDirectory = $Path.TrimEnd($Path.Split("\")[-1])
	)
	
	IF (!(Get-InstalledModule -Name NameIT)) {
		Write-Output "Installing required module:  NameIT"
		Install-Module -Name NameIT
	}
	
	$templateName = (Get-Item $Path).BaseName
	$Ext = (Get-Item $Path).Extension
	IF (!($OutputDirectory[-1] -eq "\")) {
		$OutputDirectory = $OutputDirectory + "\"
	}

	$CustomDataSets = @{
	    Country=echo UK France Germany US Russia Ireland Spain Qatar UAE "Saudi Arabia" Israel Morocco Luxembourg Portugal Croatia Romania Poland Hungary Mexico Canada Brazil Panama

	    City=echo London Dublin Manchester Liverpool Cambridge Edinburgh Paris Luxembourg "Tel Aviv" Riyadh Doha Vancouver "New York" Washington Ontario "Mexico City" Barcelona Madrid Casablanca
	}

	$template = Get-Content $Path -Raw
	$xmlTemplate = [XML]$template
	IF ($xmlTemplate.FirstChild.NodeType -eq "XmlDeclaration") {
		$template = $template -replace "\<\?xml(.+?)\?\>",""
		$regex = [Regex]"\n"
		$template = $regex.Replace($template, "", 1)
	}

	$i = 1
	Invoke-Generate $template -CustomData $CustomDataSets -Count $NumberOfOutputs | ForEach-Object {
		$xml = [XML]$_
		$xmlDec = $xml.CreateXMLDeclaration("1.0","utf-8","no")
		$xml.InsertBefore($xmlDec, $xml.DocumentElement)
		$fileName = $OutputDirectory + $templateName + "_" + $i + $Ext
		$i++	
		$xml.Save($fileName)
	} | Out-Null

}