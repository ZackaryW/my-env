. ".\lib.ps1"

scoop install flutter

winget.exe install --id "Microsoft.VisualStudio.2022.Community" @($winget_args.Split())

winget.exe install --id "Google.AndroidStudio" @($winget_args.Split())


# check flutter installed
flutter doctor