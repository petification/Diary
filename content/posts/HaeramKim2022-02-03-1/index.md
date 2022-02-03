---
title: "Robot Chow: Automatic Animal Feeding with Intelligent Interface to Monitor Pets (IJAERS, 2019)"
date: "2022-02-03"
tags:
- "HaeramKim"
- "Research"
---
## Source (MLA form)
```
Nogueira, Rogerio, Humberto Araújo, and David Prata. "Robot chow: Automatic animal feeding with intelligent interface to monitor pets." International Journal of Advanced Engineering Research and Science 6.4 (2019): 262-267.
```
- - - -
## Introduced Works
### Device Perspective
![](Robot%20Chow%20Automatic%20Animal%20Feeding%20with%20Intelligent%20Interface%20to%20Monitor%20Pets%20(IJAERS,%202019)/Screen%20Shot%202022-02-03%20at%2010.21.12%20AM.png)
* 모터와 물레방아처럼 생긴 밸브(Rotary Valve)를 이용해 **사료 제공**
* 수도꼭지 잠그는 모터(Solenoid Valve)이용해 **물통에 물채움**
* Ultrasonic Sensor를 이용해 강아지의 움직임을 포착하고 포착되면 **카메라로 사진을 찍음**
### Platform Perspective
![](Robot%20Chow%20Automatic%20Animal%20Feeding%20with%20Intelligent%20Interface%20to%20Monitor%20Pets%20(IJAERS,%202019)/Screen%20Shot%202022-02-02%20at%2011.05.44%20PM.png)
* 얘네는 별도의 플랫폼을 이용하지 않고 라즈베리파이를 서버로 만들어서 기능들을 제공함
* 사용한 WSGI 프레임워크 - [GitHub - bottlepy/bottle](https://github.com/bottlepy/bottle)
### User Interface Perspective
1. Web Dashboard - 여기서 찍힌 사진들을 보거나. **밥주는시간 스케줄링**을 제공
2. Intelligent Chatting - 채팅서비스인 Telegram으로 유저가 채팅하면 IBM Watson이 자동으로 그에 대한 답변을 하고 둘이서 채팅하는 내용중에서 _밥줘_ 등의 명령을 캐치해서 실행시킴
- - - -
## Analysis
* 얘네는 Device랑 UI쪽은 많은 것을 제공하긴 한다
1. 물통에 물채우기
2. 사진 찍기
3. AI를 이용한 채팅 형식의 기기제어
* 하지만 그것을 통합하는 Platform쪽이 빈약함
* 라즈베리파이를 서버로 사용하고 여기에 많은 기능을 넣기 위해 여러 손실이 있다더라
1. DB가 없음 - 수집된 데이터들을 저장하지 못한다
2. 근데 보면 데이터를 수집하지도 않음
	* 원격 제어 기능과 사진찍는 것만 하고 섭취량을 추적하는 등의 작업도 하지 않는다
	* 그리고 문제는 _이 논문에서는 **IoT**를 언급하지 않는다 - IoT가 아닌셈_
	* 따라서 이 논문을 우리의 선행연구로 넣어야 할 지는 논란의 여지가 좀 있다
