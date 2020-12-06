$theinput = get-content ./input.txt

$highest_id = 0

foreach($pass in $theinput){
    $row = $pass.Substring(0,7)
    $row = $row.Replace("B","1").Replace("F","0")
    $seat = $pass.Substring(7,3)
    $seat = $seat.Replace("R","1").Replace("L","0")

    [int]$rowint = "0b"+$row
    [int]$seatint = "0b"+$seat
    
    
    $id = ($rowint * 8) + $seatint
    if ($id -gt $highest_id) {
        $highest_id = $id
    }

}

Write-Host "Highest ID = $highest_id"