# add args to skip confirm
param (
    [switch]$skip_confirm
)

# check scoop installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Scoop is not installed"
    # run ../windows/install-scoop.ps1
    & "$PSScriptRoot\..\windows\install-scoop.ps1"
}

scoop install flutter
scoop install dart


# input prompt install visual studio community
if (-not $skip_confirm) {
    $install_visual_studio = Read-Host "Install visual studio community? (y/n)"
} else {
    $install_visual_studio = "y"
}
if ($install_visual_studio -ne "n") {
    winget.exe install --id "Microsoft.VisualStudio.2022.RemoteTools" --exact --source winget --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force 
}

# android studio
if (-not $skip_confirm) {
    $install_android_studio = Read-Host "Install android studio? (y/n)"
} else {
    $install_android_studio = "y"
}
if ($install_android_studio -ne "n") {
    winget.exe install --id "Google.AndroidStudio" --exact --source winget --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force 
}

# check flutter installed
flutter doctor


