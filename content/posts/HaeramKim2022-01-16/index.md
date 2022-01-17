---
title: "Chapter 7. Building the Critical Components"
date: "2022-01-16"
tags:
- "HaeramKim"
- "BuildYourOwnIoTPlatform"
---
> NOTE: this notes are from “Build Your Own IoT Platform” by Anand Tamboli. And I can’t speak english very well, so some sentences or word might be inappropriate and might have some misunderstandings.  

## Creating DB
* Before creating DB, you have to access PHPMyAdmin with root account.
### Database
1. Tap `Databases`
2. Set Database name to “tSeriesDB” with “Collaton
3. Press `Create`
### User
1. In that database, press `Privileges`
2. Goto `Add user account`
3. Fill out `login information` (`Generate password` is optionary)
4. Check all `Global privileges`
5. Press `Go` btn.
### Table
1. Press`Create table`
2. Set name as “thingsData” and `Number of data` as 5
3. Set columns like:
```
NAME		TYPE	LEN		DEFAULT		INDEX			A_I
ID		INT		11		NONE		PRIMARY_KEY		ENABLE
TOPIC		VARCHAR	1024	NONE
PAYLOAD	VARCHAR	2028	NONE
TIMESTAMP	VARCHAR	15		NONE
DELETED	BINARY	1		AS DEFINED:0
```
4. And `save`
- - - -
## Installing MySQL Plugin for NodeRED
1. Run NodeRED
2. Goto `Manage Palette` in NodeRED menu
3. Goto `Install` Menu -> Install `node-red-node-MySQL`
- - - -
## Make “Publish Periodic Timestamp” Functionality
* This functionality is corresponded with **M1** API.
![](index/Screen%20Shot%202022-01-16%20at%207.45.50%20PM.png)
* `inject` node: Make sure that `msg.payload` be “timestamp” and set `repeat`to `interval` with every 15 seconds.
* `debug` node: There’s no required configuration.
* `MQTT out` node: 
	* `Server`: 
		* `Connection`:
			* Server: `localhost` with port `1883`
			* Protocol: `MQTT V3.1.1`
			* Client ID: `node-red`
			* Keep Alive: 60
		* `Security`: Enter your MQTT username and password.
	* `Topic`: `timestamp`
- - - -
## Make “Publish by ReST/POST” API
* This functionality is to publish some topic:payload with HTTP/ReST. This is neccesary because some circumstances, you can’t use MQTT to publish some data. And this is also helpful when you want to test the platform working as expected.
![](index/Screen%20Shot%202022-01-16%20at%207.56.42%20PM.png)
* `HTTP in` node: Set `method` to `POST` and `URL` to `/pub/:topic/:payload`
* `function` node:
	* Remember that `msq.req` stores all the parsed data from HTTP request
	* So, to use HTTP request parameters, you have to use `msg.req.params`
	* And also, return value for `function` node is `msg`. Thus, you have to store return value to `msg`.
```
msg.topic = msg.req.params.topic.toString();
msg.payload = msg.req.params.payload.toString();
msg.qos = 2;
msg.retain = false;

return msg;
```
* `MQTT out` node: Basic server configurations are already setted. So, just fill out the `topic` to “mqtt”.
* Another `function` node: 
```
msg.payload = {
    success: true,
    message:"published: " +
            msg.req.params.topic + 
            "/" + 
            msg.req.params.payload
};

return msg;
```
* `HTTP response` node: No configurations are neccesary.
- - - -
## Make “Subscribe & DB/INSERT Everything” Functionality
* This functionality is to store all the published data to the DB.
![](index/Screen%20Shot%202022-01-16%20at%208.20.09%20PM.png)
* `MQTT in` node: Set topic to `#` to subscribe all kind of topic and set `QoS` to 2 to filtering important data.
* `function` node: This node makes SQL query for DB.
```
// Create query
// get microtime
var timestamp = new Date().getTime()/1000;
// pad it with trailing zeroes
timestamp = timestamp.toString() + "000";
// trim to exact length 10 + 1 + 3
timestamp = timestamp.substring(0, 14);

var strQuery =  "INSERT INTO thingsData (topic, payload, timestamp, deleted)" +
                "VALUES ('" + escape(msg.topic) + "','" + escape(msg.payload) + "','" + timestamp + "', 0);";
msg.topic = strQuery;

return msg;
```
* `mysql` node: Set database property to:
	* Host: `127.0.0.1`
	* Port: `3306`
	* User: user that can access to DB you made.
	* Password: password of that user.
	* Database: Database you made for this platform.
* `debug` node: No configurations required.
- - - -
## Make “REST/GET one or more records from DB” Functionality
* This functionality corresponses to **D1** and **D2** API.
![](index/Screen%20Shot%202022-01-16%20at%208.26.41%20PM.png)
* `HTTP in` node: Set method to `GET` and set URL to `/record/:topic`
* Another `HTTP in` node: Set method to `GET` and set URL to `/records/:topic/last/:count`
* `function` node: 
```
// Create query

// if required record count is not specified
// set default to 1
if(!msg.req.params.count) {
    msg.req.params.count = 1;
}

// build the sql query
msg.topic =
    "SELECT id,topic,payload,timestamp " +
    "FROM thingsData " +
    "WHERE topic='" + escape(msg.req.params.topic) + "' " +
    "AND deleted=0 " +
    "ORDER BY id DESC " +
    "LIMIT " + msg.req.params.count + ";";

return msg;
```
* `mysql`, `function`, `http response` node: No configuration required.
