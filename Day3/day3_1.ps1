$slope = Get-Content .\input_1.txt

$width = $slope[0].ToCharArray().Count

$position = New-Object -TypeName psobject -ArgumentList @{x=0;y=1}
$offset = 0
$trees = 0

$down = 1
$right = 3

foreach ($line in $slope) {
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
}

Write-Host "Trees $trees"