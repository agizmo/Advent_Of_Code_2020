$theinput = get-content ./input.txt

$highest_id = 0

foreach($pass in $theinput){
    $row_lower = 0
    $row_upper = 127
    $seat_lower = 0
    $seat_upper = 7
    $bscode = $pass.ToCharArray()

    for ($i=0; $i -lt $bscode.Count; $i++) {
        $row_index = $i+1
        $seat_index = $i+1-7
        $code = $bscode[$i]
        if ($code -eq "F") {
            $row_upper = $row_upper - (128/([math]::Pow(2, $row_index)))
        } elseif ($code -eq "B"){
            $row_lower = $row_lower + (128/([math]::Pow(2, $row_index)))
        } elseif ($code -eq "L") {
            $seat_upper = $seat_upper - (8/([math]::Pow(2, $seat_index)))
        } elseif ($code -eq "R"){
            $seat_lower = $seat_lower + (8/([math]::Pow(2, $seat_index)))
        }

    }
    
    $id = ($row_lower * 8) + $seat_lower
    if ($id -gt $highest_id) {
        $highest_id = $id
    }

}

Write-Host "Highest ID = $highest_id"