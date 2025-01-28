#!/bin/bash

# Prompt user for configuration variables
read -p "Enter the domain name (e.g., example.com): " DOMAIN
read -p "Enter the organization name: " ORG
read -p "Enter the administrator password: " ADMIN_PASSWORD

echo "\n"
LDAP_BASE="dc=$(echo $DOMAIN | sed 's/\./,dc=/g')"

# Update packages and install OpenLDAP and utilities
sudo apt update && sudo apt install -y slapd ldap-utils

# Configure administrator password
ENCRYPTED_PASSWORD=$(slappasswd -s $ADMIN_PASSWORD)

# Configure OpenLDAP database
echo "dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=admin,$LDAP_BASE

" > db.ldif

echo "dn: olcDatabase={2}mdb,cn=config
changetype: modify
add: olcRootPW
olcRootPW: $ENCRYPTED_PASSWORD
" >> db.ldif

sudo ldapmodify -Y EXTERNAL -H ldapi:// -f db.ldif

# Create base.ldif file for LDAP directory structure
echo "dn: $LDAP_BASE
objectClass: top
objectClass: dcObject
objectClass: organization
o: $ORG
dc: $(echo $DOMAIN | cut -d. -f1)

" > base.ldif

echo "dn: cn=admin,$LDAP_BASE
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator
userPassword: $ENCRYPTED_PASSWORD
" >> base.ldif

# Apply configuration
sudo ldapadd -x -D "cn=admin,$LDAP_BASE" -w $ADMIN_PASSWORD -f base.ldif

echo "---------------------------------------------------------------------------"
echo "---------------------------------------------------------"

echo "OpenLDAP has been installed and configured in $DOMAIN server"
echo "The admin password is $ADMIN_PASSWORD"

echo "---------------------------------------------------------"
echo "------------------------------------------------------------------------------"
