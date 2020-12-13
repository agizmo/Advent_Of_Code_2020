$theinput = get-content .\input.txt


$location = New-Object -TypeName psobject -Property @{x=0;y=0}
$waypoint = New-Object -TypeName psobject -Property @{x=10;y=1}

foreach ($inst in $theinput) {
    $action = $inst.substring(0,1)
    [int]$units = $inst.substring(1,$inst.length-1)

    switch ($action) {
        "N" {$waypoint.y += $units}
        "S" {$waypoint.y -= $units}
        "E" {$waypoint.x += $units}
        "W" {$waypoint.x -= $units}
        "L" {
            switch ($units){
                90 {                    
                    $tmp_x = $waypoint.x
                    $waypoint.x = $waypoint.y*-1
                    $waypoint.y = $tmp_x
                }
                180 {
                    $waypoint.x = $waypoint.x*-1
                    $waypoint.y = $waypoint.y*-1
                    
                }
                270 {
                    $tmp_x = $waypoint.x
                    $waypoint.x = $waypoint.y
                    $waypoint.y = $tmp_x*-1
                    
                }
            }
        }
        "R" {
            switch ($units){
                270 {                    
                    $tmp_x = $waypoint.x
                    $waypoint.x = $waypoint.y*-1
                    $waypoint.y = $tmp_x
                }
                180 {
                    $waypoint.x = $waypoint.x*-1
                    $waypoint.y = $waypoint.y*-1
                    
                }
                90 {
                    $tmp_x = $waypoint.x
                    $waypoint.x = $waypoint.y
                    $waypoint.y = $tmp_x*-1
                    
                }
            }
        }
        "F" {
            $location.x += $waypoint.x*$units
            $location.y += $waypoint.y*$units
        }
    }
}
$location
[math]::Abs($location.x) + [Math]::Abs($location.y)