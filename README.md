# OPENLDAP-Installer
Script in bash that install a openldap-server 
<hr>
# OpenLDAP Installation Script

This repository contains a Bash script to install and configure OpenLDAP on a Debian-based system. The script prompts the user for necessary configuration details and sets up an LDAP server.

## Features
- Installs OpenLDAP and required utilities.
- Configures the LDAP database with user-provided domain and organization details.
- Sets up an administrator account with a secure password.
- Creates an initial LDAP directory structure.

## Prerequisites
- A Debian-based system (e.g., Ubuntu).
- Root or sudo access.
- Internet connection for package installation.

## Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/your-username/openldap-installer.git
   cd openldap-installer
   ```
2. Make the script executable:
   ```sh
   chmod +x openldap_install.sh
   ```
3. Run the script:
   ```sh
   ./openldap_install.sh
   ```
4. Follow the prompts to enter your domain, organization, and admin password.

## Usage
Once installed, you can manage LDAP using `ldapsearch`, `ldapadd`, and other utilities:
```sh
ldapsearch -x -LLL -H ldap:/// -b "dc=example,dc=com"
```
Replace `example.com` with your configured domain.

## License
This project is licensed under the MIT License.

## Contributions
Feel free to submit issues or pull requests to improve this script.

## Author
[Jaime Galvez Martinez](https://github.com/TheHellishPandaa)

