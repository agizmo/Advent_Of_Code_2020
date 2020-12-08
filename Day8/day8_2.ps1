$theinput = Get-Content ./input.txt

$instructions = $theinput | ForEach-Object {
    $tmp = ($_).split(" ")
    New-Object -TypeName psobject -Property @{"op"=$tmp[0];"arg"=[int]$tmp[1]}
}
$nops_jumps = @()
for ($i=0;$i -le $instructions.Count; $i++){
    if (($instructions[$i].op -eq "jmp") -or ($instructions[$i].op -eq "nop")) {
        $nops_jumps += $i
    }
}

foreach ($thing in $nops_jumps) {
    $accumulator = 0
    $line = 0
    $lines_executed = @()
    $int_to_change = $instructions[$thing]
    switch ($int_to_change.op) {
        "nop" { $instructions[$thing].op = "jmp" }
        "jmp" { $instructions[$thing].op = "nop" }
    }

    



    do {
        $restart = $false
        if ($lines_executed -contains $line) {
            #Write-Output "loop found. restarting test"
            $lines_executed = @()
            $restart = $true
            switch ($int_to_change.op) {
                "nop" { $instructions[$thing].op = "jmp" }
                "jmp" { $instructions[$thing].op = "nop" }
            }
            break
        }
        $script:lines_executed += $line
        $instruction = $instructions[$line]
        switch ($instruction.op) {
            "nop" { $line++ }
            "acc" { $accumulator+= $instruction.arg; $line++ }
            "jmp" { $line += $instruction.arg }
        }

        
        

    } until ($line -eq ($instructions.count))
    
    if ($restart) {
        #nothing
    }  else {
        break
    }
}


Write-Output "The accumulator is $accumulator"