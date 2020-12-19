$theinput = get-content .\input.txt
$theinput = $theinput.Split(",")

$memory = [int[]]::new(2021)

for ($i=1; $i -le $theinput.count; $i++) {
    $memory[$i] = $theinput[$i-1]
}

for ($i = $theinput.Count+1;$i -lt $memory.Count; $i++) {
    
    $last_number = $memory[$i-1]

    $found = $false
    for ($j = $i-2; $j -gt 0; $j--) {
        if ($memory[$j] -eq $last_number) {
            $found = $true
            break
        }
    }
    if ($found) {
        $memory[$i] = $i-1-$j
    } else {
        $memory[$i] = 0
    }
}

$memory[-1]