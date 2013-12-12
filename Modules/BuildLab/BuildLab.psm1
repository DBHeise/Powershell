. $psScriptRoot\Common.ps1
. $psScriptRoot\Build.ps1
. $psScriptRoot\Publish.ps1
. $psScriptRoot\Test.ps1

function Use-BuildLab {
    Invoke-Build
    Test-Build
    Publish-Build
}