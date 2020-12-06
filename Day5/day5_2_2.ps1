$theinput = get-content ./input.txt

$lowest_id = (0b01111111 * 8) + 0b00000111
$highest_id = 0

$found_seats = @()

foreach($pass in $theinput){
    $row = $pass.Substring(0,7)
    $row = $row.Replace("B","1").Replace("F","0")
    $seat = $pass.Substring(7,3)
    $seat = $seat.Replace("R","1").Replace("L","0")

    [int]$rowint = "0b"+$row
    [int]$seatint = "0b"+$seat
    
    [int]$id = ($rowint * 8) + $seatint
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

$allseats = @()
for ($i=$lowest_id; $i -le $highest_id ; $i++) {
    $allseats+= [int]$i
}
Compare-Object $allseats $found_seats
