$slope = Get-Content .\input_1.txt

$width = $slope[0].ToCharArray().Count

$position = New-Object -TypeName psobject -ArgumentList @{x=0;y=0}
$offset = 0
$alltrees = 1

$routes = @()
$routes += New-Object -TypeName psobject -ArgumentList @{right=1;down=1}
$routes += New-Object -TypeName psobject -ArgumentList @{right=3;down=1}
$routes += New-Object -TypeName psobject -ArgumentList @{right=5;down=1}
$routes += New-Object -TypeName psobject -ArgumentList @{right=7;down=1}
$routes += New-Object -TypeName psobject -ArgumentList @{right=1;down=2}

foreach ($route in $routes) {
    $trees = 0
    $position.x = 0
    $position.y = 0
    $right = $route.right
    $down = $route.down

    do {
        $line = $slope[$position.y]

        $look = $line.ToCharArray()
        if ($look[$position.x] -eq "#"){
            $trees ++
        }
        $position.x += $right
        if ($position.x -gt $width-1) {
            $offset += $width
            $position.x -= $width
        }
    
        $position.y += $down

    } until ($position.y -ge $slope.count)
    
    Write-Host "Trees $trees"
    $alltrees *= $trees
}

Write-Host "AllTrees $alltrees"