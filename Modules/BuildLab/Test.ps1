
function Test-Build {
    $RootFolder = "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\"

    if (Test-Path $RootFolder) {
      $UseVSTest = $true
      Set-Alias mstest (Join-Path $RootFolder "mstest.exe")
      Set-Alias vstest (Join-Path $RootFolder "CommonExtensions\Microsoft\TestWindow\vstest.console.exe")
    } else {
      $UseVSTest = $false
      $RootFolder = "C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\"
      Set-Alias mstest (Join-Path $RootFolder "mstest.exe")
    }

    $platform = 'x86'
    $flavor = 'debug'

    $fldr = Resolve-Path '.\TestResults'
    if (Test-Path $fldr) {
       pushd $fldr
       ri * -Force -Recurse
       popd
    } else {
       mkdir $fldr | Out-Null
    }

    gci $BuildRoot\$platform\$flavor\*test.dll | % {
        $assembly = $_.FullName
        if ($UseVSTest) {
          vstest $assembly /EnableCodeCoverage /InIsolation /Logger:trx /TestCaseFilter:"TestCategory=Unit"
        } else {
          $ResultsFile = (Join-Path $LogRoot ($_.Name + '.Results.trx'))
          if (Test-Path $ResultsFile) {
             ri $ResultsFile
          }
          mstest /nologo /TestContainer:$assembly /Category:Unit /ResultsFile:$ResultsFile
        }
    }

}