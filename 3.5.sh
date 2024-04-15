#!/bin/bash

# Define the Apache directory
APACHE_DIR="/usr/local/apache2"

# Check if the Apache directories and files are owned by root
if find $APACHE_DIR ! -group root; then
    echo "Changing group of Apache directories and files to root..."
    sudo chgrp -R root $APACHE_DIR
    echo "Group of Apache directories and files is now root."
else
    echo "Apache directories and files are already in root group."
fi