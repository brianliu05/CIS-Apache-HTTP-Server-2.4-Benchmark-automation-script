#!/bin/bash

# Define the Apache directory and the Pid file directory
APACHE_DIR="/usr/local/apache2"
PID_FILE_DIR="/usr/local/apache2/logs"

# Check if the PidFile directive is enabled
if grep -r "PidFile" $APACHE_DIR; then
    echo "The PidFile directive is enabled."

    # Check if the Pid file directory is within the Apache web document root
    if [[ $PID_FILE_DIR == $APACHE_DIR* ]]; then
        echo "The Pid file directory is within the Apache web document root. Please change it."
    else
        # Change the ownership of the Pid file directory to root
        chown root:root $PID_FILE_DIR

        # Change the permissions so that the directory is only writable by root
        chmod 700 $PID_FILE_DIR

        echo "The Pid file directory has been secured."
    fi
else
    echo "The PidFile directive is not enabled."
fi