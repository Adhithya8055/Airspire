#!/bin/bash

echo "Launching airspire..."

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Navigate to the directory where the script is located
cd "$SCRIPT_DIR"

# Check for updates
git fetch

# Compare the local branch with the remote branch
if [ "$(git rev-list --count --left-right HEAD...@{upstream} 2>/dev/null | awk '{print $2}')" != "0" ]; then
  # Update the local repository
  git pull

  # Launch the updated script
  echo "Launching updated airspire..."
  bash "$SCRIPT_DIR/airspire.sh"

  # Exit the current instance of the script
  exit 0
fi

# If no update is available, continue with the existing script
echo "No update available. Continuing with existing airspire..."
# Add your existing code here
echo "ok "

