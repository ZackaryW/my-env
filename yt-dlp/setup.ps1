#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Setup script to automatically add yt-audio-mp3 function to PowerShell profile.

.DESCRIPTION
    This script automatically:
    1. Checks if yt-dlp is installed (installs if missing)
    2. Creates PowerShell profile if it doesn't exist
    3. Adds yt-audio-mp3 function to the profile
    4. Reloads the profile to make the function immediately available

.EXAMPLE
    .\setup-yt-audio-alias.ps1
#>

# Function to check if yt-dlp is installed
function Test-YtDlp {
    try {
        $null = Get-Command yt-dlp -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Function to install yt-dlp
function Install-YtDlp {
    Write-Host "Installing yt-dlp..." -ForegroundColor Yellow
    try {
        winget install yt-dlp
        Write-Host "✓ yt-dlp installed successfully!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "✗ Failed to install yt-dlp via winget." -ForegroundColor Red
        Write-Host "Please install manually: https://github.com/yt-dlp/yt-dlp#installation" -ForegroundColor Cyan
        return $false
    }
}

# Function to check if function already exists in profile
function Test-FunctionInProfile {
    if (Test-Path $PROFILE) {
        $profileContent = Get-Content $PROFILE -Raw
        return $profileContent -match "function yt-audio-mp3"
    }
    return $false
}

# Main setup function
function Main {
    Write-Host "=== YouTube Audio MP3 Setup ===" -ForegroundColor Cyan
    Write-Host ""

    # Step 1: Check/Install yt-dlp
    Write-Host "Step 1: Checking yt-dlp installation..." -ForegroundColor Yellow
    if (Test-YtDlp) {
        Write-Host "✓ yt-dlp is already installed" -ForegroundColor Green
    } else {
        if (-not (Install-YtDlp)) {
            Write-Host "Setup failed. Please install yt-dlp manually first." -ForegroundColor Red
            exit 1
        }
    }

    Write-Host ""

    # Step 2: Create profile if needed
    Write-Host "Step 2: Setting up PowerShell profile..." -ForegroundColor Yellow
    if (-not (Test-Path $PROFILE)) {
        Write-Host "Creating PowerShell profile at: $PROFILE" -ForegroundColor Cyan
        New-Item -ItemType File -Path $PROFILE -Force | Out-Null
        Write-Host "✓ PowerShell profile created" -ForegroundColor Green
    } else {
        Write-Host "✓ PowerShell profile already exists" -ForegroundColor Green
    }

    Write-Host ""

    # Step 3: Add function to profile
    Write-Host "Step 3: Adding yt-audio-mp3 function..." -ForegroundColor Yellow
    
    if (Test-FunctionInProfile) {
        Write-Host "✓ yt-audio-mp3 function already exists in profile" -ForegroundColor Green
        $overwrite = Read-Host "Do you want to overwrite it? (y/N)"
        if ($overwrite -notin @('y', 'Y', 'yes', 'Yes', 'YES')) {
            Write-Host "Setup cancelled by user." -ForegroundColor Yellow
            exit 0
        }
        
        # Remove existing function
        $profileContent = Get-Content $PROFILE -Raw
        $profileContent = $profileContent -replace '(?s)# yt-audio-mp3 function.*?^}', '' -replace '\r?\n\s*\r?\n', "`r`n"
        Set-Content -Path $PROFILE -Value $profileContent
        Write-Host "✓ Existing function removed" -ForegroundColor Green
    }

    # Add the function
    $functionCode = @'

# yt-audio-mp3 function - Download audio from YouTube videos/playlists as MP3
function yt-audio-mp3 { 
    param([Parameter(ValueFromRemainingArguments)]$Arguments)
    & yt-dlp --extract-audio --audio-format mp3 --embed-thumbnail --convert-thumbnails png --add-metadata @Arguments
}
'@

    Add-Content -Path $PROFILE -Value $functionCode
    Write-Host "✓ yt-audio-mp3 function added to profile" -ForegroundColor Green

    Write-Host ""

    # Step 4: Reload profile
    Write-Host "Step 4: Reloading PowerShell profile..." -ForegroundColor Yellow
    try {
        . $PROFILE
        Write-Host "✓ Profile reloaded successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠ Profile reload failed, but function was added" -ForegroundColor Yellow
        Write-Host "You may need to restart PowerShell or run: . `$PROFILE" -ForegroundColor Cyan
    }

    Write-Host ""

    # Step 5: Test the function
    Write-Host "Step 5: Testing the function..." -ForegroundColor Yellow
    try {
        $command = Get-Command yt-audio-mp3 -ErrorAction Stop
        Write-Host "✓ yt-audio-mp3 function is available!" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠ Function test failed" -ForegroundColor Yellow
        Write-Host "Try restarting PowerShell or run: . `$PROFILE" -ForegroundColor Cyan
    }

    Write-Host ""
    Write-Host "=== Setup Complete! ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "Usage examples:" -ForegroundColor White
    Write-Host "  yt-audio-mp3 https://www.youtube.com/watch?v=VIDEO_ID" -ForegroundColor Cyan
    Write-Host "  yt-audio-mp3 https://www.youtube.com/playlist?list=PLAYLIST_ID" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "The function is now permanently available in all new PowerShell sessions!" -ForegroundColor Green
}

# Run the setup
Main
