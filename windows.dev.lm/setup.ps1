winget install --id=ElementLabs.LMStudio  -e
# use lms to install coder model

# Bootstrap LM Studio CLI
cmd /c %USERPROFILE%/.lmstudio/bin/lms.exe bootstrap

# Verify installation by checking version
lms version

# List available models
lms ls

# get yi-coder-9b-chat
lms get yi-coder-9b-chat



