#!/bin/bash

# Solicitar variables de configuración al usuario
read -p "Ingrese el nombre de dominio (ejemplo: example.com): " DOMAIN
read -p "Ingrese el nombre de la organización: " ORG
read -s -p "Ingrese la contraseña de administrador: " ADMIN_PASSWORD

echo "\n"
LDAP_BASE="dc=$(echo $DOMAIN | sed 's/\./,dc=/g')"

# Actualizar paquetes e instalar OpenLDAP y herramientas
sudo apt update && sudo apt install -y slapd ldap-utils

# Configurar contraseña de administrador
ENCRYPTED_PASSWORD=$(slappasswd -s $ADMIN_PASSWORD)

# Configurar la base de datos de OpenLDAP
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

# Crear archivo base.ldif para la estructura del directorio LDAP
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

# Aplicar configuración
sudo ldapadd -x -D "cn=admin,$LDAP_BASE" -w $ADMIN_PASSWORD -f base.ldif

echo "OpenLDAP ha sido instalado y configurado."
