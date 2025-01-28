# Script de Instalación de OpenLDAP

Este repositorio contiene un script en Bash para instalar y configurar OpenLDAP en un sistema basado en Debian. El script solicita al usuario los detalles de configuración necesarios y configura un servidor LDAP.

## Características
- Instala OpenLDAP y las utilidades necesarias.
- Configura la base de datos LDAP con el dominio y la organización proporcionados por el usuario.
- Crea una cuenta de administrador con una contraseña segura.
- Genera una estructura inicial del directorio LDAP.

## Requisitos Previos
- Un sistema basado en Debian (ej., Ubuntu).
- Acceso root o permisos sudo.
- Conexión a Internet para la instalación de paquetes.

## Instalación
1. Clona este repositorio:
   ```sh
   git clone https://github.com/your-username/openldap-installer.git
   cd openldap-installer
   ```
2. Haz el script ejecutable:
   ```sh
   chmod +x openldap_install.sh
   ```
3. Ejecuta el script:
   ```sh
   ./openldap_install.sh
   ```
4. Sigue las instrucciones para ingresar tu dominio, organización y contraseña de administrador.

## Uso
Una vez instalado, puedes administrar LDAP usando `ldapsearch`, `ldapadd` y otras utilidades:
```sh
ldapsearch -x -LLL -H ldap:/// -b "dc=example,dc=com"
```
Reemplaza `example.com` con tu dominio configurado.

## Licencia
Este proyecto está licenciado bajo la Licencia MIT.

## Contribuciones
Siéntete libre de enviar issues o pull requests para mejorar este script.


