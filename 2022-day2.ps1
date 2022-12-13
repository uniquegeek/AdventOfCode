#https://adventofcode.com/2022/day/2
#uniquegeek@gmail.com

$infile = "advent02.txt"
$data = Get-Content $infile
#input looks like:
#A Y
#B X
#C Z

#play/object value
#ABC = Rock, Paper, Scissors  (competitor's plays, worth 1, 2, 3)
#XYZ = Rock, Paper, Scissors  (my plays, worth 1, 2, 3)
$them_validplays = "A","B","C"
$me_validplays = "X","Y","Z"
$playtable = @()
$playtable += @([pscustomobject]@{A=1;B=2;C=3;X=1;Y=2;Z=3})

#Win Table - 0 for loss, 3 for tie, 6 for win
#    X Y Z
#A   3 6 0
#B   0 3 6
#C   6 0 3
$wintable = @()
$wintable += @([pscustomobject]@{X=3;Y=6;Z=0})
$wintable += @([pscustomobject]@{X=0;Y=3;Z=6})
$wintable += @([pscustomobject]@{X=6;Y=0;Z=3})

$totalwin = 0

foreach ($d in $data) {
    $currenthand = 0
    $invalid = $false
    [string]$them = $d[0] #first item on line
    [string]$me = $d[2] #third item on line
    write-host $d" " -NoNewline  #show both plays from file
    if (($me_validplays.Contains($me)) -and ($them_validplays.Contains($them))) {
        $playvalue = $playtable[0].$me  #get value of my card
        #lookup their hand, and how my hand compares
        switch ($them) {
            A {$currenthand = $wintable[0].$me}
            B {$currenthand = $wintable[1].$me}
            C {$currenthand = $wintable[2].$me}
        }
        $totalwin = $totalwin + $currenthand + $playvalue
        switch ($currenthand) {
            0 {write-host "Lost!" -ForegroundColor Red}
            3 {write-host "Tie." -ForegroundColor Gray}
            6 {write-host "Win!!!" -ForegroundColor Green}
        }
    } else {  #invalid play
        write-host "Invalid Play!" -BackgroundColor DarkGray
    }  
}
write-host "My score:"$totalwin
