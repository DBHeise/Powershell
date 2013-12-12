

function Invoke-BuildFull {
  param($proj)
  Invoke-BuildItem -config 'release'  -plat 'x86' -proj $proj
  Invoke-BuildItem -config 'debug'    -plat 'x86' -proj $proj
  Invoke-BuildItem -config 'release'  -plat 'x64' -proj $proj
  Invoke-BuildItem -config 'debug'    -plat 'x64' -proj $proj
}

function Invoke-BuildItem{
  param($config, $plat, $proj)   
   
  $activity = 'Building  - ' + $config + ' - ' + $plat
  $status = $proj
  $projName = (Split-Path $proj -Leaf).Split('.')[0]
  $LogRootFile = Join-Path $LogRoot ($projName + "." + $config + "." + $plat )

  $LogFull = $LogRootFile + ".log"
  $LogError = $LogRootFile + ".err"
  $LogWarn = $LogRootFile + ".wrn"

  #$OutDir = Join-Path (Join-Path (Join-Path $BuildRoot $plat) $config) $projName
  #$OutDir = Join-Path (Join-Path $BuildRoot $plat) $config
  $keyFile = "D:\Certs\Key.snk"

  Write-Progress -Activity $activity -Status $status
  msbuild $proj "/nologo" "/p:Configuration=$config" "/p:Platform=$plat" "/MaxCpuCount" "/ConsoleLoggerParameters:ErrorsOnly;NoSummary;ShowTimeStamp;EnableMPLogging" "/FileLogger1" "/flp1:warningsonly;logfile=$LogWarn" "/FileLogger2" "/flp2:errorsonly;logfile=$LogError" "/FileLogger3" "/flp3:Verbosity=Detailed;LogFile=$LogFull" 
  #"/p:OutDir=$OutDir\" 
  #"/p:SignAssembly=true" "/p:AssemblyOriginatorKeyFile=$keyFile"  
  Write-Progress -Activity $activity -Status $status -Complete
}

function Invoke-Build {
    param([switch] $All)
    if (!(Test-Path $BuildRoot)) { mkdir $BuildRoot | Out-Null}
    if (!(Test-Path $LogRoot)) { mkdir $LogRoot | Out-Null}

    $BuildFile = Join-Path $DevRoot 'Projects.proj'
    if ($All) {
        Invoke-BuildFull $BuildFile
    } else {
        Invoke-BuildItem -config 'debug' -plat 'x86' -proj $BuildFile
    }
}