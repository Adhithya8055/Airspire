#!/bin/bash

cd "$(dirname "$0")"

function updateAirspire {
    echo "An update is available. Do you want to update? [y/n]"
    read update
    if [ "$update" = "y" ]; then
        if ! git pull; then
            echo "An error occurred while updating Airspire."
            return 1
        fi
        echo "Airspire has been updated. Relaunching..."
        exec bash "$0"
        exit $?
    fi
}

echo "Launching Airspire..."

if ! git remote update > /dev/null 2>&1; then
    echo "Failed to fetch updates. Launching Airspire..."
else
    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    if [ $LOCAL != $REMOTE ]; then
        updateAirspire || true
    else
        echo "Airspire is up to date. Continuing..."
    fi
fi

# your script goes here
echo "test"
sudo nmap 127.0.0.1
