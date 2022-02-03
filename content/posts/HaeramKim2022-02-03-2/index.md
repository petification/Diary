---
title: "Automated Pet Feeder using IoT (IEEE, 2021)"
date: "2022-02-03"
tags:
- "HaeramKim"
- "Research"
---
## Source
```
P. N. Vrishanka, P. Prabhakar, D. Shet and K. Rupali, "Automated Pet Feeder using IoT," 2021 IEEE International Conference on Mobile Networks and Wireless Communications (ICMNWC), 2021, pp. 1-5, doi: 10.1109/ICMNWC52512.2021.9688391.
```
- - - -
## Proposed Work
### Components
![](index/Screen%20Shot%202022-02-03%20at%2012.31.38%20PM.png)
* RTC (Real Time Clock): 정확한 현재 시간을 체크해 사용자가 지정한 Scheduled time이 도달했는지 검토한다
* Servo Motor (SG90): 모터를 회전해 사료통에서 사료가 쏟아지도록 한다
* LCD: 현재 날짜와 시간을 화면에 보여준다
* Ultrasonic Distance Sensor: 사료통 입구와 밥그릇 안까지의 거리를 측정해 밥이 밥그릇 안에 얼마나 들어있는지 확인한다
* Buzzer, Red LED: Scheduled time에 도달하면 버저와 LED가 울리며 강아지의 주의를 끈다
### Flow
![](index/Screen%20Shot%202022-02-03%20at%2012.35.45%20PM.png)
* 위 플로우의 핵심은
1. 시간을 체크해 Scheduled Time에 도달했는지 확인
2. 밥그릇까지의 Distance를 측정해 적당한 양의 사료를 제공
* 하는 기능이다
* 그래서 만일
	* 10cm이하라면 아직 밥이 많이 남았다는 뜻이기 때문에 Servo Motor를 45도만 10초동안 돌려 적은 양의 사료가 제공되도록 함
	* 10~15라면 밥이 적당히 남았으므로 90도를 10초간 돌려 중간 양의 사료가 제공되도록 함
	* 15~20라면 밥을 거의 다 먹었으므로 120도를 10초간 돌려 많은 양의 사료가 제공되도록 함
* 그리고 매번 Scheduled Time에 도달했을 적에 버저와 LED를 켜 어그로를 끈다
- - - -
## Analysis
* 디바이스랑 유저를 연결하는 IoT Platform에 대해서는 언급(구현)이 없다
* 사료의 양이 얼마나 남아있는지를 Distance Sensor를 이용해 측정한다
	* 이것은 정확하지도 않을 뿐 아니라 개가 사료를 얼마나 먹었는지 정량적인 분석이 안된다는 문제점이 있다
	* 또한 이 값을 기준으로 Servo Motor의 회전각을 결정하게 되는데 그러면 제공되는 사료의 양도 매번 일정하지 않고 밥그릇에서 넘칠 가능성도 있다
