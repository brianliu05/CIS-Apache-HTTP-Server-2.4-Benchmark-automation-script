#!/bin/bash

# Check if mod_userdir is loaded
if apachectl -M | grep -q 'userdir_module'; then
    echo "mod_userdir is loaded. Disabling..."
    
    # Backup the original configuration file
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    
    # Disable mod_userdir module
    sed -i 's/LoadModule userdir_module modules\/mod_userdir.so/#LoadModule userdir_module modules\/mod_userdir.so/g' /etc/apache2/apache2.conf

    # Restart Apache to apply changes
    systemctl restart apache2
    echo "mod_userdir module has been disabled."
else
    echo "mod_userdir is not loaded."
fi
