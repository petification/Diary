---
title: "Automatic Pet Food Dispenser by using Internet of Things (IEEE, 2020)"
date: "2022-02-03"
tags:
- "HaeramKim"
- "Research"
---
## Source (IEEE)
```
T. Sangvanloy and K. Sookhanaphibarn, "Automatic Pet Food Dispenser by using Internet of Things (IoT)," 2020 IEEE 2nd Global Conference on Life Sciences and Technologies (LifeTech), 2020, pp. 132-135, doi: 10.1109/LifeTech48969.2020.1570620257.
```
- - - -
## Proposed Works
### Hardware
* ESP32 WiFi MCU
* MG995 Servo Motor
* Load Cell
### Platform
* Blynk
### Feature
![](index/Screen%20Shot%202022-02-03%20at%202.56.25%20PM.png)
1. Live status + daily statistics for food consumption
2. Calculate food amount from pet’s species, weight etc
![](index/Screen%20Shot%202022-02-03%20at%202.57.29%20PM.png)
3. Manual / Automatic food amount adjustment - 약간 개가 한번에 먹는 양 통계내서 그걸로 먹이양 조절하는 시스템인듯?
4. Scheduled Feeding
- - - -
## Analysis
* 일별 Live 그래프뿐만 아니라 일주일간 통계 내는거 좋은듯
* Automatic Adjustment도 있으면 좋듯싶듯싶하고
* Blynk를 NodeRED로 고치고
* Notification 추가하고
* Container에 남아있는 먹이량 보여주는 것 정도가 우리 연구에서의 차별점이 되지 않을까 싶음
