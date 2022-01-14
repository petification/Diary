---
title: "Chapter 5. Setting Develpment Environment"
date: "2022-01-12"
tags:
- "HaeramKim"
- "BuildYourOwnIoTPlatform"
---
> NOTE: this notes are from “Build Your Own IoT Platform” by Anand Tamboli. And I can’t speak english very well, so some sentences or word might be inappropriate and might have some misunderstandings.  

## Settings that is best for us
### Cloud instance
* Register & make instance @ DigitalOcean
	* Ubuntu(18.04 x64)
	* Basic plan - 4GB RAM, 50GB Disk, Dual-core(Regular Intel)
	* NY Data-storage region
	* Authenticate with password
	* IPv6, Monitoring, User data option enable
### Firewall settings
* Initiate firewall via “Uncomplicated Firewall”
	* “Uncomplicated Firewall” is installed in Ubuntu by default
	* Here is some “Uncomplicated Firewall” command that helps us to manage firewall.
	* `ufw app list`: Show all available applications.
	* `ufw allow <application_name>`: Allow that application.
	* `ufw enable`: Run firewall.
	* `ufw status`: Show firewall status.
	* `ufw app info "<application_name>"`: Show information of that application.
	* `ufw allow in "<application_name>"`: It also allows that application. I don’t know the difference between using and not using “in” command.
* Allow OpenSSH from firewall
### Apache2 server
* Install Apache2
```
apt update
apt install apache2
```
* Allow “Apache Full” from firewall
```
ufw allow in "Apache Full"
```
* Apache uses port `80` for HTTP and port `433` for HTTPS
* If everything’s gonna be fine, apache ubuntu default page must be shown when you enter your IP address on your browser.
### MySQL
* Install MySQL installer
```
apt install mysql-server
```
* Install MySQL with secure version
```
mysql_secure_installation
```
	* This will prompt additional configuration console.
	* You have to select `0(LOW)` for `password validation policy`.
* Setting administration account for MySQL
	* This is how to enter MySQL Shell:
```
mysql
```
	* Query for showing all root account:
```
SELECT user,authentication_string,plugin,host FROM mysql.user WHERE user="root";
```
	* Query for modifying password for root account:
```
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$YOUR_PASSWORD';
FLUSH PRIVILEGES;
```
	* And this is expected result when you type show-root query:
```
| user | authentication_string | plugin | host |
| root | *A0AF1999141933B3B4C7 
AE72544AB01849669F98 | mysql_native_password| localhost |
```
### PHP
* Installing PHP
```
apt install php libapache2-mod-php php-mysql 
```
* Configuring PHP
	1. Open configuring file that is exists in `/etc/apache2/mods-enabled/dir.conf`
	2. Edit that file to:
```
<IfModule mod_dir.c>
DirectoryIndex index.php index.html index.htm index.cgi index.pl index.xhtml 
</IfModule>
```
	3. Restart apache2 server
```
systemctl restart apache2
```
	4. Test whether the server works correctly:
```
vi /var/www/html/test.php
# And add php script below to it
<?php
     echo "php ok";
?>
```
### PHPMyAdmin
* This is a tool that allows developers to access DB.
* Install PHPMyAdmin:
```
apt update
apt install phpmyadmin php-mbstring php-gettext
```
	* NOTE: php-gettext is not stable in Ubuntu 20.04. This is why you have to choose Ubuntu 18.04 when creating droplet.
	* While Installing PHPMyAdmin, several configuration console might be prompted. Here is recommened selection:
```
# Configure database for phpmyadmin with dbconfig-common 
Yes

# What kind of server do you plan to use
Apache2 # You have to tap spacebar to select this opiton.

# Communication
Unix socket

# Set database name, username, password on your own
# Some errors might be occured when you select password policy to MEDIUM(1) or HIGH(2). That's why you have to choose LOW(0) when you select policies.
```
* Configure plugin && restart server
```
phpenmod mbstring
systemctl restart apache2
```
* Securing PHPMySQL
	* We’re gonna use `htaccess`feature of apache to securing it.
