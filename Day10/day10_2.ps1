#Not going to lie, had to look at a lot of threads in the AoC Subreddit to figure out how to do this.

$theinput = New-Object -TypeName System.Collections.ArrayList
$theinput.Add(0) | Out-Null
get-content ./input.txt | ForEach-Object {$theinput.Add([int]$_) | Out-Null}
$theinput.Add(($theinput | Measure-Object -Maximum).Maximum +3) | Out-Null
$theinput = $theinput | Sort-Object

$starti = 0
$subinputs = @()

for ($i=1; $i -lt $theinput.Count; $i++) {
    $difference = $theinput[$i] - $theinput[$i-1]

    if ($difference -eq 3) {
        $subinputs += New-Object -TypeName psobject -Property @{input=$theinput[$starti..($i-1)]}
        $starti=$i        
    }
}

$count1=0
$count2=0
$count3=0
$count4=0
$count5=0
foreach ($inp in $subinputs) {
    switch ($inp.input.Count) {
        1 {$count1++}
        2 {$count2++}
        3 {$count3++}
        4 {$count4++}
        5 {$count5++}
    }

}


([Math]::Pow(1,$count1))*([Math]::Pow(1,$count2))*([Math]::Pow(2,$count3))*([Math]::Pow(4,$count4))*([Math]::Pow(7,$count5))
