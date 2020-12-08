$theinput = Get-Content ./input.txt

$instructions = $theinput | ForEach-Object {
    $tmp = ($_).split(" ")
    New-Object -TypeName psobject -Property @{"op"=$tmp[0];"arg"=[int]$tmp[1]}
}
$lines_executed = @()

$accumulator = 0
$line = 0

do {
    $lines_executed += $line
    $instruction = $instructions[$line]
    switch ($instruction.op) {
        "nop" { $line++ }
        "acc" { $accumulator+= $instruction.arg; $line++ }
        "jmp" { $line += $instruction.arg }
    }
    

} until ($lines_executed -contains $line)

Write-Output "The accumulator is $accumulator"