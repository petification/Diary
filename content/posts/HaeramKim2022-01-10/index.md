---
title: "Chapter 2. Components for IoT Solution"
date: "2022-01-10"
tags:
- "HaeramKim"
- "BuildYourOwnIoTPlatform"
---
> NOTE: this notes are from “Build Your Own IoT Platform” by Anand Tamboli. And I can’t speak english very well, so some sentences or word might be inappropriate and might have some misunderstandings.  

## Ingredient for an IoT Solution
### The difference between IoT Solution, Application and Platform
* **IoT Solution**: It means overall system that covers physical things to end user application.
> IoT solution usually means an end-to-end product, service, or a mix of both.  
* **IoT Application**: It means software that is connected to an user and interact with them.
> IoT application usually refers to IT software or a mobile application, or a combination of both.   
* So we can think IoT Application as a kind of subset of IoT Solution.
* **IoT Platform**: We can think that that as a system that connects physical object with application.
> it sits on the edge of IoT applications and is usually a borderline system to deal with physical objects—a.k.a. things and software systems.   
### The functional blocks of an IoT Solution
![](Building%20our%20own%20IoT%20platform%20(2)/Screen%20Shot%202022-01-09%20at%205.16.26%20PM.png)
* **Devices**: Device is the object that performs collecting data, doing some actions, or both.
	* Part of a device that collects data is called _Sensor_. Thus, we can think that sensor is the input for an IoT Solution. Sensors are _connected_ to the device in the past, but modern IoT devices usually _integrates_ them.
	* And part of a device that does some actions is called _Actuator_. So, we can think that actuator is the output for an IoT Solution.
* **Gateway**: Purpose of gateways is usually to communicate with upstream layers.
> _Gateways_are edge devices that can communicate with the upstream system in one of two ways: with or without a gateway.   
   
* Thinking of that, the term _Upstream_ and _Downstream_ might be confusing a little bit. _Upstream layer(system)_ usually means server of IoT Solutions and _Downstream layer(devices)_ usually means device(things). So it can be said that device pushes data they collected to _upstream layer_ and server controls _downstream device_ to do some actions.
* Some devices are able to communicate with upstream layer via Internet Protocol(IP) by itself. But not all devices has to be like that: you can organize devices communicate with gateways via another protocol like Bluetooth, and then let that gateway communicates with upstream layer.
* In addition to the communication, some gateways are able to perform some computing stuff such as, data segregation, clean up, and so on.
* **IoT Platform**: The main feature for the IoT Platform is _orchestrator of the IoT Solution_. They are responsible for ingesting data from IoT device at a very high speed and for storing that data in a time series with structured format to process and analyze.
> This block is responsible for communicating with downstream devices and ingesting large amounts of data at a very high speed. The platform is also responsible for storage of the data in a time series and structured format for further processing and analysis.   
* **Application**: The main purpose for application is to provide user an interface to manage IoT Solution (This is why they call it _Dashboard_). Usually it’s implemented with GUI, and runs on desktop, mobile, or both. Thus, they have to request some data (like status) to platform to show user an information.
* Additionally, these applications sometimes communicates with other applications on interface-level and integrates data.
> Additionally, these applications integrate with other systems and applications at the interface level and enable interapplication data exchange.  
- - - -
## The Detailed Explanation for the Element of IoT Platform
![](Building%20our%20own%20IoT%20platform%20(2)/Screen%20Shot%202022-01-10%20at%2010.35.14%20AM.png)
* Nodes in picture above are functional requirements platform have to has, and edges indicates data flow relationships.
* Most of the platforms are installed in virtual server or cloud, and runs on linux-based OS.
### Message Broker, Message bus
* The main role for this functional block is to communicate with devices. To support multiple purpose, this block has to deal with multiple protocols.
	* For example, if device suports WiFi communication, you might have to prepare REST API.
	* And if you need publish-subscribe communication, you might prepare MQTT-based message broker.
	* And also, if you need long-distance communication, you might have to prepare LoRaWAN and so on.
* So, we can say that this module encapsulates the feature that coummunicates with device. By isolating message broker, we can communicate with device on protocol, medium of communication agnostic way.
* And also, **Message Bus** is kinda channel that every other module shares. When Message broker gets a message, it pushes that message to the message bus, and all other modules are gonna use it.
> Regardless of the medium of communication, network type used, and protocols in play, the message broker’s job is to consolidate the data in a unified manner and push it to the common message bus.   
### Communication Management
* This module performs data refinement and context-addition.
	* As an example, this module converts type of the message, such as, binary to ASCII, CSV to JSON, and so on.
	* And also, they performs elimination of duplicated data. When any data that is duplicate or not useful, Communication manager will discard it.
	* Eliminating duplicates are dependent on device(or sensor) types and they might be implemented case-by-case.
