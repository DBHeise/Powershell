param([String] $inputText)

$map = @{
'A'='.-';
'B'='-...';
'C'='-.-.'
'D'='-..';
'E'='.';
'F'='..-.';
'G'='--.';
'H'='....';
'I'='..';
'J'='.---';
'K'='-.-';
'L'='.-..';
'M'='--';
'N'='-.';
'O'='---';
'P'='.--.';
'Q'='--.-';
'R'='.-.';
'S'='...';
'T'='-';
'U'='..-';
'V'='...-';
'W'='.--';
'X'='-..-';
'Y'='-.--';
'Z'='--..';
' '=' ';
}

$outText = $inputText.ToUpperInvariant().ToCharArray() | % {    
   $map[[string]$_] + ' '
}


[System.String]::Join('', $outText)