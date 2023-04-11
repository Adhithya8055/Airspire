#!/bin/bash

echo "Launching airspire..."

# Navigate to the directory where the script is located
cd /path/to/airspire

# Check for updates
git fetch

# Compare the local branch with the remote branch
if [ "$(git rev-list HEAD...origin/master --count)" -gt 0 ]; then
  # Update the local repository
  git pull

  # Launch the updated script
  echo "Launching updated airspire..."
  bash airspire.sh

  # Exit the current instance of the script
  exit 0
fi

# If no update is available, continue with the existing script
echo "No update available. Continuing with existing airspire..."
# Add your existing code here


echo "this is a test"

echo "N5"
