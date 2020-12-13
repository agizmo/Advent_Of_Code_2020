$theinput = get-content .\input.txt

$direction = New-Object -TypeName psobject -Property @{x=1;y=0}
$location = New-Object -TypeName psobject -Property @{x=0;y=0}

foreach ($inst in $theinput) {
    $action = $inst.substring(0,1)
    [int]$units = $inst.substring(1,$inst.length-1)



    switch ($action) {
        "N" {$location.y = $location.y+$units}
        "S" {$location.y = $location.y-$units}
        "E" {$location.x = $location.x+$units}
        "W" {$location.x = $location.x-$units}
        "L" {
            switch ($units){
                90 {
                    if($direction.x -eq 1 -and $direction.y -eq 0){
                        $direction.x = 0
                        $direction.y = 1
                    } elseif ($direction.x -eq 0 -and $direction.y -eq 1) {
                        $direction.x = -1
                        $direction.y = 0
                    } elseif ($direction.x -eq -1 -and $direction.y -eq 0) {
                        $direction.x = 0
                        $direction.y = -1
                    } elseif ($direction.x -eq 0 -and $direction.y -eq -1) {
                        $direction.x = 1
                        $direction.y = 0
                    }
                }
                180 {
                    if($direction.x -eq 1 -and $direction.y -eq 0){
                        $direction.x = -1
                        $direction.y = 0
                    } elseif ($direction.x -eq 0 -and $direction.y -eq 1) {
                        $direction.x = 0
                        $direction.y = -1
                    } elseif ($direction.x -eq -1 -and $direction.y -eq 0) {
                        $direction.x = 1
                        $direction.y = 0
                    } elseif ($direction.x -eq 0 -and $direction.y -eq -1) {
                        $direction.x = 0
                        $direction.y = 1
                    }
                }
                270 {
                    if($direction.x -eq 1 -and $direction.y -eq 0){
                        $direction.x = 0
                        $direction.y = -1
                    } elseif ($direction.x -eq 0 -and $direction.y -eq 1) {
                        $direction.x = 1
                        $direction.y = 0
                    } elseif ($direction.x -eq -1 -and $direction.y -eq 0) {
                        $direction.x = 0
                        $direction.y = 1
                    } elseif ($direction.x -eq 0 -and $direction.y -eq -1) {
                        $direction.x = -1
                        $direction.y = 0
                    }
                }
            }
        }
        "R" {
            switch ($units){
                270 {
                    if($direction.x -eq 1 -and $direction.y -eq 0){
                        $direction.x = 0
                        $direction.y = 1
                    } elseif ($direction.x -eq 0 -and $direction.y -eq 1) {
                        $direction.x = -1
                        $direction.y = 0
                    } elseif ($direction.x -eq -1 -and $direction.y -eq 0) {
                        $direction.x = 0
                        $direction.y = -1
                    } elseif ($direction.x -eq 0 -and $direction.y -eq -1) {
                        $direction.x = 1
                        $direction.y = 0
                    }
                }
                180 {
                    if($direction.x -eq 1 -and $direction.y -eq 0){
                        $direction.x = -1
                        $direction.y = 0
                    } elseif ($direction.x -eq 0 -and $direction.y -eq 1) {
                        $direction.x = 0
                        $direction.y = -1
                    } elseif ($direction.x -eq -1 -and $direction.y -eq 0) {
                        $direction.x = 1
                        $direction.y = 0
                    } elseif ($direction.x -eq 0 -and $direction.y -eq -1) {
                        $direction.x = 0
                        $direction.y = 1
                    }
                }
                90 {
                    if($direction.x -eq 1 -and $direction.y -eq 0){
                        $direction.x = 0
                        $direction.y = -1
                    } elseif ($direction.x -eq 0 -and $direction.y -eq 1) {
                        $direction.x = 1
                        $direction.y = 0
                    } elseif ($direction.x -eq -1 -and $direction.y -eq 0) {
                        $direction.x = 0
                        $direction.y = 1
                    } elseif ($direction.x -eq 0 -and $direction.y -eq -1) {
                        $direction.x = -1
                        $direction.y = 0
                    }
                }
            }
        }
        "F" {
            $location.x = $location.x + $units*$direction.x
            $location.y = $location.y + $units*$direction.y
        }
    }
}
$location
[math]::Abs($location.x) + [Math]::Abs($location.y)