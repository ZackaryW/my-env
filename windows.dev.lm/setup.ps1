
$winget_args = "--exact --source winget --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force "


winget install --id=ElementLabs.LMStudio  $winget_args
# use lms to install coder model

# Bootstrap LM Studio CLI
cmd /c %USERPROFILE%/.lmstudio/bin/lms.exe bootstrap

# Verify installation by checking version
lms version

# List available models
lms ls

# get yi-coder-9b-chat
lms get yi-coder-9b-chat



