$theinput = get-content ./input.txt

$time = $theinput[0]
$buses = $theinput[1].split(",") | Where-Object {$_ -ne "x"}

$s_diff = New-Object -TypeName psobject -Property @{bus=0;diff=999}
foreach ($bus in $buses){
    $diff = [math]::IEEERemainder($time,$bus)
    if ($diff -le 0 -and [math]::Abs($diff) -lt $s_diff.diff){
        $s_diff.bus = [int]$bus
        $s_diff.diff = [math]::Abs($diff)
    }
}

Write-Host "Bus: $($s_diff.bus)"
Write-Host "Difference: $($s_diff.diff)"
Write-Host "Answer: $($s_diff.bus * $s_diff.diff)"