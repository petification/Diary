---
title: "Chapter 8. Advancing MQTT Broker"
date: "2022-01-18"
tags:
- "HaeramKim"
- "BuildYourOwnIoTPlatform"
---
> NOTE: this notes are from “Build Your Own IoT Platform” by Anand Tamboli. And I can’t speak english very well, so some sentences or word might be inappropriate and might have some misunderstandings.  

## Benefits for WebSocket
### Difference between them
* The Perspective that both protocol supports duplex communications is one common factor, but there’s some differences between them.
* The Purpose of WebSocket is to communicate with server / clients in duplex and live way. But purpose for MQTT is to supprort publish - subscribe model. So, We can tell that WebSocket has more general purpose.
* WebSocket is usually used in WWW (World Wide Web). But, MQTT isn’t common protocol for that.
### Reason for using WebSocket with MQTT
* MQTT’s ability to communicate with duplex way can be achieved with WebSocket. 
* With WebSocket, we can organize web application to publish or subscribe topic with the help of MQTT.
- - - -
## Configuration for MQTT to use WebSocket
* We have to configure mosquitto config file to use port 8443 as secured websocket.
* Add the content below to Mosquitto configuration file.
```
# listen on secure websocket
#   We're gonna use port 8433 for secure websocket communication
listener 8443
protocol websockets

#   Path for certification files
certfile /etc/letsencrypt/live/<your-domain>/cert.pem
cafile /etc/letsencrypt/live/<your-domain>/fullchain.pem
keyfile /etc/letsencrypt/live/<your-domain>/privkey.pem
require_certificate false
tls_version tlsv1.2
```
- - - -
## Securing broker with ACL
* **ACL** is a acronym for “Access Control List”.
* This improves security for broker because it helps managing user accessibility.
> However, this does not prevent legitimate users from snooping around in each other’s data. Moreover, anyone can publish or receive anything, which is rather unacceptable.   
* To enable ACL, first thing to do is specify path of ACL configuration file to `broker.conf`
```
# Add this line to broker.conf
acl_file /etc/mosquitto/conf.d/broker.acl
```
* And add content below to `broker.acl`.
```
# GENERAL
topic read timestamp/#

# USERS
user <Administrator-username>
topic readwrite #

# APPLICATION AS A USER
user <Application-username>
topic read timestamp/#
topic readwrite <topic-name>/%c/#

# PATTERNS
topic read timestamp/#
pattern readwrite users/%u/#
pattern write %c/up/#
pattern read %c/dn/#
```
	* Here’s detailed explanation for it:
### GENERAL
```
topic read timestamp/#
```
* Allow anonymous user to subscribe timestamp and its subtopic.
* But as we prohibited anonymous user from accessing broker, this option will never used.
### USERS
```
user <Administrator-username>
topic readwrite #
```
* Allow administrator to publish or subscribe any topic
### APPLICATION AS A USER
```
user <Application-username>
topic read timestamp/#
topic readwrite <topic-name>/%c/#
```
* Allow user to publish or subscribe for given topic and subtopic that is named Client_ID
* For example, when username `a` connects with Client_ID `aa` and <topic-name> is `testTopic`, user `a` will have permission to publish or subscribe for topic `testTopic/aa/#` (note that # means all).
### PATTERNS
```
pattern readwrite users/%u/#
```
* Allow user that is not specified above to pub-sub only for username/Client_ID specific topic.
* Pattern below is to enable user to pub-sub username specific topic.
* For example, When user with username `a` connects to broker, that guy will have pub-sub permission to topic `users/a/#`.
```
pattern write %c/up/#
pattern read %c/dn/#
```
* Pattern below is to enable user to pub-sub Client_ID specific topic.
* For example, When user uses Client_ID `aa`, that guy will have publish permission to topic `aa/up/#`and subscribe permission to topic `aa/dn/#`.
### ACL Priority
* **GENERAL** Setting has a top-priority, but we’ve blocked all the anonymous user so broker will ignore it.
* **PATTERN** Setting overrides **USER** Setting; So, if PATTERN Setting is configured, broker will allow user regardless of USER Setting.
* Thus, the following scenarios could occur.
1. Scenario 1
	* General settings = blank or configured 
	* User settings = blank 
	* Pattern settings = blank 
	* The result is access to all topics denied. 
2. Scenario 2 
	* General settings = blank or configured 
	* User settings = configured 
	* Pattern settings = blank 
	* The result depends on the user settings; the broker ignores general settings. 
3. Scenario 3 
	* General settings = blank or configured 
	* User settings = blank or configured 
	* Pattern settings = configured 
	* The result is pattern settings override user settings. 
