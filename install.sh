#!/bin/bash

# Constants
REPO_USERNAME="Yamayamaaya"
REPO_NAME="Rel"
SCRIPT_NAME="rel.sh"
INSTALL_PATH="/usr/local/bin/rel"

# Download the script from GitHub
curl -sSL "https://raw.githubusercontent.com/$REPO_USERNAME/$REPO_NAME/master/src/$SCRIPT_NAME" -o "$SCRIPT_NAME"

# Make the downloaded script executable
chmod +x "$SCRIPT_NAME"

# Move the script to the installation path
sudo mv "$SCRIPT_NAME" "$INSTALL_PATH"

echo "Installation completed successfully. You can now use the 'rel' command."
