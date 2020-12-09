$theinput = New-Object -TypeName System.Collections.ArrayList
Get-Content ./input.txt | ForEach-Object {$theinput.Add([double]$_) | out-null}

$p_length = 25
$index = 0

function Test-Match {
    param (
        $number,
        $start,
        $length
    )

    for ($i=$start;$i -lt ($start+$length); $i++) {
        for ($j = $start; $j -lt ($start+$length); $j++) {
            if ($i -eq $j){
                #skip
            } else {
                $sum = $theinput[$i]+$theinput[$j]
                if($number -eq $sum) {
                    return $true
                }
            }
        }
    }
    return $false

}

foreach ($num in $theinput[$p_length..($theinput.count -1)]){
    if (-not (Test-Match -number $num -start $index -length $p_length)) {
        $invalid_number = $num
        break
    }
    $index++
}

Write-Host "$invalid_number is invalid"

for ($i=0; $i -lt $theinput.Count; $i++) {
    $offset = 0
    do {
        $offset++
        $sum = ($theinput[$i..($i+$offset)] | Measure-Object -Sum).Sum
        
        if ($sum -gt $invalid_number){
            break
        }
        
    } until ($sum -eq $invalid_number)
    
    if ($sum -eq $invalid_number) {
        $numbers = $theinput[$i..($i+$offset)] | Measure-Object -Minimum -Maximum

        Write-Host "Index: $i, Offset: $offset"
        Write-Host "Min: $($numbers.Minimum), Max: $($numbers.Maximum)"
        Write-Host "Sum: $($numbers.Minimum + $numbers.Maximum)"
        break;
    }
    
}
