
@('xls', 'xlt', 'ppt', 'pot', 'doc', 'dot', 'pdf') | % {
$extension = $_
$outputPath = 'E:\SampleFiles\INet'

$term = 'filetype:' + $extension
#$url = 'http://search.live.com/results.aspx?q=' + [System.Web.HttpUtility]::UrlEncode($term)
$url = 'http://www.google.com/search?num=100&hl=en&lr=&as_qdr=all&q=' + [System.Web.HttpUtility]::UrlEncode($term)
$client = New-Object System.Net.WebClient
$result = $client.DownloadString($url).Split(' ;>') | Select-String -Pattern 'href="http' 
$result | % {
	$urlLink = New-Object Uri $_.Line.Trim('href=').Trim('"')	
	$file = $urlLink.Segments[$urlLink.Segments.Length - 1]	
	if ($file.EndsWith($extension)) {
		$localFile = Join-Path $outputPath $file
		$client.DownloadFile($urlLink, $localFile)
	}
}

}