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

    $fields_raw2 = foreach ($field_raw in $fields_raw) {
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
    if ($valid -eq $true) {
        $valid_pp ++
    } else {
        $invalid_pp ++
    }
}

Write-Output "$valid_pp valid passports"