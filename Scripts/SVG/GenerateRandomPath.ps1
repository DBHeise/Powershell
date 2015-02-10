param ([String] $OutFile)
Add-Type -Assembly System.Drawing

$Width = 2048
$Height = 2048
$numPoints = 1000
$wiggle = 3
$numPaths = 1

#High NumPoints will lead to very wiggly lines which look more like rivers
#Low NumPoints tends to look more like a path or road


$BaseSVG = @"
<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
   <style type="text/css"><![CDATA[
    .road {stroke:#9c9b9a;stroke-linecap:round;stroke-width:2;fill:none;}
    .water {stroke-linecap:round;stroke:#005cd1;stroke-width:5;fill:none}
   ]]></style>    
   [PATH]
</svg>
"@

function RandomBool {
   return ($true,$false | Get-Random)
}

function RandomWiggle {
    if ($wiggle -gt 0) {
        return Get-Random -Minimum -$wiggle -Maximum $wiggle
    } else {
        return 0;
    }
}

function GetEdgePoint {
    $p = New-Object System.Drawing.PointF (0,$Width | Get-Random),(0,$Height | Get-Random)
    if (RandomBool) {
        if (RandomBool) {
            $p.Y = Get-Random -Maximum $Width    
        } else {    
            $p.X = Get-Random -Maximum $Height
        }
    } elseif (RandomBool) {
        $p.Y = Get-Random -Maximum $Width    
    } else {    
        $p.X = Get-Random -Maximum $Height
    }
    return $p
}

function GetMidPoint {
    param([System.Drawing.Point] $start, [System.Drawing.Point] $end)
    
    $x = ($start.X + $end.Y) / 2;
    $y = ($start.Y + $end.Y) / 2;

    return New-Object System.Drawing.Point $x,$y
}

function GetWigglyPathFromPoints {
    param([System.Drawing.PointF] $start, [System.Drawing.pointF] $end)
    $points = @()

    if ($end.X -eq $start.X) { $end.X = [Math]::Abs($start.X - $Height) }
    if ($end.Y -eq $start.Y) { $end.Y = [Math]::Abs($start.Y - $Width) }

    $path = "m" + $start.X + "," + $start.Y

    $d = New-Object System.Drawing.PointF (($end.X - $start.X) / ($numPoints - 2)),(($end.Y - $start.Y) / ($numPoints - 2))
    
    while ($points.Count -lt ($numPoints - 1)) {    
        $p = New-Object System.Drawing.PointF $d.X,$d.Y
        $p.X += RandomWiggle
        $p.Y += RandomWiggle
        $points += $p
    }

    $points | % {
        $p = $_
        $X1 = RandomWiggle
        $Y1 = RandomWiggle
        $path += " s" + $X1 + "," + $Y1 + " " + $p.X + "," + $p.Y
    }
    
    $c = "road","road","road","road","road","road","road","road","road","water" | Get-Random     
    $c = "water"
    $path = '<path class="' + $c + '" d="' + $path + '"/>'
    return $path
}

function GetWigglyPath {
    #Generate Staring Point
    $start = GetEdgePoint
    $end = GetEdgePoint
    return GetWigglyPathFromPoints $start $end
}

function GetWigglyPathSVG {
}

$svg = $BaseSVG

if ($numPaths -gt 1) {
    1..($numPaths - 1) | % { 
        $p = GetWigglyPath
        $svg = $svg.Replace("[PATH]", $p + "[PATH]") 
    }
}
$p = GetWigglyPath
$svg = $svg.Replace("[PATH]", $p) 


$svg | Set-Content $OutFile
