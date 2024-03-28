#!/bin/bash

# Check if mod_dav and mod_dav_fs are loaded
if apachectl -M | grep -q 'dav_module'; then
    echo "mod_dav is loaded. Disabling..."
    
    # Backup the original configuration file
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    
    # Disable mod_dav and mod_dav_fs modules
    sed -i 's/LoadModule dav_module modules\/mod_dav.so/#LoadModule dav_module modules\/mod_dav.so/g' /etc/apache2/apache2.conf
    sed -i 's/LoadModule dav_fs_module modules\/mod_dav_fs.so/#LoadModule dav_fs_module modules\/mod_dav_fs.so/g' /etc/apache2/apache2.conf

    # Restart Apache to apply changes
    systemctl restart apache2
    echo "mod_dav and mod_dav_fs modules have been disabled."
else
    echo "mod_dav and mod_dav_fs are not loaded."
fi
