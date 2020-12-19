$theinput = get-content ./input.txt

$rules = New-Object -TypeName System.Collections.ArrayList
for($i=0;$i -lt $theinput.count; $i++) {
    if ($theinput[$i] -like "*your ticket:*") {
        $myticket = [int[]]$theinput[$i+1].Split(",")
        $i++
    } elseif ($theinput[$i] -like "nearby tickets:*") {
        $nearby_tickets = New-Object -TypeName System.Collections.ArrayList
        for ($j=$i+1; $j -lt $theinput.count; $j++) {
            $nearby_tickets.Add([int[]]$theinput[$j].Split(",")) | Out-Null
        }
        break;
    } elseif ($theinput[$i] -like "*:*") {
        $pieces = $theinput[$i].split(": ")
        $ranges = $pieces[1].Split(" or ").Split("-")

        $rule = [PSCustomObject]@{
            rule = $pieces[0].Trim()
            ranges = @([PSCustomObject]@{low = $ranges[0];high=$ranges[1]},[PSCustomObject]@{low = $ranges[2];high=$ranges[3]})
        }
        $rules.Add( $rule) | Out-Null
    }


}

$numbers = New-Object -TypeName System.Collections.ArrayList
foreach ($ticket in $nearby_tickets) {
    foreach ($number in $ticket) {
        $found = $false
        foreach ($range in $rules.ranges) {
            if ($number -ge $range.low -and $number -le $range.high) {
                $found = $true
                break;
            }
        }
        if (-not $found) {
            $numbers.Add($number) | Out-Null
        }
    }
}

$numbers | Measure-Object -Sum