#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Source the shared library
source "${SCRIPT_DIR}/../shared-lib/lib.sh"

echo "Setting up Flutter development environment..."

# Detect the operating system
OS_TYPE=$(detect_os)
echo "Detected OS: $OS_TYPE"

# Install Flutter using appropriate package manager
install_package flutter

# Install development tools based on OS
case "$OS_TYPE" in
    "windows")
        echo "Installing Windows-specific development tools..."
        # Install Visual Studio Community 2022 using winget
        install_winget_pkg "Microsoft.VisualStudio.2022.Community"
        # Install Android Studio using winget
        install_winget_pkg "Google.AndroidStudio"
        ;;
    "macos")
        echo "Installing macOS-specific development tools..."
        # Install Xcode (for iOS development)
        echo "Please install Xcode from the App Store for iOS development"
        # Install Android Studio using brew
        install_package android-studio
        ;;
    "linux")
        echo "Installing Linux-specific development tools..."
        # Install Android Studio using brew
        install_package android-studio
        # Install additional dependencies that might be needed on Linux
        echo "You may need to install additional dependencies for Android development:"
        echo "  - OpenJDK"
        echo "  - Android SDK"
        ;;
    *)
        echo "Unsupported operating system: $OS_TYPE"
        exit 1
        ;;
esac

echo ""
echo "Checking Flutter installation..."
# Check flutter installed
if command -v flutter >/dev/null 2>&1; then
    flutter doctor
else
    echo "Flutter command not found. Please restart your terminal or add Flutter to your PATH."
fi
