import os

if __name__ == "__main__":
    os.system("scoop bucket add oughtred https://github.com/oughtred-ltd/oughtred-scoop-bucket")
    os.system("winget install -e --id Microsoft.PowerBI")
    os.system("scoop install oughtred/bravo")
    os.system("scoop install oughtred/pbi-tools")