* After converting data, Communication manager re-broadcasts it to message bus to be able to use in other modules.
> The functionality of enriching existing data messages, rebroadcasting them to the message bus, publishing additional contextual information and other messages after the main message arrives, and tagging them as appropriate is the job of the communication management module.   
### Time-Series Storage and Data Management
* As the name suggests, they stores data that is available on message bus in time-order. It is very important job, because sometimes communcation manager or message brocker itself needs the recent data to deal with current data flow.
> For many IoT applications, users prefer to extract the data away from the IoT platform and store it in an application data warehouse for further processing. Therefore, it is often utilized for interim storage of the device data and is not meant for large-sized dataset storage.   
### Rule Engine
* The main role for this module is that saves rules or conditions that triggers event, and when that condition is accomplished, publishes event over the platform.
* To accomplish this role, rule engine is constantly listening to the message bus to catch the data that triggers events.
> For example, a typical rule engine function may look like this: “Trigger and broadcast alert message when the downstream device sends a data packet containing the keyword ka-boom.”   
* This module also helps communication manager in the way that refines, decodes and enriches existing or receiving data.
### ReST API Interface
* Unlike Message Broker, ReST API Interface is useful when communication does not have to be in real-time. Because, it’s better to use simple HTTP communication when real-time is unnecessary.
* To broadcast the received data, it often cooperates with Message Broker and Communication Manager and with database to response time-series record for the request.
> This response may contain additional information for the sensor to do its job in a certain way for the next round.   
* This module also used to provide API to application level. It can coordinates records and responses whenever application requests.
* And also, this module can be used to configure or trigger rules at a application level. That is, it makes user able to configure rules or trigger events by GUI application.
> This also makes it possible for downstream devices to utilize the same functionality, which could be handy when devices need to initiate certain workflows automatically in place of application triggers.  
> A good example is a smart lock; for instance, when there is activity at the front door that needs the homeowner’s attention when she is away from home. An upstream application may notify the user when the smart lock reports activity, and then expects the user to respond or react for further steps. If the user is not available, then the application can trigger the rule for predefined actions. If the severity of the alert is relatively high, then the device may be configured to not wait for user action or response, but directly trigger the default workflow (e.g., notifying security, etc.).  
### Microservices
* It’s simple; The purpose of this block is to coordinate all the blocks to function more effectively.
* Moreover, Fuctionalities that is used often can be placed in this block. These functionality can be used not only in microservices module, but also in other modules.
### Device Manager
* When a lot of devices are attached to the platform, it’s hard to track all of ‘em. In these case, Device Manager can help tracking all the devices such as tracking device’s activation status and battery status.
* And also, with the Device Manager, we can manage permission for accessing devices. That is, we can manage which user has a permission to a certain device.
### Application and User Manager
* This block is similar with Device Manager, but the deference is that it manages users, not devices. Thus, the main purpose for this block can be something like managing user login (and password), API Keys that allows user to use API that ReST API Interface block provides.
* It seems more closer to upstream application, but it’s neccesary block for IoT platform cause binding this functionality to an IoT platform makes it more comfortable. I can’t get what they’re talking about, so skip it.
> While it may appear to be more of an application-level functionality, it remains in an IoT platform’s interest to bind it as a platform function, so that it is integrated tightly with the overall architecture and set of things. IoT is the system of systems, and heterogeneous systems are a fact of this phenomenon. Letting these system functions get out of sync is the last thing that you want to happen with IoT solutions.   
### Nice-to-haves and Must-to-haves
* These are Must-to-haves that you must implement:
1. Device (Edge) Interface / Message Broker
2. Message Router / Communication Module
3. Data Storage
4. Device Manager
5. Rule Engine
* And these are Nice-to-haves:
1. ReST API Interface
2. Microservices
3. Application / User Manager
* You don’t have to implement Nice-to-haves. These blocks makes life more easier, but it’s not neccesary and you have to implement them only if time and resources are permitted.
### Steps to build our own platform
1. Setting up the cloud environment for the platform.
2. Device (Edge) Interface / Message Broker
3. Time-series DB
4. ReST API Interface
5. Message router / Communication module
6. Microservices
7. Iterating and testing all the blocks we made to stabilize them
8. Rule Engine
9. Device Manager
10. Application / User Manager
