---
title: "Chapter 5. Setting Develpment Environment"
date: "2022-01-12"
tags:
- "HaeramKim"
- "BuildYourOwnIoTPlatform"
---
> NOTE: this notes are from “Build Your Own IoT Platform” by Anand Tamboli. And I can’t speak english very well, so some sentences or word might be inappropriate and might have some misunderstandings.  

## Setting Dev-environment
* Register & make instance @ DigitalOcean
	* Ubuntu
	* 2GB RAM, 50GB Disk
	* London data center region
	* Use private networking - This way, if we have multiple cloud instances in the same datacenter, we can directly communicate with other instances without routing the traffic outside of the datacenter.
	* Do not use IPv6
	* Use Monitoring option - This is helpful when you want to monitoring and understanding traffics.
* Initiate firewall via “Uncomplicated Firewall”
	* “Uncomplicated Firewall” is installed in Ubuntu by default
	* Here is some “Uncomplicated Firewall” command that helps us to manage firewall.
	* `ufw app list`: Show all available applications.
	* `ufw allow <application_name>`: Allow that application.
	* `ufw enable`: Run firewall.
	* `ufw status`: Show firewall status.
	* `ufw app info "<application_name>"`: Show information of that application.
	* `ufw allow in "<application_name>"`: It also allows that application. I don’t know the difference between using and not using “in” command.
	* By commands above, allow OpenSSH on firewall.
* Install Apache & Allow “Apache Full” from firewall.
* Install MySQL in secure, and change password for root account.
* Install & configure PHP
* Install phpMyAdmin & securing connection
* Set DNS & update nameserver with domain registrar
	* First, you have to configure in DigitalOcean.
	* Second, you have to modify Apache settings to add virtual host.
	* When one server hosts more than two hosts, like `www.example1.com` and `www.example2.com`…, It is called virtual host
* Install SSL Certificate via Certbot
* Install NodeJS
* Install Node-RED and allow it from firewall
