. ".\lib.ps1"

scoop bucket add oughtred https://github.com/oughtred-ltd/oughtred-scoop-bucket
winget.exe install --id "Microsoft.PowerBI" @($winget_args.Split())

scoop install oughtred/bravo
scoop install oughtred/pbi-tools
