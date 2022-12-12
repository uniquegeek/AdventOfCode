#https://adventofcode.com/2022/day/1
#uniquegeek@gmail.com
$infile = "advent01.txt"
$data = Get-Content $infile

$production = @()
$lines = $data.Count
[int]$linenum = "1"
[int]$elfnum = "1"
[int]$calories = "0"

foreach ($d in $data) {
    if ($d) {
        $calories = $calories + [int]$d
    } else {
        $production += @([pscustomobject]@{Elf=$elfnum;Calories=$calories})
        $elfnum++
    }
    if ($linenum -eq $lines) {
        $production += @([pscustomobject]@{Elf=$elfnum;Calories=$calories})
    }
    $linenum++
}
write-host "Most Calories Carried:"
$production | Sort-Object -Property Calories -Descending | Select-Object -First 1
