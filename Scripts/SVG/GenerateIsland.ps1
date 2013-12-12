
function NewPoint {
    return New-Object PSObject -Property @{
        X = 0
        Y = 0
    }
}

function NewRectangle {
    return New-Object PSObject -Property @{
        SvgClass = 'grid'
        One = NewPoint
        Two = NewPoint
        Three = NewPoint
        Four = NewPoint
    }
}


$Max.X = 512
$Max.Y  = 512

$NumGrid = 10

$SpacingFactor = NewPoint
$SpacingFactor.X = $Max.X / $NumGrid
$SpacingFactor.Y = $Max.Y / $NumGrid

$WiggleFactor = NewPoint
$WiggleFactor.X = $SpacingFactor.X / 4
$WiggleFactor.Y = $SpacingFactor.Y / 4

$points = New-Object 'object[,]' $NumGrid,$NumGrid

$x = 0..$NumGrid | % { [Math]::Round($_ * $SpacingFactor.X, 1) }
$y = 0..$NumGrid | % { [Math]::Round($_ * $SpacingFactor.Y, 1) }


0..$x.Length | % {
    $iX = $_
    $CurrentX = $x[$iX]
    if ($CurrentX -ne $Max.X) {
        0..$y.Length | % {
            $iY = $_
            $CurrentY = $y[$iY]
            if ($CurrentY -ne $Max.Y) {
                $points[$iX, $iY] = NewPoint
                $points[$iX, $iY].X = $CurrentX
                $points[$iX, $iY].Y = $CurrentY
            }
        }
    }
}


$Rectangles = 0..$x.Length | % {
    $iX = $_
    $CurrentX = $x[$iX]
    if ($CurrentX -ne $Max.X) {
        0..$y.Length | % {
            $iY = $_
            $CurrentY = $y[$iY]
            if ($CurrentY -ne $Max.Y) {
                $one = [string]$CurrentX + "," + $CurrentY
                $two = [string]$CurrentX + "," + $y[$iY+1]
                $three = [string]$x[$iX+1] + "," + $CurrentY
                $four = [string]$x[$iX+1] + "," + $y[$iY+1]

                '<path class="grid" d="M' + $one + 'L' + $two + "," + $four + ',' + $three + 'z" />'
            }
        }
    }
}

$startIdx = Get-Random -Minimum 0 -Maximum ($Rectangles.Length -1)

$Rectangles[$startIdx] = $Rectangles[$startIdx].Replace("grid","forest")


$svg  = @"
<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
   <style type="text/css"><![CDATA[    
    .forest {fill:#3d9e48;stroke:none;}
    .grid {stroke:#000;stroke-linecap:round;stroke-width:0.2;fill:none;}
   ]]></style>    
   $Rectangles
</svg>
"@

$svg | Set-Content c:\temp\test.svg