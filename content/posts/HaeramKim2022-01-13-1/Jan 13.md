---
title: "Lecture 2"
date: "2022-01-13"
tags:
- "HaeramKim"
- "IntroducingWirelessNetwork"
---
## Organization
### FCC
* IR(Intentional Radiator): 안테나로 들어오는 파워의 최대
* EIRP(Equivalent Isotopically Radiated Power): 안테나로 나가는 파워의 최대
* 빛을 모으는거처럼 신호를 모으는 방식으로 EIRP는 IR보다 항상 높다 - Antena gains power of IR
* FCC regulates ratio of gain
### ITU
* ITU라는 놈이 대륙별로 통신을 관리함?
### IEEE
* 뭔가 발명하고 표준화함
* 802.1A처럼 대문자가 붙으면 Standard 소문자가 붙으면 amendant
### IETF
* 인터넷을 더 좋게하기 위한 기준들을 만듦
* RFC가 여기 속함
### WiFi Alliance
* WiFi 기기를 테스트하고 Certificate를 줌
* 기기를 바꿀때마다 Certify과정을 해야된다? - 사용자가 하는것은 아닌듯
### ISO
* OSI모델이 규정되어 있는 곳
#### OSI
* 802.11은 Physical layer와 MAC Sublayer에 대해서만 규정한다
* 상위계층의 프로토콜은 신경쓰지 않아도 된다
* AP와 연결이 되지 않으면 (당연히) 1, 2계층의 문제인 것
- - - -
## 802.11
* WiFi 는 Access Layer에서 돌아간다
* 802.11 Link는 Distribution Layer에서 돌아간다
* WiFi는 근본적으로 Half-duplex를 지원하는 기술이다
