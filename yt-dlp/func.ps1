#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Download audio from YouTube videos or playlists as MP3 files with metadata and thumbnails.

.DESCRIPTION
    This script uses yt-dlp to download audio from YouTube URLs, convert them to MP3 format,
    embed thumbnails, and add metadata. It supports both individual videos and playlists.

.PARAMETER Url
    The YouTube URL (video or playlist) to download audio from.

.PARAMETER OutputPath
    Optional. The directory where files should be saved. Defaults to current directory.

.PARAMETER Quality
    Optional. Audio quality for MP3. Options: best, worst, or specific bitrate like 320K, 192K, 128K.
    Defaults to 'best'.

.EXAMPLE
    .\yt-audio-mp3.ps1 "https://www.youtube.com/watch?v=VIDEO_ID"
    
.EXAMPLE
    .\yt-audio-mp3.ps1 "https://www.youtube.com/playlist?list=PLAYLIST_ID" -OutputPath "C:\Music"
    
.EXAMPLE
    .\yt-audio-mp3.ps1 "https://www.youtube.com/watch?v=VIDEO_ID" -Quality "192K"
#>

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Url,
    
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = ".",
    
    [Parameter(Mandatory = $false)]
    [string]$Quality = "best"
)

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

# Function to install yt-dlp if not present
function Install-YtDlp {
    Write-Host "yt-dlp not found. Attempting to install..." -ForegroundColor Yellow
    
    # Try winget first
    try {
        winget install yt-dlp
        Write-Host "yt-dlp installed successfully via winget!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "Failed to install via winget. Please install yt-dlp manually:" -ForegroundColor Red
        Write-Host "Visit: https://github.com/yt-dlp/yt-dlp#installation" -ForegroundColor Cyan
        return $false
    }
}

# Main execution
function Main {
    Write-Host "=== YouTube Audio Downloader ===" -ForegroundColor Cyan
    Write-Host "URL: $Url" -ForegroundColor White
    Write-Host "Output Path: $OutputPath" -ForegroundColor White
    Write-Host "Quality: $Quality" -ForegroundColor White
    Write-Host ""

    # Check if yt-dlp is available
    if (-not (Test-YtDlp)) {
        if (-not (Install-YtDlp)) {
            exit 1
        }
    }

    # Ensure output directory exists
    if ($OutputPath -ne ".") {
        if (-not (Test-Path $OutputPath)) {
            New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
            Write-Host "Created output directory: $OutputPath" -ForegroundColor Green
        }
    }

    # Build yt-dlp command
    $ytDlpArgs = @(
        "--extract-audio"
        "--audio-format", "mp3"
        "--embed-thumbnail"
        "--convert-thumbnails", "png"
        "--add-metadata"
        "--output", "$OutputPath\%(uploader)s - %(title)s.%(ext)s"
    )

    # Add quality setting if not 'best'
    if ($Quality -ne "best") {
        $ytDlpArgs += "--audio-quality", $Quality
    }

    # Add the URL
    $ytDlpArgs += $Url

    Write-Host "Starting download..." -ForegroundColor Yellow
    Write-Host "Command: yt-dlp $($ytDlpArgs -join ' ')" -ForegroundColor Gray
    Write-Host ""

    try {
        # Execute yt-dlp
        & yt-dlp @ytDlpArgs
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "Download completed successfully!" -ForegroundColor Green
        } else {
            Write-Host ""
            Write-Host "Download failed with exit code: $LASTEXITCODE" -ForegroundColor Red
            exit $LASTEXITCODE
        }
    }
    catch {
        Write-Host "Error occurred during download: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
}

# Run the main function
Main
