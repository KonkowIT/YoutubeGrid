# ilosc rzedow
$gridRows = 3

# ilosc kolumn
$gridColumns = 3

# lista linkow do YT
$ytLinks = @(
    "abc123",
    "abc123",
    "abc123",
    "abc123"
    "abc123",
    "abc123",
    "abc123",
    "abc123",
    "abc123"
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
    
    start-process "$env:ProgramFiles\Google\Chrome\Application\chrome.exe" -Argumentlist "--enable-extensions --app=`"data:text/html,<html><body><script>window.moveTo($posX,$posY);window.resizeTo($cellV,$cellH);window.location='https://www.youtube.com/watch?v=$($ytLinks[$i])';</script></body></html>`"" -Verbose
}