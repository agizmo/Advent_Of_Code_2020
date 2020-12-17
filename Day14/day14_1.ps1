$theinput = get-content ./input.txt -Raw
$rgx = [System.Text.RegularExpressions.Regex]('mask.+\n(mem.+\n)+')
$instructions = $rgx.Matches($theinput).value

$rgx_m = [System.Text.RegularExpressions.Regex]('mem\[\d+')
$memory = $rgx_m.Matches($theinput).value | ForEach-Object {[double]($_ -replace "mem\[","")}
$measure = $memory | Measure-Object -Maximum
$max = $measure.Maximum

$memory = [Int64[]]::new($max+1)

foreach ($set in $instructions) {
    $set = $set.Split("`n")
    $mask = $set[0].Replace("mask = ","")
    $mask_array = $mask.ToCharArray()
    $mem = $set | Where-Object {$_ -like "mem*"}
    foreach ($instruction in $mem){
        $address = [Int64]($instruction.Split("[").Split("]"))[1]
        $value = [Int64]$instruction.Split(" = ")[1]
        $b_value = [convert]::ToString($value,2).PadLeft(36,"0").ToCharArray()

        $new_value = "0".PadLeft(36,"0").ToCharArray()
        for ($i=0;$i -lt 36; $i++) {
            if ($mask_array[$i] -eq "X") {
                $new_value[$i] = $b_value[$i]
            } else {
                $new_value[$i] = $mask_array[$i]
            }
        }
        
        $memory[$address] = [Convert]::ToInt64(($new_value -join ""),2)
        
    }

}

$memory | Measure-Object -Sum