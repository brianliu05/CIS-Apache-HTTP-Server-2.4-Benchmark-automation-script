#!/bin/bash

# Define the Apache directory and the lock file directory
APACHE_DIR="/usr/local/apache2"
LOCK_FILE_DIR="/usr/local/apache2/logs"

# Check if the Mutex directive is enabled with the mechanism of fcntl, flock, or file
if grep -r "Mutex" $APACHE_DIR | grep -E "fcntl|flock|file"; then
    echo "The Mutex directive is enabled with the mechanism of fcntl, flock, or file."

    # Check if the lock file directory is within the Apache web document root
    if [[ $LOCK_FILE_DIR == $APACHE_DIR* ]]; then
        echo "The lock file directory is within the Apache web document root. Please change it."
    else
        # Change the ownership of the lock file directory to root
        chown root:root $LOCK_FILE_DIR

        # Change the permissions so that the directory is only writable by root
        chmod 700 $LOCK_FILE_DIR

        echo "The lock file directory has been secured."
    fi
else
    echo "The Mutex directive is not enabled with the mechanism of fcntl, flock, or file."
fi