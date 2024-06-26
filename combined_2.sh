#!/bin/bash

# Function to disable a module
disable_module() {
    local module=$1
    local module_name=$2

    # Check if the module is loaded
    if apachectl -M | grep -q "${module}_module"; then
        echo "${module_name} is loaded. Disabling..."

        # Backup the original configuration file
        cp $APACHE_CONF $APACHE_CONF.bak

        # Disable the module
        sed -i "s/LoadModule ${module}_module modules\/mod_${module}.so/#LoadModule ${module}_module modules\/mod_${module}.so/g" $APACHE_CONF

        # Restart Apache to apply changes
        $APACHE_RESTART
        echo "${module_name} module has been disabled."
    else
        echo "${module_name} is not loaded."
    fi
}

# Function to enable a module
enable_module() {
    local module=$1
    local module_name=$2

    # Check if the module is loaded
    if ! apachectl -M | grep -q "${module}_module"; then
        echo "${module_name} is not loaded. Enabling..."

        # Backup the original configuration file
        cp $APACHE_CONF $APACHE_CONF.bak

        # Enable the module
        echo "LoadModule ${module}_module modules/mod_${module}.so" >> $APACHE_CONF

        # Restart Apache to apply changes
        $APACHE_RESTART
        echo "${module_name} module has been enabled."
    else
        echo "${module_name} is already loaded."
    fi
}
# Detect the system type (Red Hat or Ubuntu)
if [ -f /etc/redhat-release ]; then
    APACHE_CONF="/etc/httpd/conf/httpd.conf"
    APACHE_RESTART="systemctl restart httpd"
elif [ -f /etc/lsb-release ]; then
    APACHE_CONF="/etc/apache2/apache2.conf"
    APACHE_RESTART="systemctl restart apache2"
else
    echo "Unsupported system. This script supports Red Hat and Ubuntu based systems."
    exit 1
fi

# Call the functions with the appropriate arguments
enable_module "log_config" "mod_log_config"
disable_module "dav" "mod_dav"
disable_module "dav_fs" "mod_dav_fs"
disable_module "proxy" "mod_proxy"
disable_module "proxy_http" "mod_proxy_http"
disable_module "userdir" "mod_userdir"
disable_module "info" "mod_info"
disable_module "auth_basic" "mod_auth_basic"
disable_module "auth_digest" "mod_auth_digest"