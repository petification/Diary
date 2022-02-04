---
title: "Smart Dog Feeder Design Using Wireless Communication, MQTT and Android Client (IEEE, 2016)"
date: "2022-02-03"
tags:
- "HaeramKim"
- "Research"
---
## Source
```
Vania, K. Karyono and I. H. T. Nugroho, "Smart dog feeder design using wireless communication, MQTT and Android client," 2016 International Conference on Computer, Control, Informatics and its Applications (IC3INA), 2016, pp. 191-196, doi: 10.1109/IC3INA.2016.7863048.
```
- - - -
## Proposed Works
### Features
* Pet identification via RFID
* Scheduled feeding
![](index/Screen%20Shot%202022-02-03%20at%208.17.48%20PM.png)
* 사료 제공 컨트롤 - 프로펠러 1칸이 1 Serving, 최대 3 Serving, 사용자가 무게 설정할 수 있고 무게센서 이용해서 무게 재면서 설정한 무게에 맞는 Serving이 제공됨
* 사료 다먹었는지 아니면 부분적으로만 먹었는지 report - 알림기능을 제공하는지는 정확하지 않음
* 밥먹을 시간이 되면 어그로끌어서 개가 오도록 함 - RTC 써서 시간체크하다가 시간 다되면 Interrupt 거는 구조
* Application 쪽에서도 사용자 추가 / Device 추가를 위한 Interface 를 제공함
### Literature Review
1. Smart Pet Care System Using Internet of Things
```
Seungcheon Kim, “Smart Pet Care System Using Internet of Things”, International Journal of Smart Home, 2016.
```
2. Programmable Pet Feeder 
```
Tessema Gelila Berhan, Worku Toyiba Ahemed, Tessema Zelalem Birhan, “Programmable Pet Feeder”, International Journal of Scientific Engineering and Research (IJSER), Nov. 2015.
```
* 얘네들의 한계점
> Programmable Pet Feeder only has 4 dispensers which means it can only serve 4 times and it requires the user to set the times at the device.  
> Smart Pet Care System can be set with a smartphone but the user can’t see the record of the feeding process.   
* (1) 번은 Dispenser가 4개 있어서 4번밖에 사료를 주지 못함
* 또한, Food Feeder에 직접 시간을 입력해야됨 - Web Application을 통해 시간 설정하는 등의 편의성이 없더라
* (2) 번은 스카트폰을 통해 시간을 설정하는 것이 가능하지만 개가 얼마나 먹었는지 등의 확인은 못한다더라
### Architecture
#### Device
![](index/Screen%20Shot%202022-02-03%20at%208.05.45%20PM.png)
* ESP8266: 와이파이 모듈
* Magnetic Switch: 사료 뚜껑이 열렸는지 감지하는 용도
* RTC: 시간 체크해서 정해진 시간에 도달하면 Interrupt하는 놈
* Buzzer: 시간되면 어그로끌기
* Load Cell + HX711: 무게센서
* RFID RC533: RFID를 위함
* Motor Servo: 프로펠러 돌려서 개 밥주기
#### Platform
![](index/Screen%20Shot%202022-02-03%20at%208.16.56%20PM.png)
* DB: MySQL
* Server: NodeJS
* Communication Protocol: MQTTS (MQTT + SSL / TLS)
### Future Plan
> For future development, Smart Dog Feeder can be made larger using larger dispenser to store the dog food. The application can be improved with some new features, such as adding gestures, changing activity into fragment, or adding some new functions for new devices.   
- - - -
## Analysis
* 이 논문과 비교할때 우리 연구에서의 장점은
1. Malfunction때 알림보내는것
2. NodeRED를 써서 더 빠르고 직관적으로 플랫폼을 구성했다는 것
3. 사료제공에 무게센서를 두개 달아서 남은 사료의 양도 체크할 수 있는 것
4. 물 섭취량도 제공하는 것
5. 섭취량 혹은 잔여량을 시각적으로 보여준다는 것
6. 뭐 굳이 따지자면 RTC를 안쓰고 published timestamp를 쓰니까 Device쪽을 좀 더 가볍고 저렴하게 구성할 수 있는 정도
7. 프로펠러를 통한 Serving이 아니기 때문에 좀 더 정확하게 계량해서 Serving이 된다
8. Web Dashboard를 제공함
