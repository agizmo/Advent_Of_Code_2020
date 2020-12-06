$theinput = get-content ./input.txt -Raw
#there is a trailing new-line at the end of the input. That throws off the last group.
$theinput = $theinput.Trim()

$sum = 0

$groups = $theinput -split "`n`n"


foreach($group in $groups) {
    $question_tracker = New-Object -TypeName System.Collections.ArrayList
    $remove_list = New-Object -TypeName System.Collections.ArrayList

    $members = $group -split "`n"

    $members[0].ToCharArray() | ForEach-Object {$question_tracker.add($_) | Out-Null}
    $question_tracker.Sort()
    foreach ($member in $members) {
        $questions = $member.ToCharArray()
            foreach ($question in $questions) {
                if ($question_tracker -notcontains $question) {
                    $remove_list.add($question) | Out-Null
                }
            }
            foreach ($question in $question_tracker) {
                if ($questions -notcontains $question) {
                    $remove_list.add($question) | Out-Null
                }
            }
    }
    
    $remove_list = ($remove_list | Sort-Object -Unique)
    foreach ($question in $remove_list) {
        $question_tracker.Remove($question)
    }
    $sum += $question_tracker.count

}

Write-Host "Sum of counts = $sum"

