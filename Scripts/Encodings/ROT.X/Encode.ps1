param([String] $inputText, [int] $rot = 13)

$map = [String]::Join('', (65..90 | % { [char] $_}))

$outText = $inputText.ToCharArray() | % {    
   $idx = $map.IndexOf([Char]::ToUpper($_));
   if ($idx -lt 0) {
      $_
   } else {
      $idx = ($idx + $rot) % $map.length
      if ([Char]::IsLower($_)) {
         [Char]::ToLower($map[$idx])
      } else {
         $map[$idx]
      }
   }
}


[System.String]::Join('', $outText)