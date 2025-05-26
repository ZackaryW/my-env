import os

if __name__ == "__main__":
    os.system("scoop bucket add oughtred https://github.com/oughtred-ltd/oughtred-scoop-bucket")
    os.system('winget.exe install --id "Microsoft.PowerBI" --exact --source winget --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force')
    os.system("scoop install oughtred/bravo")
    os.system("scoop install oughtred/pbi-tools")

