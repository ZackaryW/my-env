. ".\lib.ps1"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$devFiles = Get-ChildItem -Path $scriptDir -Filter "dev-*" -File
# ignore .sh files
$devFiles = $devFiles | Where-Object { $_.Extension -ne ".sh" }


if ($args.Count -eq 0) {
    foreach ($file in $devFiles) {
        $confirm = Read-Host "Run $($file.Name)? (y/n)"
        if ($confirm -eq "y") {
            Invoke-FileByExtension $file.FullName
        }
    }
} else {
    foreach ($name in $args) {
        $matched = $devFiles | Where-Object { $_.Name -like "dev-$name*" }
        if ($matched) {
            foreach ($file in $matched) {
                Invoke-FileByExtension $file.FullName
            }
        } else {
            Write-Host "No matching dev-$name script found."
        }
    }
}