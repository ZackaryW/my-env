# install scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# install git
scoop install git
scoop bucket add extras

# declare LIST_OF_MUST
$LIST_OF_MUST = @(
    "python",
    "rye",
    "czkawka-gui",
    "potplayer",
    "jid",
    "jq",
    "ffmpeg",
    "floorp",
    "yt-dlp"
)

foreach ($app in $LIST_OF_MUST) {
    scoop install $app
}
