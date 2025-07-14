. ".\lib.ps1"

winget install --id=ElementLabs.LMStudio $winget_args

# Bootstrap LM Studio CLI
$lmspath = "$env:USERPROFILE\.lmstudio\bin\lms.exe"
cmd /c "$lmspath bootstrap"

# Verify installation by checking version
& $lmspath version

# List available models
& $lmspath ls

# get yi-coder-9b-chat
& $lmspath get yi-coder