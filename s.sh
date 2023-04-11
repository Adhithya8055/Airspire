#!/bin/bash

echo "Launching airspire..."

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Navigate to the directory where the script is located
cd "$SCRIPT_DIR"

# Show the ASCII and logo stuff here

while true; do
  # Check for updates
  git fetch > /dev/null 2>&1

  # Compare the local branch with the remote branch
  if [ "$(git rev-list --count --left-right HEAD...@{upstream} 2>/dev/null | awk '{print $2}')" != "0" ]; then
    # Update the local repository
    echo "An update is available. Do you want to update? [y/n]"
    read -r answer
    if [[ "$answer" == [yY] ]]; then
      git pull > /dev/null 2>&1
      echo "Airspire has been updated. Relaunching..."
      exec bash "$0"
      exit 0
    fi
  else
    # If no update is available, continue with the existing script
    echo "Airspire is up to date. Continuing..."
  fi

  # Add your existing code here
  
  # Sleep for 5 seconds before checking for updates again
  sleep 5
  
  echo "test"
#echo "next"
done
