$theinput = get-content ./input.txt

function Get-SurroundingSeats {
    param (
        $row,
        $column,
        $r_count,
        $c_count
    )
    
    if ($row -eq 0 ){
        $r_get = $row,($row+1)
    } elseif ($row -eq $r_count-1) {
        $r_get = ($row-1),$row
    } else {
        $r_get = ($row-1),$row,($row+1)
    }
    if ($column -eq 0) {
        $c_get = $column,($column+1)
    } elseif ($column -eq $c_count-1) {
        $c_get = ($column-1),$column
    } else {
        $c_get = ($column-1),$column,($column+1)
    }
    foreach ($i in $r_get) {
        foreach ($j in $c_get) {
            if (-not(($i -eq $row) -and ($j -eq $column))) {
                try {
                    New-Object -TypeName psobject -property @{row=$i;column=$j;seat=$seats[$i][$j]} -ErrorAction Stop
                } catch {
                    "test"   
                }
            }
        }
    }

}

$seats = New-Object -TypeName System.Collections.ArrayList
foreach($row in $theinput) {
    $seats.Add($row.ToCharArray()) | out-Null
}

$occupied_seats = 0
$loop=0
do {
    $loop++
    #$loop
    $temp_seats = [Management.Automation.PSSerializer]::DeSerialize([Management.Automation.PSSerializer]::Serialize($seats))
    $occupied_seats = $newoccupiedseats
    $newoccupiedseats = 0
    for ($row = 0; $row -lt $seats.count; $row++) {
        for ($column = 0; $column -lt $seats[$row].count; $column++) {
            if ($seats[$row][$column] -ne ".") {
                $stuff = Get-SurroundingSeats -row $row -column $column -r_count $seats.count -c_count $seats[$row].count
            }
            
            switch ($seats[$row][$column]) {
                "L" {if ($stuff.seat -notcontains "#") {
                        $temp_seats[$row][$column] = "#"
                    }
                }
                "#" {$occupied = $stuff.seat | where-object {$_ -eq "#"}
                    if ($occupied.count -ge 4) {
                        $temp_seats[$row][$column] = "L"
                    }
                }
            }
        }
    }
    foreach ($row in $temp_seats) {
        foreach ($seat in $row) {
            if ($seat -eq "#") {
                $newoccupiedseats++
            }
        }
    }
    

    $seats = [Management.Automation.PSSerializer]::DeSerialize([Management.Automation.PSSerializer]::Serialize($temp_seats))
    
    #foreach ($row in $temp_seats) {$row -join ""}

} until($occupied_seats -eq $newoccupiedseats)

$occupied_seats