$theinput = get-content ./input.txt

$time = $theinput[0]
$buses = $theinput[1].split(",")

$order = @()
for ($i = 0; $i -lt $buses.Count; $i++) {
    if ($buses[$i] -ne "x") {
        $order += New-Object -TypeName psobject -Property @{bus=[int]$buses[$i];start=[int]$i}
    }
}

$time2 = 0
$step = 1
foreach ($thing in $order) {
    do {
        $time2 += $step
    } while (($time2 + $thing.start) % $thing.bus)
    $step *= $thing.bus
}

Write-Host "time: $time2"