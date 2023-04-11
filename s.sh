#!/bin/bash

echo "Launching airspire..."

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Navigate to the directory where the script is located
cd "$SCRIPT_DIR"

while true; do
  # Check for updates
  git fetch

  # Compare the local branch with the remote branch
  if [ "$(git rev-list --count --left-right HEAD...@{upstream} 2>/dev/null | awk '{print $2}')" != "0" ]; then
    # Update the local repository
    git pull

    # Launch the updated script
    echo "An update is available. Do you want to update? [y/n]"
    read update_choice
    if [ "$update_choice" = "y" ]; then
      echo "Airspire has been updated. Relaunching..."
      exec sudo bash "$SCRIPT_DIR/airspire.sh"
    fi
  else
    echo "Airspire is up to date. Continuing..."
    # Add your existing code here
    echo "test"
    echo "telmaya"
    break
  fi
  
  # Sleep for 5 seconds before checking for updates again
  sleep 5
done
