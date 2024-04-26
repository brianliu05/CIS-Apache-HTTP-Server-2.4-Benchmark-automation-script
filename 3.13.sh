#!/bin/bash

# Define the Apache directory, Document Root directory, and writable directory
APACHE_DIR="/usr/local/apache2"
DOCROOT=$(grep -i '^DocumentRoot' $APACHE_DIR/conf/httpd.conf | cut -d' ' -f2 | tr -d '\"')
WR_DIR="/var/phptmp/sessions"

# Check if the directory serves a single purpose
echo "Please manually review the documented purpose for the directory to confirm the directory serves a single purpose."

# Check if the directory is not within the DocumentRoot
INUM=$(stat -c '%i' $WR_DIR)
if [ -z "$(find -L $DOCROOT -inum $INUM)" ]; then
    echo "The directory is not within the DocumentRoot."
else
    echo "The directory is within the DocumentRoot."
fi

# Check if the directory is owned by root or an administrator
if [ "$(stat -c '%U' $WR_DIR/)" == "root" ]; then
    echo "The directory is owned by root."
else
    echo "The directory is not owned by root. Please manually check if it is owned by an administrator."
fi

# Check if the directory is not writable by others
if [ -z "$(find $WR_DIR/ -perm /o=w -ls)" ]; then
    echo "The directory and any sub-directories are not writable by others."
else
    echo "The directory or some sub-directories are writable by others."
fi