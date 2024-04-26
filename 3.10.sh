#!/bin/bash

# Define the Apache directory and the ScoreBoard file directory
APACHE_DIR="/usr/local/apache2"
SCOREBOARD_FILE_DIR="/usr/local/apache2/logs"

# Check if the ScoreBoardFile directive is enabled
if grep -r "ScoreBoardFile" $APACHE_DIR; then
    echo "The ScoreBoardFile directive is enabled."

    # Check if the ScoreBoard file directory is within the Apache web document root
    if [[ $SCOREBOARD_FILE_DIR == $APACHE_DIR* ]]; then
        echo "The ScoreBoard file directory is within the Apache web document root. Please change it."
    else
        # Change the ownership of the ScoreBoard file directory to root
        chown root:root $SCOREBOARD_FILE_DIR

        # Change the permissions so that the directory is only writable by root
        chmod 700 $SCOREBOARD_FILE_DIR

        echo "The ScoreBoard file directory has been secured."
    fi
else
    echo "The ScoreBoardFile directive is not enabled."
fi