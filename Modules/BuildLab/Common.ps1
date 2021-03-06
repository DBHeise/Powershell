
$DevRoot = Join-Path (Get-WmiObject Win32_logicaldisk | ? {$_.VolumeName -eq 'BIGG'}).DeviceId 'dev'
$BuildRoot = Join-Path $DevRoot 'bin'
$PublishRoot = Join-Path $env:SystemDrive 'RoboDave'
$LogRoot = Join-Path $BuildRoot 'Logs'

if (Test-Path variable:LibDir) {
    $LibRoot = $LibDir
} else {
    $LibRoot = Resolve-Path (Join-Path $env:ScriptDir '..\Lib')
}
