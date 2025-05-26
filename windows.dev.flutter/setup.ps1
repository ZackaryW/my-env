# check scoop installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Scoop is not installed"
    # run ../windows/install-scoop.ps1
    & "$PSScriptRoot\..\windows\install-scoop.ps1"
}

scoop install flutter
scoop install dart


# input prompt install visual studio community
$install_visual_studio = Read-Host "Install visual studio community? (y/n)"
if ($install_visual_studio -ne "n") {
    winget install -e --id Microsoft.VisualStudio.2022.Community
}

# android studio
$install_android_studio = Read-Host "Install android studio? (y/n)"
if ($install_android_studio -ne "n") {
    winget install -e --id Google.AndroidStudio
}

# check flutter installed
flutter doctor


