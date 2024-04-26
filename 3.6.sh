#!/bin/bash

# Define the Apache directory
APACHE_DIR="/usr/local/apache2"

# Check if the Apache directories and files have other write access
if find -L $APACHE_DIR ! -type l -perm /o=w -ls; then
    echo "Removing other write access on Apache directories and files..."
    chmod -R o-w $APACHE_DIR
    echo "Other write access on Apache directories and files has been removed."
else
    echo "Apache directories and files do not have other write access."
fi