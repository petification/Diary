---
title: "Chapter 6. The Message Broker"
date: "2022-01-12"
tags:
- "HaeramKim"
- "BuildYourOwnIoTPlatform"
---
> NOTE: this notes are from “Build Your Own IoT Platform” by Anand Tamboli. And I can’t speak english very well, so some sentences or word might be inappropriate and might have some misunderstandings.  

## Pub-Sub Paradigm
* **Publishing** is similar with _Sending_. In other words, _Publishing some data_ means _Sending some data_. Thus, **Publisher** is same with _sending client_.
* **Subscribing** is similar with _Receiving_. That is, _Subscribing some data_ has the same meaning with _Receiving some data_. Thus, **Subscriber** is the _client who receives some data_.
* This paradigm decouples Publisher with Subscriber and they’re connected by intermediate node, the Broker.
### Advantages
* _Not all clients for broker doesn’t have to connected to the broker._
* _Client synchronization is not mandatory_. They can publish some data or be subscribed in asynchronized way.
- - - -
## MQTT
### Client
* _All of the things that is connected to broker can be called **Client**_. That is, not only sensors and actuators, but also applications can be one of ‘em.
### Broker
* And _Broker of MQTT integrates all the clients and helps their communication in a Pub-Sub paradigm_
* Since broker is the key for overall communication, _Broker must be reliable and easy to deploy, monitor and maintain_.
### QoS
* _The term **QoS** means **Quality of Service**_.
	1. **QoS 0**: Packet will be arrived _at most once_ - It’s possible that packet is lost while communication.
	2. **QoS 1**: Packet will be arrived _at least once_ - So, it means that possibility for duplicated packet is present.
	3. **QoS 2**: Packet must be arrived _exactly once_.
* This is kinda _reliability of communication_, but the difference is that we can choose one of them.
	* In other words, when connectivity is reliable and miss rate is relatively low, QoS 0 is appropriate choice.
	* Similarly, when connectivity is unreliable and possibilities for packet loss is very high, choosing QoS 2 must be considered.
* We can think _QoS as a degree of importantness_.
	* When packet isn’t important and makes no side-effects if we misses it, then QoS 0 is better choice than others.
	* Contrary, when packet is very important and must not be missed, then QoS 2 must be considered.
* QoS 1 is the optimum choice because duplicated packet can be handled in receiver side.
### Handling connection
* For client to publish & subscribe some data, they need to be stay connected to the broker. But when connection is breaked unintentionally, there is no way for broker to know that client is still alive. This is called **Half-open Connection**. To avoid this, kinda connection handling is required.
* **Keep Alive Period** is the maximum interval between two points that packet is sent by a client. In other words, when Keep Alive Period is 100 and last packet is sent at time 300, then next packet must be sent before the time 400.
	* If client don’t have any packet to send, then it must send **PINGREQ**. Purpose for sending **PINGREQ** to broker is to notify the broker that client is still alive.
	* When Keep Alive Time is expired and client didn’t send a PINGREQ, Broker will think that there are some problems and shut the connection down. This is called **Ungraceful disconnection**. And when this happens, Broker will send a **LWT(Last Will and Testament)** to all the subscribers.
	* **LWT(Last Will and Testament)** is a message that will be sent and to broker at the connection stage. Broker will saves this message and when one publisher goes to ungraceful disconnection state, this message will be sent to the all subscribers.
	* But since broker is not for storing data, additional flag is needed to notify the broker to save that message. It’s called **Retained Message**. When message is arrived with **Retained Message** flag, broker will saves that message until client wants to overwrite it. This message is saved with topic, so that broker knows what message should be overwrited, or be sent to the subscribers. 
### WebSocket
* When communicating with applications, it’s hard to use HTTP because it runs on request-response model fundamentally. For bidirectional communication, we might have to use another protocol and WebSocket might be great.
* Additionally, WebSocket runs with TCP, and that is what MQTT runs on too. So, using WebSocket is more easier way for us to build IoT Platform.
### Pros & Cons
#### Pros
* Lightweight: MQTT can runs on low-bandwidth, low-capacity of battery environment.
* Bidirectional: Both client and broker initiates the communication.
* Liveness / Event-driven: When application needs live monitoring or something like that, MQTT might be a great choice.
#### Cons
* When number of clients is increased, then communication rate will increased parabolically.
	* For example, when 2 clients are attached to broker, and all of the clients subscribes all of the topic, then when one client publishes data, two data tranfer will happen (Client1 -> Broker, Broker -> Client 2) and vice versa. So, total number of transfer is 4.
