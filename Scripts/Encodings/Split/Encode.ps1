param([String] $inputText)

function RandomSplit {
   param([String] $inputText,
   [Int32] $numParts)
   $outText = @()
   1..$numParts | % { $outText.Add($inputText) }
   
   $outText | % { 
      
   }
   
   $outText   
}


function LinearSplit {
   param([String] $inputText,
   [Int32] $numParts)
   $outText = @()
   1..$numParts | % { $outText += $inputText }
   1..$inputText.Length | % {
      $idx = $_
      $keeper = 1..$numParts | Get-Random
      1..$numParts | % {
         if ($_ -ne $keeper) {
            $outText[$_][$idx] = ' '
         }
      }
   }
   
   $outText   
}