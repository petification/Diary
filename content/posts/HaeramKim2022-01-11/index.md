---
title: "Building our own IoT platform (3)"
date: "2022-01-11"
tags:
- "HaeramKim"
---
> NOTE: this notes are from “Build Your Own IoT Platform” by Anand Tamboli. And I can’t speak english very well, so some sentences or word might be inappropriate and might have some misunderstandings.  

## Message Broker
* We have to communicate with devices in a asynchronous way. It is because synchronous communication like HTTP requires condition that all of the participant of the communication must be active. In other words, when client wants to send some data to server, the server must be available. _But asynchronous communication don’t requires that so it can makes participant able to communicate whether or not they are available_.
* This is why we need a Message Broker program that runs on publish-subscribe model like MQTT. By a Message Broker program, we can communicate either device or application with asynchronous way.
* Message Broker must fulfill these criteria:
1. Easy to configure & maintain
2. Stable enough fot the production environment
- - - -
## MQTT
### About MQTT
* Uses publish-subscribe model
* Simple, lightweight protocol
* Design for constraint devices and low-bandwidth, high-latency, unreliable network
* Minimize network bandwidth and device resources while attemping to enhance reliability and delivery.
### Some links you might be interested…
* [Eclipse Mosquitto - Official Doc](https://mosquitto.org) - Mosquitto provides C / C++ library, so we might use them.
* [Eclipse Paho - godev](https://pkg.go.dev/github.com/eclipse/paho.mqtt.golang#section-readme) - Go wrapper for paho(MQTT Client module)
- - - -
## Data Storage
* Message Broker is just a courier of the data; we need to store them for future usage.
* Picture below is a Schema for DB:
![](Chapter%203%20%204/Screen%20Shot%202022-01-11%20at%2010.42.49%20AM.png)
* _ID_ is a primary key for our table. Value for this column will automatically increased so that we don’t have to make additional values for this field.
* _Topic_ is a key for our data packet that devices sent.
* _Payload_ is a value for our data packet. It usually encoded with JSON format to increase flexibility. And also, keep it in mind that MQTT can transport not only ASCII data, but also some binary stream. So, we might have to encode binary stream into Base64 format to store them.
* _Timestamp_ is UNIX time based string. Since we have to store data in a time series, timestamp field is neccesary.
- - - -
## APIs
* Devices or applications which are conected to the data stream that  Message Broker sent can receive live data. But if it goes offline (or not connected), we need to prepare additional data source cause data stream doesn’t works. This is why we prepare some APIs.
### Data access APIs
* This is for accessing data stored in time series DB.
> Additionally, this API helps create linkages between live data streams (MQTT based) and non-live data streams (HTTP based).  
* Here are some API lists we might have to use.
1. **D1**: SELECT a single data record
2. **D2**: SELECT one or more data records in series.
3. **D3**: SELECT one or more data records based on certain conditions.
4. **D4**: INSERT a single data records.
5. **D5**: DELETE a single data record.
6. **D5**: DELETE one or more data records.
7. **D6**: DELETE one or more data records based on certain conditions.
### Utility APIs
* As name suggests, it provides various utilities like data conversion.
* And here are some API lists we might have to use.
1. **M1**: Publish current timestamp. Sometimes, we might have to publish current timestamp to synchronize all the modules in IoT Platform.
2. **M2**: Get current timestamp. It’s useful when device or application misses published timestamp and can’t wait till next publish. And it’s also useful when synchronizing is forced by user or business rules.
3. **M3**: Get a unique random number or string. It’s useful when we need unique value like primary keys or something.
4. **M4**: Get a UUID(Universal Unique IDentifier). It’s similar to M3, but the difference is that UUID must be unique over the system.
### Microservice APIs
* Microservice APIs provide some email, txt messaging services.
> Endpoints that are functionality based or serve a very specific and predefined purpose form part of this group.   
* And here are some API lists we might have to use.
1. **M5**: Send an email.
2. **M6**: Send a text message. It’s kinda duplicated feature compared with M5.
3. **M7**: MQTT Callback registeration. Because MQTT data feed is live, when some device have to communicate only with HTTP, registering callback might be help. When new data is received, platform will notify to the application or device to be able them to send a POST request ASAP.
### Plug-in APIs
* Some of these APIs act as a front-end to mobile or computer applications.
> Some of the interfaces that we will build will patch up two sections of the platform, which otherwise are not connected.  
