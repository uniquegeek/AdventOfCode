#https://adventofcode.com/2022/day/1
#uniquegeek@gmail.com

$infile = "advent01.txt"
$data = Get-Content $infile

$production = @()
$lines = $data.Count
$linenum = 1
$elfnum = 1
$calories = 0

foreach ($d in $data) {
    if ($d) {
        $calories = $calories + $d
    } else {
        $production += @([pscustomobject]@{Elf=$elfnum;Calories=$calories})
        $elfnum++
        $calories = 0
    }
    if ($linenum -eq $lines) {
        $production += @([pscustomobject]@{Elf=$elfnum;Calories=$calories})
    }
    $linenum++
}

$most = $production | Sort-Object -Property Calories -Descending | Select-Object -First 1
$least = $production | Sort-Object -Property Calories | Select-Object -First 1
write-host "Most Calories Carried: "$most
write-host "Least Calories Carried: "$least

$topThree = $production | Sort-Object -Property Calories -Descending | Select-Object -First 3
$topThreeTotal = 0
foreach ($t in $topThree) {
    $topThreeTotal = $topThreeTotal + $t.calories
}
write-host "Top Three Total Calories: "$topThreeTotal
$topThree
