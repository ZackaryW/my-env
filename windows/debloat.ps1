# change cwd to a temporary directory
Set-Location -Path $env:TEMP

# Clone the repository
git clone https://github.com/LeDragoX/Win-Debloat-Tools.git

# Change to the repository directory
Set-Location Win-Debloat-Tools

# Set execution policy to allow script execution
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Unblock all PowerShell scripts in the repository
Get-ChildItem -Recurse -Filter "*.ps1" | Unblock-File

# Execute the main script in CLI mode
.\WinDebloatTools.ps1 

# prompt to continue
Read-Host "Press Enter to continue..."

# cleanup 
Set-Location -Path $PSScriptRoot
Remove-Item -Recurse -Force Win-Debloat-Tools
