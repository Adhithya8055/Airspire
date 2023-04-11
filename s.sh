#!/bin/bash

echo "Launching airspire..."

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Navigate to the directory where the script is located
cd "$SCRIPT_DIR"

# Check if the current directory is a Git repository
if [ -d ".git" ]; then
  # Check for updates
  git fetch

  # Compare the local branch with the remote branch
  if [ "$(git rev-list HEAD..origin/master --count)" -gt 0 ]; then
    # Update the local repository
    git pull

    # Launch the updated script
    echo "Launching updated airspire..."
    bash "$SCRIPT_DIR/airspire.sh"

    # Exit the current instance of the script
    exit 0
  fi
else
  echo "ERROR: The current directory is not a Git repository."
  exit 1
fi

# If no update is available or the script is not in a Git repository, continue with the existing script
echo "No update available. Continuing with existing airspire..."
# Add your existing code here