```
# Open /etc/apache2/conf-available/phpmyadmin.conf and modify to:
Alias /phpmyadmin /usr/share/phpmyadmin
<Directory /usr/share/phpmyadmin>
	Options SymLinksIfOwnerMatch
	DirectoryIndex index.php
	AllowOverride All 
.....
.....
```
	* Add following contents to the file
```
# Open /usr/share/phpmyadmin/.htaccess
AuthType Basic
AuthName "Restricted Files"
AuthUserFile /etc/phpmyadmin/.htpasswd
Require valid-user
```
	* Set admin password
```
htpasswd -c /etc/phpmyadmin/.htpasswd $USERNAME
# And then entering password line will be prompted
```
### DNS
* Use noip.com to register custom free domain
* Set destination IP as droplet instance uses.
* Register domain to DigitalRecord and create new record with Type A.
### Virtual Host
* I don’t know what exactly virtual host means, but i think when one server hosts more than two hosts, like `www.example1.com` and `www.example2.com`…, It is called virtual host
```
mkdir -p /var/www/<your-domain>/html
chown -R $USER:$USER /var/www/<your-domain>/html
chmod -R 755 /var/www/<your-domain>
```
* Make main index file
```
# Make index.php in /var/www/<your-domain>/html/
# And then add following contents to the file:
<?php
     echo("Hi...this is our webpage with domain name !");
?>
```
* Make virtual host file
```
# Make <your-domain>.conf file in /etc/apache2/sites-available/
# And then add following contents:
<VirtualHost *:80>
	ServerAdmin admin@<your-domain>

	ServerName <your-domain>
	ServerAlias www.<your-domain>

	DocumentRoot /var/www/<your-domain>/html

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
	* And then enable virtual host:
```
a2ensite <your-domain>.conf
a2dissite 000-default.conf

# Typing command below must prints "Syntax OK"
apache2ctl configtest

# Restart server
systemctl restart apache2
```
### SSL Certificates
* Install SSL Certificates via `Let’s Encrypt` and `Certbot`.
```
add-apt-repository ppa:certbot/certbot
apt install python-certbot-apache
```
* Certificate our site
```
# When you registered www-prefixed domain
# like "www.example.com", add "www.<your-domain>" too.
certbot --apache -d <your-domain>
```
	* After this command runs, you have to enter email address for notification and agree with policy stuff.
	* And also, you have to select "redirect" option when selection console is prompted.
	* When messages saying "Congratulations!" is printed, it's done.
	* You can verify the Certificate with `http://www.ssllabs.com/ssltest/analyze.html?d=<your-domain>` page.
### NodeJS & NodeRED
* To install NodeJS to Ubuntu, you have to register NodeJS official repository to apt first.
```
# Register repository
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -

# Install NodeJS & NPM
apt install nodejs

# Verify installation (Check version)
nodejs -v
npm -v
```
* Install NodeRED
```
npm install -g --unsafe-perm node-red
```
* Allow NodeRED from firewall. NodeRED uses port `1880`.
```
ufw allow 1880/tcp
```
* Configure NodeRED Setting
	* You can get settings.js file from [Here](https://github.com/knewron-technologies/in24hrs)
	* path for old settings.js file is `/root/.node-red/settings.js`. You have to overwrite this file.
* Securing NodeRED
	1. Get a hashed-password
```
# Install tool
npm install -g node-red-admin

# Get hashed password
node-red-admin hash-pw
```
	* After typing the last command, password input console will be shown. Enter a password u like.
	* And then, hashed password will be printed to the console. Copy it to paste in `settings.js`.
	2. Modify `settings.js`
```
# Open settings.js and modify it to:
adminAuth: {
	type: "credentials",
	users: [
		{
			username: "<your-username>",
			password: "<hashed-password>",
			permissions: "*"
		},
	] 
}, 
...
```
* Run NodeRED on background with logging
```
node-red > node-red.log &
```
