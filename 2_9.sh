#!/bin/bash

# Check if mod_auth_basic is loaded
if apachectl -M | grep -q 'auth_basic_module'; then
    echo "mod_auth_basic is loaded. Disabling..."
    
    # Backup the original configuration file
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    
    # Disable mod_auth_basic module
    sed -i 's/LoadModule auth_basic_module modules\/mod_auth_basic.so/#LoadModule auth_basic_module modules\/mod_auth_basic.so/g' /etc/apache2/apache2.conf
else
    echo "mod_auth_basic is not loaded."
fi

# Check if mod_auth_digest is loaded
if apachectl -M | grep -q 'auth_digest_module'; then
    echo "mod_auth_digest is loaded. Disabling..."
    
    # Backup the original configuration file
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    
    # Disable mod_auth_digest module
    sed -i 's/LoadModule auth_digest_module modules\/mod_auth_digest.so/#LoadModule auth_digest_module modules\/mod_auth_digest.so/g' /etc/apache2/apache2.conf

    # Restart Apache to apply changes
    systemctl restart apache2
    echo "mod_auth_digest module has been disabled."
else
    echo "mod_auth_digest is not loaded."
fi
