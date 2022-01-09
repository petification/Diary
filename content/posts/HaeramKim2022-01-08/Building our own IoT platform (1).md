---
title: "Building our own IoT platform (1)"
date: "2022-01-08"
tags:
- "HaeramKim"
---

## Reason for doing this
* There are several reasons for making your own IoT platform
1. When you use commercial platform solution like AWS, Google Cloud Platform and Microsoft Azure provides, it’s not easy to predict the cost for using it. And this often makes you to pay absurd price.
2. If you think about free-tier solution to avoid problem above, you have to think about depency of that solution. That is, when your system is relied on free-tier solution too much, it’s hard to transfer to another platform and also, when free trial gets expired, you have to pay them for using solution after all.
3. Building your own IoT platform also makes you to build the most essential feature, and than expend it whenever another features are needed.
4. Lastly, making your own platform means you have all the controls and flexibility over the system.
- - - -
## The understanding of IoT platform
* IoT echosystem consists of these three factors: (1) Object that has some sort of computing power and is connected to internet, (2) Application that user can take control, (3) Middleware that connects object with application.
* In this project, we uses the term IoT platform as an Middleware of IoT Echosystem. Thus, IoT platform is where objects first meet the internet and where before the application or software takes control.
> While there is no strict definition for what we can call an IoT platform, there is a general expectation that the platform will help high-level software, applications, and systems interact with lower-level protocols, methods of communication, and heterogeneous objects overall   
- - - -
## Must-haves for any platform
* **Scalability**: Platform must be reasonably easy to scale up the whole system. It means it has to be easy to scale up without modifing existing functionalities or production setup.
* **Reliability**: Platform must be reliable. But degree of reliability varies system to system, for example, platform for finance or military should be very reliable.
* **Customization**: Platform must be customizable. If platform is not customizable, person who uses that platform may design their products or services to fit for that platform, which is essentially working in the reverse direction.
* **Protocol, interface support**: Since definition of platform is the system that coordinates objects and end user interface, Platform should support various protocols and interfaces to deal with platform user’s needs.
> Additionally, it needs the ability to create the required plugin and fill the gap whenever required, such that the middleware platform remains accommodating, for a very long time, before needing an overhaul.   
* **Hardware agnostic**: Let me explain what hardware agnostic means: When system is hardware agnostic, it means user of that system don’t have to know hardware-level knowledge. So it’s definitely true that platform must be hardware agnostic.
* **Cloud agnostic**: Similar to hardware agnostic, platform should be cloud agnostic. That is, platform should work equally on both AWS cloud and your local private server.
* **Architecture and technology stack**: Well-designed architecture and good technological stack is very import for platform. That is, architecture and technology used in platform should be flexible enough to deal with future changes.
> You need a good combination of a fluid and a rigid architecture backed by a solid, efficient technology stack.   
* **Security**: By far, security of IoT platform has underrated but nowadays, it is also an very important factor.
* **Cost**:
> The platform should add enough value to justify its cost.   
* **Support**:
> As a mandatory requirement, the middleware platform should have strong support in the design, development, deployment, and management of the solution on an ongoing basis.   
