$folder = 'C:\Temp\WD'
if (!(Test-Path $folder)) { mkdir $folder | Out-Null }

$x86Url = 'http://download.microsoft.com/download/DefinitionUpdates/mpam-fe.exe'
$x86Local = Join-Path $folder 'mpam-fex86.exe'
if (Test-Path $x86Local) { ri -force $x86Local }

$x64Url = 'http://download.microsoft.com/download/DefinitionUpdates/mpam-fex64.exe'
$x64Local = Join-Path $folder 'mpam-fex64.exe'
if (Test-Path $x64Local) { ri -force $x64Local }

$client = New-Object System.Net.WebClient

$x86Url
$client.DownloadFile($x86Url, $x86Local)

$x64Url
$client.DownloadFile($x64Url, $x64Local)


pushd $folder

szip x -y -ox86 .\mpam-fex86.exe

szip x -y -ox64 .\mpam-fex64.exe

ri .\x86\MPSigStub.exe

ri .\x64\MPSigStub.exe

popd