#!/bin/bash

# Define the Apache configuration file and the user and group to run Apache
APACHE_CONF="/etc/apache2/apache2.conf"
APACHE_USER="apache"
APACHE_GROUP="apache"

# Check if the Apache user and group exist
if ! id -u $APACHE_USER > /dev/null 2>&1; then
    echo "Creating user $APACHE_USER..."
    useradd -r $APACHE_USER
fi

if ! grep -q "^$APACHE_GROUP:" /etc/group; then
    echo "Creating group $APACHE_GROUP..."
    groupadd -r $APACHE_GROUP
fi

# Check if Apache is running as root
if grep -q "^User root" $APACHE_CONF && grep -q "^Group root" $APACHE_CONF; then
    echo "Apache is running as root. Changing to run as $APACHE_USER..."

    # Backup the original configuration file
    cp $APACHE_CONF $APACHE_CONF.bak

    # Change Apache to run as the non-root user and group
    sed -i "s/^User root/User $APACHE_USER/" $APACHE_CONF
    sed -i "s/^Group root/Group $APACHE_GROUP/" $APACHE_CONF

    # Restart Apache to apply changes
    systemctl restart apache2
    echo "Apache is now running as $APACHE_USER."
else
    echo "Apache is already running as a non-root user."
fi