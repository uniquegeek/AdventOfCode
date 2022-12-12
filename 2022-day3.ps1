#https://adventofcode.com/2022/day/3
#uniquegeek@gmail.com
$infile = "advent03.txt"
$data = Get-Content $infile

#use ASCIItable with conversion rate to get value of alphabetic characters
$lowerConvert = 96  #'a' is ascii 97, but we want a value of 1.
$upperConvert = 38  #'A' is ascii 65, but we want a value of 27.

[array]$sack = @()

foreach ($d in $data) {
    $length = $d.Length
    $half = $length/2
    #split sack into two halves
    $first = $d.Substring(0,$half)
    $second = $d.Substring($half)
    $sack += @([pscustomobject]@{Compartment1=$first;Compartment2=$second})
}

#Find the duplicates (that are in both sacks)
#but no need to track the duplicates that are in each sack.
#***(You would think we might want to know how many duplicates and the value of all of them, but that is not what is asked)
$dupes = @()
$sacknum = 1
$totalValue = 0

foreach ($s in $sack) {
    #$s = $sack[0] # for testing
    $uniqueItems1 = $s.Compartment1
    $uniqueItems2 = $s.Compartment2
    $uniqueItems1 = -join ($uniqueItems1.ToCharArray() | Sort-Object -Unique)  #remove dupes and sort
    $uniqueItems2 = -join ($uniqueItems2.ToCharArray() | Sort-Object -Unique)  #remove dupes and sort
    $length = [int]($uniqueItems1.length)
    for ($i = 0;($i -lt $length);$i++) {
        [string]$searchItem = ($uniqueItems1).substring($i,1)
        [string]$secondbag = $uniqueItems2
        if ($secondbag.Contains($searchItem)){
            $v = [byte][char]$searchItem  #get ASCII value
            if (($v -ge 97) -and ($v -le 122)) {  #lowercase alphachar
                $v = $v - $lowerConvert
            } else {
                $v = $v - $upperConvert
            }
            $dupes += @([pscustomobject]@{Sack=$sacknum;Item=$searchItem;Value=$v})
            $totalValue = $totalValue + $v
        }
    }
    $sacknum++
}

write-host "===================="
write-host "===================="
write-host "Total Value: "$totalValue
write-host "===================="
$dupes

#Example Input:
#vJrwpWtwJgWrhcsFMMfFFhFp   - rucksack 1, 1st half, 2nd half; "p" appears in both halves
#jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
#PmmdzqPrVvPwwTWBwg
#wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
#ttgJtRGJQctTZtZT
#CrZsJsPPZsGzwwsLwLmpwMDw


#Compartment1      Compartment2
#------------      ------------
#vJrwpWtwJgWr      hcsFMMfFFhFp      #should find p
#jqHRNqRjqzjGDLGL  rsFMfFZSrLrFZsSL  #should find L

#Sack: 1,Item:p
#Sack: 2,Item:L
#Sack: 3,Item:P
#Sack: 4,Item:v
#Sack: 5,Item:t
#Sack: 6,Item:s


#Things that helped:

#We could make a lookup table custom object where a = 1, b=2... and A=27, B=28...
#  but we already have integer values for characters in the form of ASCII codes.
#So just figure out our "conversion rate"

#PS C:\users\kscrupa\Documents\scripts\AdventCode2022> [byte][char]'a'
#97
#PS C:\users\kscrupa\Documents\scripts\AdventCode2022> [byte][char]'A'
#65

#lowercase: charcode -96  (97 + (-96) = 1)
#uppercase: charcode -38  (65 + (-38) = 27)

#Also
#https://stackoverflow.com/questions/12738121/powershell-convert-char-array-to-string
