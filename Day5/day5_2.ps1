$theinput = get-content ./input.txt

$lowest_id = (127*8) + 7
$highest_id = 0

$found_seats = New-Object -TypeName System.Collections.ArrayList

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
    
    [int]$id = ($row_lower * 8) + $seat_lower
    if ($id -gt $highest_id) {
        $highest_id = $id
    }

    if ($id -lt $lowest_id) {
        $lowest_id = $id
    }

    $found_seats += $id

}

$found_seats = $found_seats | Sort-Object

Write-Host "Highest ID = $highest_id"

$allseats = New-Object -TypeName System.Collections.ArrayList
for ($i=$lowest_id; $i -le $highest_id ; $i++) {
    $allseats+= [int]$i
}
Compare-Object $allseats $found_seats
