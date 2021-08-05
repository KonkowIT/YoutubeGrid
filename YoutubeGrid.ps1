# ROWS NUMBER
$gridRows = 3

# COLUMNS NUMBER
$gridColumns = 3

# YT VIDEO ID'S FROM YT LINK
# eg. LINK: https://www.youtube.com/watch?v=abcde12345 ID: abcde12345

$ytLinks = @(
    "abcde12345",
    "abcde12345",
    "abcde12345",
    "abcde12345",
    "abcde12345",
    "abcde12345",
    "abcde12345",
    "abcde12345",
    "abcde12345"
)

# --------------------------------------------------------------------------

$vc = Get-WmiObject -Class Win32_VideoController
$v = $vc.CurrentVerticalResolution
$h = $vc.CurrentHorizontalResolution
$posX = 0
$posY = 0
$verse = 0

$cellV = $h / $gridColumns
$cellH = $v / $gridRows

for ($i = 0; $i -lt $ytLinks.count; $i++) {
    if ($i -ne 0) {
        if ($i -lt $gridColumns) {
            $posX = $posX + $cellV
        }
        else {
            $verse++
            $gridColumns = $gridColumns + ($gridColumns * $verse)
            $posY = $posY + $cellH
            $posX = 0
        }
    }
    
    start-process "$(${env:ProgramFiles(x86)})\Google\Chrome\Application\chrome.exe" -Argumentlist "--enable-extensions --app=`"data:text/html,<html><body><script>window.moveTo($posX,$posY);window.resizeTo($cellV,$cellH);window.location='https://www.youtube.com/watch?v=$($ytLinks[$i])';</script></body></html>`"" -Verbose
}