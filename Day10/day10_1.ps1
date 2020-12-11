$theinput = New-Object -TypeName System.Collections.ArrayList
$theinput.Add(0) | Out-Null
get-content ./input.txt | ForEach-Object {$theinput.Add([int]$_) | Out-Null}

$theinput.Add(($theinput | Measure-Object -Maximum).Maximum +3)

$theinput = $theinput | Sort-Object

$one_count = 0
$three_count = 0

for ($i=1; $i -lt $theinput.Count; $i++) {
    $difference = $theinput[$i] - $theinput[$i-1]

    if ($difference -eq 1) {
        $one_count++
    } elseif ($difference -eq 3) {
        $three_count++
    }
}

Write-Host "$one_count x $three_count = $($one_count * $three_count)"