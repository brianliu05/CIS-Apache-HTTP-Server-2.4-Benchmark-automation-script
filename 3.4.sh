#!/bin/bash

# Define the Apache directory
APACHE_DIR="/usr/local/apache2"

# Check if the Apache directories and files are owned by root
if find $APACHE_DIR ! -user root; then
    echo "Changing ownership of Apache directories and files to root..."
    sudo chown -R root:root $APACHE_DIR
    echo "Ownership of Apache directories and files is now root."
else
    echo "Apache directories and files are already owned by root."
fi