#!/bin/bash

# Define the Apache directory
APACHE_DIR="/usr/local/apache2"

# Identify files or directories in the Apache directory with group write access, excluding symbolic links
echo "Files or directories with group write access:"
find -L $APACHE_DIR \! -type l -perm /g=w -ls

# Remove group write access on the Apache directories
find -L $APACHE_DIR \! -type l -perm /g=w -exec chmod g-w {} \;

echo "Group write access has been removed."