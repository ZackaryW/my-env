
$winget_args = "--exact --source winget --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force "


# unigetui
winget.exe install --id "MartiCliment.UniGetUI" $winget_args

# zen
winget.exe install --id "Zen-Team.Zen-Browser" $winget_args
