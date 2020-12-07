$theinput = Get-Content ./input.txt

$my_bag = "shiny_gold"


function Find-OuterBag {
    param (
        $color,
        $rules
    )
    
    ForEach ($rule in $rules) {
        if ($rule.bags.color -contains $color) {
            write-output $rule
            Find-OuterBag -color $rule.color -rules $rules
        }
    }
    
}

function Find-InnerBag {
    param (
        $color,
        $rules
    )
    
    $count = 0
    $color_rule = $rules | Where-Object color -eq $color

    foreach ($bag in $color_rule.bags){
        $count += $bag.count
        $ibag_count = Find-InnerBag -color $bag.color -rules $rules
        $ibag_count = $ibag_count * $bag.count
        $count += $ibag_count
    }
    Write-Output $count
}

$rules = @()
foreach ($rule in $theinput) {
    $tmp = $rule.split("bags contain")

    $inner_bags = @()
    $outer_bag = $tmp[0].trim().replace(" ","_")
    $ibags = $tmp[1].split(",").Trim()
        foreach ($bag in $ibags) {
            if ($bag -like "*no other bags*") {
                
            } else {
                $in_bag = $bag.trim().split(" ")
                $inner_bags += New-Object -TypeName psobject -Property @{"color"=($in_bag[1]+"_"+$in_bag[2]);count=$in_bag[0]}
            }
    }

    $rules += New-Object -TypeName psobject -Property @{color=$outer_bag;bags=$inner_bags}
}

#$test = Find-OuterBag -color $my_bag -rules $rules
#$bags = $test.color | Sort-Object -Property $color -Unique


$count = Find-InnerBag -color $my_bag -rules $rules

Write-Output "My $my_bag needs to contain $count bags."