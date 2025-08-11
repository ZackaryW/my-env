@echo off
rem YouTube Audio Downloader - Batch wrapper
rem Usage: yt-audio-mp3.bat "URL" [OutputPath] [Quality]

setlocal

set SCRIPT_DIR=%~dp0
set PS_SCRIPT="%SCRIPT_DIR%yt-audio-mp3.ps1"

if "%~1"=="" (
    echo Usage: %~nx0 "URL" [OutputPath] [Quality]
    echo Example: %~nx0 "https://www.youtube.com/watch?v=VIDEO_ID"
    echo Example: %~nx0 "https://www.youtube.com/playlist?list=PLAYLIST_ID" "C:\Music"
    echo Example: %~nx0 "https://www.youtube.com/watch?v=VIDEO_ID" "." "192K"
    exit /b 1
)

rem Build PowerShell command
set PS_CMD=powershell.exe -ExecutionPolicy Bypass -File %PS_SCRIPT% -Url "%~1"

if not "%~2"=="" (
    set PS_CMD=%PS_CMD% -OutputPath "%~2"
)

if not "%~3"=="" (
    set PS_CMD=%PS_CMD% -Quality "%~3"
)

rem Execute the PowerShell script
%PS_CMD%

endlocal
exit /b %ERRORLEVEL%
