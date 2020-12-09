$theinput = New-Object -TypeName System.Collections.ArrayList
Get-Content ./sample_input.txt | ForEach-Object {$theinput.Add([double]$_) | Out-Null}

$p_length = 5
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
        $num
        break
    }
    $index++
}
