winget_args = "--accept-source-agreements --disable-interactivity -h --accept-package-agreements --force"

function Invoke-FileByExtension {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    if (!(Test-Path $FilePath)) {
        Write-Error "File not found: $FilePath"
        return
    }

    $ext = [System.IO.Path]::GetExtension($FilePath).ToLower()

    switch ($ext) {
        ".sh"   { bash $FilePath }
        ".py"   { python $FilePath }
        ".js"   { node $FilePath }
        ".bat"  { & cmd.exe /c $FilePath }
        ".ps1"  { & powershell -ExecutionPolicy Bypass -File $FilePath }
        default { Write-Error "Unsupported file extension: $ext" }
    }
}