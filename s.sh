#!/bin/bash

# define function for updating Airspire
function update_airspire {
    git pull origin main # update from remote repository
    if [ $? -eq 0 ]; then # check if update was successful
        echo "Airspire has been updated. Relaunching..."
        exec "$0" "$@" # relaunch the script
    else
        echo "An error occurred while updating Airspire."
    fi
}

echo "Launching Airspire..."

# check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git and try again."
    exit 1
fi

# set Airspire path based on the current OS
if [[ $(uname -s) == "Linux" ]]; then
    if [[ -d "/home/kali/Airspire" ]]; then
        AIRSPIRE_PATH="/home/kali/Airspire"
    elif [[ -d "/home/ubuntu/Airspire" ]]; then
        AIRSPIRE_PATH="/home/ubuntu/Airspire"
    elif [[ -d "/home/pi/Airspire" ]]; then
        AIRSPIRE_PATH="/home/pi/Airspire"
    else
        echo "Airspire directory not found. Please set the AIRSPIRE_PATH variable manually."
        exit 1
    fi
else
    echo "Unsupported operating system."
    exit 1
fi

# navigate to Airspire directory
cd "$AIRSPIRE_PATH"

# check for updates
git remote update > /dev/null 2>&1
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u})

# check if local repository is up to date
if [ $LOCAL = $REMOTE ]; then
    echo "Airspire is up to date. Continuing..."
else
    echo "An update is available. Do you want to update? [y/n]"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        update_airspire # call function to update Airspire
    else
        echo "Continuing with existing version of Airspire..."
    fi
fi

# execute Airspire
echo "test"
echo "telmax"
