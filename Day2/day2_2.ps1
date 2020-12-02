$input = Get-Content .\day2_1_input.txt

$count = 0

foreach ($pass in $input){
    $char_counter = 0
    $props = $pass.split(" ")
    $range_lower = $props[0].split("-")[0]
    $range_upper = $props[0].split("-")[1]
    $character = $props[1].substring(0,1)
    $password = $props[2]
    
    #$character_count = ($password.ToCharArray() | Where-Object {$_ -eq $character}).count
    $character_array = $password.ToCharArray()
    if ($character_array[($range_lower-1)] -eq $character){
        $char_counter ++
    }
    if ($character_array[($range_upper-1)] -eq $character){
        $char_counter++
    }

    if ($char_counter -eq 1) {
        $count++
    }

}

Write-Host "There are $count valid passwords"