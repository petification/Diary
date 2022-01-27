---
title: "Jan 27. Lecture 6"
date: "2022-01-27"
tags:
- "HaeramKim"
- "IntroducingWirelessNetwork"
---
## 저번시간에 나온 질문
* DSSS에서처럼 Spreading Code를 써서 0과1을 여러개의 비트로 표현하고 이것을 이용해 0과 1을 더 정확하게 짚어낼 수 있다
- - - -
## RF Components
### Transmitter
1. Transmitter로 데이터가 들어오면
	* 따라서 Transmitter가 RF Communication의 시작점이 된다
2. Data Encoding을 하고
3. 그것을 AC Signal로 Modulate하고
4. 안테나로 보내 전송하게 된다
### Antenna
* 안테나가 하는일은 두가지임
* Transmitter와 연결되어 신호를 방출(Radiate)하거나
* Receiver와 연결되어 신호를 수신한다
### Receiver
* Antenna로부터 받은 Modulated Signal을 0과 1로 바꾼다
* 그리고 그것을 컴터로 보내 처리되게 하는 것
* 수신된 신호는 당연히 송신한 신호보다 세기가 약하고
* 또한 여러가지 Interference로 인해 변형이 될 수도 있다
- - - -
## Radiator
### Intentional Radiator(IR)
* 말 그대로 _의도적으로 신호를 방출하는 장치_ 를 의미한다
* FCC는 IR의 세기를 규제하며, 이 세기란 것은 안테나로 진입하기 직전의 세기의 합(안테나가 여러개라면)을 의미함
### Isotropic Radiator
* _모든방향으로 에너지를 방출하는 놈_ 을 의미함
* 태양이 가장 대표적인 예
### Equivalent Isotropic Radiated Power
* 얘는 _안테나가 방출하는 신호 중 가장 큰 값_ 을 의미함
* IR과는 다르게 _안테나에 진입하기 직전이 아닌 안테나를 거친 후의 세기_ 를 가지고 측정한다
- - - -
## Unit?
* **Unit of power**: 절대적인 파위의 세기를 측정
	* 와트(W), 밀리와트(mW)가 다 절대값을 나타내기 위한 단위임
	* **dBm**: 1mW를 기준으로 하는 파워의 세기라던데
	* 0dBm은 1mW와 맞먹는다
	* 2.4GHz는 36dBm까지 가능하고
	* detect할 수 있는 가장 작은 놈은 -90dBm이다
	* 
* **Unit of comparison**: 어떤 파위와의 차이를 측정
	* **dB**: 너가 아는 그 데시벨 맞음
	* **dBm**: Isotropic radiator와 비교한 데시벨
	* **dBd**라는 것도 있댄다 - Half-Wave Dipole 와 비교한 것
	* 얘는 gain이나 loss를 나타내기 위한 단위
	* 수식은 아래와 같다
```
bels = log10(P1/P2)
decibels = 10*log10(P1/P2)
```
	* 보면 알 수 있듯이 데시벨의 deci는 10을 의미함
	* 또한 P는 Power를 의미하고 두개의 Power를 비교한 것이 bels / decibels이다
	* 약간 Isotropic Radiator의 신호를 깔때기같은걸로 모아서 특정 방향으로 퍼져나가게 한 것을 Half wave dipole인거같은데
	* 그래서 dBd가 높다는 것은 그만큼 집중되어있다는 소리이다?
- - - -
## RF Math
* 로그계산은 정확한 값을 계산할때만 쓰면 되고 
* **Math of 10s and 3s**라는 방법을 이용하면 대략적인 계산을 할 수 있다
* _10dB가 더해지면 신호의 세기(mW)도 10배가 된다(반대도 마찬가지)_
* _3dB가 더해지면 신호의 세기(mW)는 2배가 되고 반대도 마찬가지다_
* 연습문제
	1. 23dBm = (  ) mW -> 200mW
	2. 40mW = (  ) dBm -> 16dBm
	3. -53dBm = (  ) mW -> 0.000005mW
