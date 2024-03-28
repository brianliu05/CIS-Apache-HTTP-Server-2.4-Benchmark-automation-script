#!/bin/bash

# Check if mod_log_config is loaded
if ! apachectl -M | grep -q 'log_config_module'; then
    echo "mod_log_config is not loaded. Enabling..."
    
    # Backup the original configuration file
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    
    # Enable mod_log_config module
    echo "LoadModule log_config_module modules/mod_log_config.so" >> /etc/apache2/apache2.conf

    # Restart Apache to apply changes
    systemctl restart apache2
    echo "mod_log_config module has been enabled."
else
    echo "mod_log_config is already loaded."
fi
