#!/bin/bash

# Check if mod_info is loaded
if apachectl -M | grep -q 'info_module'; then
    echo "mod_info is loaded. Disabling..."
    
    # Backup the original configuration file
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    
    # Disable mod_info module
    sed -i 's/LoadModule info_module modules\/mod_info.so/#LoadModule info_module modules\/mod_info.so/g' /etc/apache2/apache2.conf

    # Restart Apache to apply changes
    systemctl restart apache2
    echo "mod_info module has been disabled."
else
    echo "mod_info is not loaded."
fi
