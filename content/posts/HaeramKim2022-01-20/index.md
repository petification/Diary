---
title: "Lecture 4"
date: "2022-01-20"
tags:
- "HaeramKim"
- "IntroducingWirelessNetwork"
---
## 802.11 Standards
### Major Standards
* 802.11 Legacy:
	* FHSS - 802.11 Legacy에서만 사용하고 이후에는 버렸음
	* Infrared: 적외선 주파수 대역을 사용함
* 802.11a: Legacy에서 5GHz를 도입
* 802.11b: 2.4와 HR/DSSS를 도입, a와 호환됨
* 802.11c: 802.11a에서 2.4로만 바꾼 버전 -> Legacy와 b와 호환됨
* 802.11n: a, b, c와 호환되고 2.4와 5를 모두 지원함
* 802.11ac: 5GHz만 지원, 5GHz를 사용하는 이전버전과 호환
* 802.11ax: 2.4, 5에 추가적으로 6GHz도 호환
	* 효율성을 늘리는데 중점을 둠 - 이전까지는 효율성보다 Datarate에 중점을 둠?
	* MU-MIMO(Multi User MIMO)지원 -> 이전까지는 한명의 AP 접속에 대한 것만 생각했다면 ax는 여러명이 접속했을때의 효율성과 Throughput에 대해 고려함
### Other Standards
* 802.11e: QoS에 대해 정의
	* 어떤 프레임이 더 AP에서 먼저 처리되어야 하는가
	* 즉, 인터넷 통화같은 것들이 더 중요한것이기 때문에 비디오보다 먼저 처리된다
	* AP에서 중요한 Client를 캐치해서 그놈한테 우선권을 준다 - 우선권은 SIFS, PIFS, DIFS부분 공부하면 기억날거임
* 802.11h: Dynamic Frequency Selection(DFS), Transmit Power Control(TPC)같은거 정의
* 802.11i: WiFi에서의 보안성 강화
* 802.11w: Protect Management Frames을 이용한 보안성 강화
- - - -
## Radio Frequency
* AC(교류)를 안테나에 흘려서 RF를 만들어낸다 - Propagate Waves
	* 즉, 안테나에 AC를 흘리면 electromagnetic field(전자기장)이 생기고 이것에 의한 Electromagnetic wave가 RF라네
* 사인 파형을 그리며 퍼져나감
	* Cycle / Osciliation: Phase가 원래대로 돌아오는 파형 하나
		* 아 뭐라말해야돼
		* 그거 있잖음 그거
	* Period: 하나의 Cycle에 걸리는 시간
	* Wavelength(파장): length of 1 cycle(기호: 람다)
		* 2.4Ghz의 Wavelength는 12.5cm이고
		* 5GHz의 wavelength는 6cm정도이다
		* 이것이 중요한 이유는 이 길이가 안테나의 길이가 되기 때문
		* 즉, 파장이 긴 신호일수록(주파수가 더 작은 신호일수록) 안테나가 더 커지는 셈
		* 잘못된 안테나를 사용하면 AP가 고장날수도 있다는데?
		* 핸드폰이나 노트북에도 당연히 2.4나 5GHz의 안테나가 들어가는데 AP에 들어가는 안테나에는 신호를 모이주기 위한 Foil같은게 부착되어있어서 더 강한 신호를 보낼 수 있단대
		* 당연한말이지만 Wavelength와 Frequency는 Inverse Relationship의 관계에 있다
		* `fㅅ = c`
