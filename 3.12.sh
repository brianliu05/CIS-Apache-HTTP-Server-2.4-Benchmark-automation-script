#!/bin/bash

# Define the Apache directory and Document Root directory
APACHE_DIR="/usr/local/apache2"
DOCROOT="/usr/local/apache2/htdocs"

# Define the Apache group
GRP=$(grep '^Group' $APACHE_DIR/conf/httpd.conf | cut -d' ' -f2)

# Identify files or directories in the Apache Document Root directory with Apache group write access
echo "Files or directories with Apache group write access:"
find -L $DOCROOT -group $GRP -perm /g=w -ls

# Remove group write access on the Apache Document Root directories and files with the Apache group
find -L $DOCROOT -group $GRP -perm /g=w -print | xargs chmod g-w

echo "Group write access has been removed."