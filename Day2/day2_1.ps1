$input = Get-Content .\day2_1_input.txt

$count = 0

foreach ($pass in $input){
    $props = $pass.split(" ")
    $range_lower = $props[0].split("-")[0]
    $range_upper = $props[0].split("-")[1]
    $character = $props[1].substring(0,1)
    $password = $props[2]
    
    $character_count = ($password.ToCharArray() | Where-Object {$_ -eq $character}).count
    if ($character_count -ge $range_lower -and $character_count -le $range_upper){
        $count ++
    }

}

Write-Host "There are $count valid passwords"