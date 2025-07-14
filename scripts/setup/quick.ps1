. ".\lib.ps1"

echo "INSTALL UNIGETUI"
Start-Sleep -Seconds 1
winget install unigetui -s msstore @($winget_args.Split())


echo "INSTALL github desktop"
Start-Sleep -Seconds 1
winget install  GitHub.GitHubDesktop @($winget_args.Split())


echo "INSTALL powershell"
Start-Sleep -Seconds 1
winget install  Microsoft.PowerShell @($winget_args.Split())


echo "INSTALL SCOOP"
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Scoop is installed."
} else {
    Write-Host "Scoop is not installed."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    
    scoop install git
    scoop bucket add extras
    scoop bucket add nonportable
    scoop install vscode
    scoop install potplayer
    scoop install cursor
    scoop install everything
    scoop install everythingtoolbar
    scoop install rye
    scoop install yt-dlp
    scoop install localsend
    scoop install winfsp-np
    scoop install cryptomator
}

# setup browser related
echo "INSTALL BROWSER"
winget install Zen-Team.Zen-Browser @($winget_args.Split())

scoop install floorp


