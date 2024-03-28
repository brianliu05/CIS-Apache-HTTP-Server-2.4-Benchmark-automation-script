#!/bin/bash

# Check if mod_proxy is loaded
if apachectl -M | grep -q 'proxy_module'; then
    echo "mod_proxy is loaded. Disabling..."
    
    # Backup the original configuration file
    cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
    
    # Disable mod_proxy and other proxy modules
    sed -i 's/LoadModule proxy_module modules\/mod_proxy.so/#LoadModule proxy_module modules\/mod_proxy.so/g' /etc/apache2/apache2.conf
    sed -i 's/LoadModule proxy_http_module modules\/mod_proxy_http.so/#LoadModule proxy_http_module modules\/mod_proxy_http.so/g' /etc/apache2/apache2.conf
    # Add other proxy modules as needed

    # Restart Apache to apply changes
    systemctl restart apache2
    echo "mod_proxy and related modules have been disabled."
else
    echo "mod_proxy is not loaded."
fi
