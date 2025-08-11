#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Source the shared library
source "${SCRIPT_DIR}/../shared-lib/lib.sh"

echo "Setting up Node.js development environment..."

install_package nodejs
install_package nvm