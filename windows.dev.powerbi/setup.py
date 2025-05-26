import os


winget_args = "--exact --source winget --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force "


if __name__ == "__main__":
    os.system("scoop bucket add oughtred https://github.com/oughtred-ltd/oughtred-scoop-bucket")
    os.system(f'winget.exe install --id "Microsoft.PowerBI" {winget_args}')
    os.system("scoop install oughtred/bravo")
    os.system("scoop install oughtred/pbi-tools")

