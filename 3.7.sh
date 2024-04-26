#!/bin/bash

# Define the Apache directory and the Apache group
APACHE_DIR="/usr/local/apache2"
APACHE_GROUP="www-data"

# Define the core dump directory
CORE_DUMP_DIR="/var/log/httpd"

# Check if the CoreDumpDirectory directive is enabled
if grep -r "CoreDumpDirectory" $APACHE_DIR; then
    echo "The CoreDumpDirectory directive is enabled."

    # Check if the core dump directory is within the Apache web document root
    if [[ $CORE_DUMP_DIR == $APACHE_DIR* ]]; then
        echo "The core dump directory is within the Apache web document root. Please change it."
    else
        # Change the ownership of the core dump directory to root and the Apache group
        chown root:$APACHE_GROUP $CORE_DUMP_DIR

        # Remove read-write-search access permission for other users
        chmod o-rwx $CORE_DUMP_DIR

        echo "The core dump directory has been secured."
    fi
else
    echo "The CoreDumpDirectory directive is not enabled."
fi