---
title: "Comparison between Blynk and Node-RED"
date: "2022-02-02"
tags:
- "HaeramKim"
- "Research"
---
* _이 내용은 확실하지 않음 - Research를 더 하면 바뀔 여지가 충분히 있더라_
- - - -
## Database Perspective
### “The development of smart flood monitoring system using ultrasonic sensor with blynk applications”, IEEE
```
N. A. Z. M. Noar and M. M. Kamal, "The development of smart flood monitoring system using ultrasonic sensor with blynk applications," 2017 IEEE 4th International Conference on Smart Instrumentation, Measurement and Application (ICSIMA), 2017, pp. 1-6, doi: 10.1109/ICSIMA.2017.8312009.
```
* 주목해야될 부분: 
> At the same time, the data is stored in a CSV database, through email this data can be converted into excel form, as well as being transmitted to the second NodeMCU via Blynk Bridge.  
* 이 연구에서는 CSV File 을 저장의 용도로 쓰는데 이러한 경우에는 쿼리를 통한 조회 혹은 연산이 제한적이다
### (Legacy) Blynk: Enabling raw data storage
> By default raw data storage is disabled (as it consumes disk space a lot). When you enable it, every Blynk.virtualWrite command will be saved to DB. You will need to install PostgreSQL Database (**minimum required version is 9.5**) to enable this functionality:  
> _from_ [GitHub - blynkkk/blynk-server](https://github.com/blynkkk/blynk-server#enabling-raw-data-storage)  
* 아래는 문제점들임
	1. 이 방법은 주어진 DB 스키마를 사용해야 해서 유연성이 부족하니이다
	2. 또한 최근에 Blynk Platform이 리뉴얼되어 Legacy 버전을 사용할 수는 있지만 더이상의 지원은 끊김
### (Latest) Blynk: HTTP API
* [Blynk.Cloud - HTTP API](https://docs.blynk.io/en/blynk.cloud/https-api-overview)
* 리뉴얼된 Blynk는 더이상 Private Server로 작동시키지 못하고 무조건 Cloud Instance로만 작동시켜야 됨 - 근데, 이때 DB에 직접 접근할 수 있는 것이 아니라 ReST API를 통한 접근밖에 안되더라
- - - -
## Logic Perspective
* (지금까지 찾아본 바로는) Blynk 클라우드에서 Logic을 구현하는 것이 아닌 아두이노에서 Logic을 구현하는것 같다
