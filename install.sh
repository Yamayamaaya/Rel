#!/bin/bash

# Check if the 'tree' command is installed
if ! command -v tree &> /dev/null
then
    echo "'tree' command could not be found. Installing..."
    # You might adjust the installation command based on the user's OS
    brew install tree
fi

# Constants
REPO_USERNAME="Yamayamaaya"
REPO_NAME="Rel"
SCRIPT_NAME="rel.sh"
INSTALL_PATH="/usr/local/bin"

# Download the script from GitHub
curl -sSL "https://raw.githubusercontent.com/$REPO_USERNAME/$REPO_NAME/main/src/$SCRIPT_NAME" -o "$SCRIPT_NAME"

# Make the downloaded script executable
chmod +x "$SCRIPT_NAME"

# Move the script to the installation path
sudo mv "$SCRIPT_NAME" "$INSTALL_PATH"

echo "Installation completed successfully. You can now use the 'rel' command."
