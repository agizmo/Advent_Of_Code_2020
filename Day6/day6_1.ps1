$theinput = get-content ./input.txt -Raw

$sum = 0

$groups = $theinput -split "`n`n"

foreach($group in $groups) {
    $yes_questions = 0
    $question_tracker = @()
    
    $members = $group -split "`n"

    foreach ($member in $members) {
        $questions = $member.ToCharArray()
            foreach ($question in $questions) {
                if ($question_tracker -notcontains $question) {
                    $yes_questions++
                    $question_tracker += $question
                }
            }
    }
    $sum += $yes_questions

}

Write-Host "Sum of counts = $sum"

