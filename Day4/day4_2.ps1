function Test-Year {
    param(
        $field
    )

    $yeartype = $field.key
    if ($yeartype -eq "byr") {
        $lower = 1920
        $upper = 2002
    } elseif ($yeartype -eq "iyr") {
        $lower = 2010
        $upper = 2020
    } elseif ($yeartype -eq "eyr") {
        $lower = 2020
        $upper = 2030
    }

    $valid = $false
    
    try {
        [int]$year = $field.value
    } catch {
        $valid = $false
        Write-Output $valid
    }

    $length = ($field.value.toCharArray()).count
    
    if ($length -ne 4) {
        $valid = $false
        break;
    }

    if ($year -ge $lower -and $year -le $upper) {
        $valid = $true
    } else {
        $valid = $false
    }

    Write-Output $valid
}

function Test-HGT {
    param (
        $field
    )

    $matcher = "(\d+)(in|cm)"

    $valid = $true

    if ($field.value -match $matcher) {
        if ($matches[2] -eq "cm") {
            if ($matches[1] -ge 150 -and $matches[1] -le 193) {
                #nothing
            } else {
                $valid = $false
            }
        } elseif ($matches[2] -eq "in") {
            if ($matches[1] -ge 59 -and $matches[1] -le 76) {
                #nothing
            } else {
                $valid = $false
            }
        }
    } else {
        $valid = $false
    }

    Write-Output $valid
}

function Test-HCL {
    param (
        $field
    )

    $matcher = "^#[a-f0-9]{6}$"
    $valid = $false
    
    
    if ($field.value -match $matcher) {
        $valid = $true
    } else {
        $valid = $false
    }

    Write-Output $valid
}


function Test-ECL {
    param(
        $field
    )

    $valid = $false

    $valid_colors = @(
    ,"amb"
    ,"blu"
    ,"brn"
    ,"gry"
    ,"grn"
    ,"hzl"
    ,"oth"
    )

    if ($valid_colors -contains $field.value) {
        $valid = $true
    } else {
        $valid = $false
    }

    Write-Output $valid
}

function Test-PID {
    param(
        $field
    )

    $matcher = "^\d{9}$"
    $valid = $false

    if ($field.value -match $matcher) {
        $valid = $true
    } else {
        $valid = $false
    }

    Write-Output $valid

}

$inp = Get-Content .\input.txt -Raw

$required_fields = @(
,"byr"
,"iyr"
,"eyr"
,"hgt"
,"hcl"
,"ecl"
,"pid"
#,"cid"
)

$pp = $inp -split "`n`n"

$valid_pp = 0
$invalid_pp = 0


foreach ($passport in $pp) {
    $fields = @()
    $fields_raw = ($passport -split " ") -split "`n"

    foreach ($field_raw in $fields_raw) {
        $field_keys_values = $field_raw -split ":"
        $field = New-Object -TypeName psobject -Property @{key=$field_keys_values[0];value=$field_keys_values[1]}
        $fields += $field
    }

    $valid = $true

    foreach ($r_field in $required_fields) {
        if ($fields.key -notcontains $r_field) {
            $valid = $false
            break;
        }

    }

    if ($valid -eq $true){
        foreach ($field in $fields) {
            switch ($field.key) {
               "byr" {if (-not (Test-Year -field $field)) {$valid = $false; break;}} 
               "iyr" {if (-not (Test-Year -field $field)) {$valid = $false; break;}}
               "eyr" {if (-not (Test-Year -field $field)) {$valid = $false; break;}}
               "hgt" {if (-not (Test-HGT -field $field)) {$valid = $false; break;}}
               "hcl" {if (-not (Test-HCL -field $field)) {$valid = $false; break;}}
               "ecl" {if (-not (Test-ECL -field $field)) {$valid = $false; break;}}
               "pid" {if (-not (Test-PID -field $field)) {$valid = $false; break;}}
            }
        }
    }

    if ($valid -eq $true) {
        $valid_pp ++
    } else {
        $invalid_pp ++
    }
}

Write-Output "$valid_pp valid passports"


#byr: 1920 - 2002 and 4 digits
#iyr: 2010 - 2020 and 4 digits
#eyr: 2020 - 2030 and 4 digits
#hgt: cm or in, cm 150-193, in 59-76
#hcl: must have # symbol, exactly 6 hex digits
#ecl: must be one of the listed, amb blu brn gry grn hzl oth
#pid: 9 digits including zero padding