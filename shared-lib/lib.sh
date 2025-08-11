#!/bin/bash

# Shared library functions for cross-platform package management

# Function to detect operating system
# Returns: "windows", "macos", or "linux"
detect_os() {
    # Check for Windows first (including WSL, Git Bash, etc.)
    if [[ -n "$WINDIR" ]] || [[ -n "$windir" ]] || [[ "$OS" == "Windows_NT" ]] || [[ "$(uname -r)" == *Microsoft* ]] || [[ "$(uname -r)" == *microsoft* ]] || command -v scoop >/dev/null 2>&1; then
        echo "windows"
    elif [[ "$(uname -s)" == "Darwin" ]]; then
        echo "macos"
    else
        echo "linux"
    fi
}

# Function to install packages using platform-appropriate package manager
# Function to install packages using platform-appropriate package manager
# Usage: install_package <package_name> [package_name2] ...
install_package() {
    if [ $# -eq 0 ]; then
        echo "Error: No package name provided"
        echo "Usage: install_package <package_name> [package_name2] ..."
        return 1
    fi

    # Detect operating system
    local os=$(detect_os)
    
    case "$os" in
        "windows")
            # Use scoop on Windows
            if command -v scoop >/dev/null 2>&1; then
                echo "Installing packages using Scoop on Windows..."
                for package in "$@"; do
                    echo "Installing: $package"
                    scoop install "$package"
                done
            else
                echo "Error: Scoop not found on Windows. Please install Scoop first."
                echo "Visit: https://scoop.sh"
                return 1
            fi
            ;;
        "macos")
            # Use brew on macOS
            if command -v brew >/dev/null 2>&1; then
                echo "Installing packages using Homebrew on macOS..."
                for package in "$@"; do
                    echo "Installing: $package"
                    brew install "$package"
                done
            else
                echo "Error: Homebrew not found on macOS. Please install Homebrew first."
                echo "Visit: https://brew.sh"
                return 1
            fi
            ;;
        "linux")
            # Use brew on Linux
            if command -v brew >/dev/null 2>&1; then
                echo "Installing packages using Homebrew on Linux..."
                for package in "$@"; do
                    echo "Installing: $package"
                    brew install "$package"
                done
            else
                echo "Error: Homebrew not found on Linux. Please install Homebrew first."
                echo "Visit: https://brew.sh"
                return 1
            fi
            ;;
        *)
            echo "Error: Unsupported operating system"
            return 1
            ;;
    esac
}

# Function to update package managers
update_packages() {
    local os=$(detect_os)
    
    case "$os" in
        "windows")
            if command -v scoop >/dev/null 2>&1; then
                echo "Updating Scoop on Windows..."
                scoop update && scoop update '*'
            else
                echo "Error: Scoop not found"
                return 1
            fi
            ;;
        "macos")
            if command -v brew >/dev/null 2>&1; then
                echo "Updating Homebrew on macOS..."
                brew update && brew upgrade
            else
                echo "Error: Homebrew not found"
                return 1
            fi
            ;;
        "linux")
            if command -v brew >/dev/null 2>&1; then
                echo "Updating Homebrew on Linux..."
                brew update && brew upgrade
            else
                echo "Error: Homebrew not found"
                return 1
            fi
            ;;
        *)
            echo "Error: Unsupported operating system"
            return 1
            ;;
    esac
}

# Function to install packages using winget (Windows only)
# Usage: install_winget_pkg <package_id> [package_id2] ...
install_winget_pkg() {
    if [ $# -eq 0 ]; then
        echo "Error: No package ID provided"
        echo "Usage: install_winget_pkg <package_id> [package_id2] ..."
        return 1
    fi

    # Check if we're on Windows
    if [[ -n "$WINDIR" ]] || [[ -n "$windir" ]] || [[ "$OS" == "Windows_NT" ]] || [[ "$(uname -r)" == *Microsoft* ]] || [[ "$(uname -r)" == *microsoft* ]]; then
        # Check if winget is available
        if command -v winget.exe >/dev/null 2>&1; then
            echo "Installing packages using winget on Windows..."
            # Define winget arguments (mirroring lib.ps1)
            local winget_args="--accept-source-agreements --disable-interactivity -h --accept-package-agreements --force"
            
            for package_id in "$@"; do
                echo "Installing: $package_id"
                winget.exe install --id "$package_id" $winget_args
            done
        else
            echo "Error: winget not found on Windows. Please ensure Windows Package Manager is installed."
            echo "Visit: https://aka.ms/getwinget"
            return 1
        fi
    else
        echo "Error: winget is only available on Windows"
        return 1
    fi
}

# Function to search for packages using winget (Windows only)
# Usage: search_winget_pkg <search_term>
search_winget_pkg() {
    if [ $# -eq 0 ]; then
        echo "Error: No search term provided"
        echo "Usage: search_winget_pkg <search_term>"
        return 1
    fi

    # Check if we're on Windows
    if [[ -n "$WINDIR" ]] || [[ -n "$windir" ]] || [[ "$OS" == "Windows_NT" ]] || [[ "$(uname -r)" == *Microsoft* ]] || [[ "$(uname -r)" == *microsoft* ]]; then
        # Check if winget is available
        if command -v winget.exe >/dev/null 2>&1; then
            echo "Searching for packages using winget..."
            winget.exe search "$1"
        else
            echo "Error: winget not found on Windows. Please ensure Windows Package Manager is installed."
            echo "Visit: https://aka.ms/getwinget"
            return 1
        fi
    else
        echo "Error: winget is only available on Windows"
        return 1
    fi
}

# Function to search for packages
search_package() {
    if [ $# -eq 0 ]; then
        echo "Error: No search term provided"
        echo "Usage: search_package <search_term>"
        return 1
    fi

    # Check for Windows first (including WSL, Git Bash, etc.)
    if [[ -n "$WINDIR" ]] || [[ -n "$windir" ]] || [[ "$OS" == "Windows_NT" ]] || [[ "$(uname -r)" == *Microsoft* ]] || [[ "$(uname -r)" == *microsoft* ]] || command -v scoop >/dev/null 2>&1; then
        if command -v scoop >/dev/null 2>&1; then
            echo "Searching for packages using Scoop..."
            scoop search "$1"
        else
            echo "Error: Scoop not found"
            return 1
        fi
    else
        if command -v brew >/dev/null 2>&1; then
            echo "Searching for packages using Homebrew..."
            brew search "$1"
        else
            echo "Error: Homebrew not found"
            return 1
        fi
    fi
}