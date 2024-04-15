#!/bin/bash

# Define the Apache user
APACHE_USER="apache"

# Check if the Apache user account is locked
if sudo passwd -S $APACHE_USER | grep -q "L"; then
    echo "The $APACHE_USER account is already locked."
else
    echo "Locking the $APACHE_USER account..."
    sudo passwd -l $APACHE_USER
    echo "The $APACHE_USER account is now locked."
fi