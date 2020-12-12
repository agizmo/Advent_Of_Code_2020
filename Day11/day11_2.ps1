$theinput = get-content ./input.txt

function Get-SurroundingSeats {
    param (
        $row,
        $column,
        $r_count,
        $c_count
    )
    
    #diagonal up left
    $pos_r = $row-1
    $pos_c = $column-1
    do{    
        if ($pos_r -lt 0 -or $pos_c -lt 0){
            break
        }
        if ("#","L" -contains $seats[$pos_r][$pos_c]){
            New-Object -TypeName psobject -property @{row=$pos_r;column=$pos_c;seat=$seats[$pos_r][$pos_c]}
            break
        }
        $pos_r--
        $pos_c--
    } until ($false)
        
    #up
    $pos_r = $row-1
    $pos_c = $column
    do{    
        if ($pos_r -lt 0){
            break
        }
        if ("#","L" -contains $seats[$pos_r][$pos_c]){
            New-Object -TypeName psobject -property @{row=$pos_r;column=$pos_c;seat=$seats[$pos_r][$pos_c]}
            break
        }
        $pos_r--
    } until ($false)
    
    #diagonal down right
    $pos_r = $row+1
    $pos_c = $column+1
    do{    
        if ($pos_r -ge $r_count -or $pos_c -ge $c_count){
            break
        }
        if ("#","L" -contains $seats[$pos_r][$pos_c]){
            New-Object -TypeName psobject -property @{row=$pos_r;column=$pos_c;seat=$seats[$pos_r][$pos_c]}
            break
        }
        $pos_r++
        $pos_c++
    } until ($false)
    
    #right
    $pos_r = $row
    $pos_c = $column+1
    do{    
        if ($pos_c -ge $c_count){
            break
        }
        if ("#","L" -contains $seats[$pos_r][$pos_c]){
            New-Object -TypeName psobject -property @{row=$pos_r;column=$pos_c;seat=$seats[$pos_r][$pos_c]}
            break
        }
        $pos_c++
    } until ($false)
    
    #diagonal up right
    $pos_r = $row-1
    $pos_c = $column+1
    do{    
        if ($pos_r -lt 0 -or $pos_c -ge $c_count){
            break
        }
        if ("#","L" -contains $seats[$pos_r][$pos_c]){
            New-Object -TypeName psobject -property @{row=$pos_r;column=$pos_c;seat=$seats[$pos_r][$pos_c]}
            break
        }
        $pos_r--
        $pos_c++
    } until ($false)
    
    #down
    $pos_r = $row+1
    $pos_c = $column
    do{    
        if ($pos_r -ge $r_count){
            break
        }
        if ("#","L" -contains $seats[$pos_r][$pos_c]){
            New-Object -TypeName psobject -property @{row=$pos_r;column=$pos_c;seat=$seats[$pos_r][$pos_c]}
            break
        }
        $pos_r++
    } until ($false)
    
    #diagonal down left
    $pos_r = $row+1
    $pos_c = $column-1
    do{    
        if ($pos_r -ge $r_count -or $pos_c -lt 0){
            break
        }
        if ("#","L" -contains $seats[$pos_r][$pos_c]){
            New-Object -TypeName psobject -property @{row=$pos_r;column=$pos_c;seat=$seats[$pos_r][$pos_c]}
            break
        }
        $pos_r++
        $pos_c--
    } until ($false)
    
    #left
    $pos_r = $row
    $pos_c = $column-1
    do{    
        if ($pos_c -lt 0){
            break
        }
        if ("#","L" -contains $seats[$pos_r][$pos_c]){
            New-Object -TypeName psobject -property @{row=$pos_r;column=$pos_c;seat=$seats[$pos_r][$pos_c]}
            break
        }
        $pos_c--
    } until ($false)

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
                    if ($occupied.count -ge 5) {
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
    
    #foreach ($row in $seats) {$row -join ""}

} until($occupied_seats -eq $newoccupiedseats)

$occupied_seats