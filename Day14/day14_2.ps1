$theinput = get-content ./input.txt -Raw
$rgx = [System.Text.RegularExpressions.Regex]('mask.+\n(mem.+\n)+')
$instructions = $rgx.Matches($theinput).value

$rgx_m = [System.Text.RegularExpressions.Regex]('mem\[\d+')
$memory = $rgx_m.Matches($theinput).value | ForEach-Object {[double]($_ -replace "mem\[","")}
$measure = $memory | Measure-Object -Maximum
$max = $measure.Maximum

$memory = New-Object -TypeName System.Collections.ArrayList

foreach ($set in $instructions) {
    $set = $set.Split("`n")
    $mask = $set[0].Replace("mask = ","")
    $mask_array = $mask.ToCharArray()
    
    
    
    $mem = $set | Where-Object {$_ -like "mem*"}
    foreach ($instruction in $mem){
        $address = [Int64]($instruction.Split("[").Split("]"))[1]
        $b_address = [convert]::ToString($address,2).PadLeft(36,"0").ToCharArray()
        $value = [Int64]$instruction.Split(" = ")[1]
        #$b_value = [convert]::ToString($value,2).PadLeft(36,"0").ToCharArray()

        $x_count = ($mask_array -match "X").count
        $x_locations = @()
        $combinations = [math]::Pow(2,$x_count)

        $new_mask = "0".PadLeft(36,"0").ToCharArray()
        for ($i=0;$i -lt 36; $i++) {
            if ($mask_array[$i] -eq "X") {
                $new_mask[$i] = "X"
                $x_locations += $i
            } elseif ($mask_array[$i] -eq "1") {
                $new_mask[$i] = "1"
            } elseif ($mask_array[$i] -eq "0") {
                $new_mask[$i] = $b_address[$i]
            }
        }
        
        
        

        
        $addresses = @()
        for ($i=0;$i -lt $combinations;$i++) {
            $temp_mask = [Management.Automation.PSSerializer]::DeSerialize([Management.Automation.PSSerializer]::Serialize($new_mask))
            $binary = [convert]::ToString($i,2).PadLeft($x_count,"0").ToCharArray()
            for ($j=0;$j -lt $binary.count; $j++) {
                $temp_mask[($x_locations[$j])] = $binary[$j]
            }   
            
            $addresses+= [Convert]::ToInt64(($temp_mask -join ""),2)

            
        }

        foreach ($n_address in $addresses) {
            if ($memory.address -contains $n_address) {
                $memory | Where address -eq $n_address | ForEach-Object {$_.value = $value}
            } else {
                $memory.Add([PSCustomObject]@{address = $n_address;value = $value}) | Out-Null
            }
        }
        
    }

}

$memory.value | Measure-Object -Sum
Get-Date