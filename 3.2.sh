#!/bin/bash

# Define the Apache user
APACHE_USER="apache"

# Check the shell of the Apache user
APACHE_SHELL=$(getent passwd $APACHE_USER | cut -d: -f7)

if [ "$APACHE_SHELL" != "/sbin/nologin" ] && [ "$APACHE_SHELL" != "/dev/null" ]; then
    echo "Changing shell for $APACHE_USER to /sbin/nologin..."
    usermod -s /sbin/nologin $APACHE_USER
    echo "Shell for $APACHE_USER is now $(getent passwd $APACHE_USER | cut -d: -f7)."
else
    echo "Shell for $APACHE_USER is already invalid."
fi