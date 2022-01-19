---
title: "Lecture 3"
date: "2022-01-18"
tags:
- "HaeramKim"
- "IntroducingWirelessNetwork"
---
## Keying
* Keying: 0과 1을 나타내는 방식
* ASK는 거리가 멀어질수록 세기가 줄어들어서 802.11에 쓰기 힘들다
* FSK도 쓰기 힘들다 - 왠지는 놓침
* PSK를 쓴다 - State transition technique를 사용 - Phase이 바뀌면 1, 안바뀌면 0
### Multiple PSK
* 위상을 몇도씩 돌리냐에 따라 상태를 나누어서 하나의 상태당 여러 비트를 묶는 것
* 예를들어 90도씩 돌려서 4개의 상태를 만들고 각각에 00, 01, 10, 11을 할당할 수 있다
* N-ary -> `2^bit == state` : 따라서 이 수식이 만족하는 것
* 근데 거리가 멀어지거나 노이즈가 심해질수록 위상의 변화를 민감하게 감지하기 힘들다
	* 따라서 Data rate 은 Throughput과 다르다고 말할 수 있음
	* 즉, 아무리 전송속도가 빨라도 수신되지 않으면 의미가 없기 때문
	* 대역폭은 정해져있기 때문에 노이즈를 얼마나 이겨내는가가 더 중요한 척도가 된다
	* 여기서의 노이즈는, 송수신자의 통신을 방해하는 모든 것을 말한다
	* AP에 연결되어 있는 Client들은 전부 CSMA/CA같은 룰에 따라 제어되며 통신한다 - 따라서 Client들이 보내는 신호들은 노이즈가 아닌 셈
	* 그리고 이후에 나온 802.11에는 다른 AP와 통신할때의 제어방식도 규정되어 있다 - 따라서 걔들도 노이즈가 아닌 셈
* 기억나는지 모르겠지만 QAM이 진폭과 위상을 둘 다 이용한 Keying이고 그걸 Constellation Diagram으로 나타낼 수 있는 것이다
- - - -
## Standards
* Standards Lifecycle:
	* Original Standard Specified
	* New techniques are developed
	* New techniques are included in standard as “Amendant” - 약간 배타느낌으로 표준을 제정함
	* New Original Standard specified with Amendant - Amendant를 포함하여 새로운 표준이 제정됨
* 802.11 a -> b -> g -> n -> ac -> ax 순서대로 제정되었고 ax를 WiFi 6라고 부른다
* 802.11 Lagacy는 FHSS(Frequency Hopping Spread Spectrum)를 사용한다
* SISO: Single Input Single Output
* MIMO: Multi Input Multi Output
