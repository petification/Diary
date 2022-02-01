---
title: "Towards Resilient IoT Messaging: An Experience Report Analyzing MQTT Brokers (IEEE, 2021)"
date: "2022-02-01"
tags:
- "HaeramKim"
- "Research"
---
## Source
```
S. Gruener, H. Koziolek and J. Rückert, "Towards Resilient IoT Messaging: An Experience Report Analyzing MQTT Brokers," 2021 IEEE 18th International Conference on Software Architecture (ICSA), 2021, pp. 69-79, doi: 10.1109/ICSA51549.2021.00015.
```
- - - -
## Summary
* 이 논문은 MQTT를 구현한 4개의 Application인 **VerneMQ**, **Mosquitto**, **HiveMQ**, **EMQ X**의 Resilient Testing을 수행한 것이다
### Factors (Requirements)
1. **Availability**: 클라이언트는 언제나 정상적으로 작동하는 브로커에 연결할 수 있어야 한다
2. **Reliability**: Publish된 메시지는 모든 Subscriber들에게 전달되기 전에 유실되면 안된다
3. **Consistency**: Subscriber들은 메시지를 Publish된 순서에 맞게, 그리고 중복되지 않게 받아야 한다
### Source of Failure
1. **Internet Failures**: 트래픽이 몰리거나 (특히 무선통신의 경우) 통신회선의 상태가 불량하여 통신이 유실되는 것
2. **Host Failures**: 브로커가 돌아가고 있는 Host Computer에게 하드웨어적 / 소프트웨어적으로 문제가 생기는 것
	* 이때 소프트웨어적 문제는 브로커 자체의 문제가 아니라 브로커가 아닌 다른 프로세스에 의해 발생하는 문제를 일컫는다
3. **Broker Failures**: MQTT 프로토콜을 구현한 브로커 프로세스에 문제가 생기는 것
4. **Disk Failures**: 디스크에 공간이 부족하는 등의 디스크 IO 문제
5. **Network Split**: 통신장비에 문제가 생기는 것
### Variants
1. QoS 0 / TCP Retransmission only
	* Application Layer에서의 Reliability checking없이 TCP에서의 그것에만 의존했을때 누락률
2. QoS 1 / TCP / PUBACK
	* QoS 1에서의 PUBACK를 사용했을 때와
	* QoS 2에서의 PUBREC, PUBREL, PUBCOPM를 사용했을 때의 누락률
3. QoS 1 / TCP / PUBACK / Persistence
	* Message Broker Application에서 지원하는 Persistence Strategy까지 이용했을 때의 누락률
	* Mosquitto는 `mosquitto.db`파일에 메시지를 임시로 저장하는 File Persistence를 지원한다
	* 이걸 이용하면 Subscriber에게 전달되기 전에 Broker가 죽어도 메시지가 파일같은데 남아있기 때문에 살아난 뒤에 전달할 수 있다
4. Clustered Broker
 	* 하나의 Broker Instance 가 죽었을때 **Pod Router**를 이용해 다른 Broker Instance로 Forwarding하는 방법(**Cold Standby**)을 이용했을때의 누락률
 	* Single Broker는 Broker의 Down Time동안 메시지가 누락되지는 않아도 지연되는 문제가 발생하는데 Clustered Broker의 경우에는 이러한 Down Time을 줄일 수 있다는 장점이 있음
 	* 그래도 나머지 하나의 Broker Instance로 옮기기 전에 유실되는 경우가 존재하므로 유실을 방어할 수 있는 것은 아니다
 	* 외부에서 Traffic 을 분산시키는 **External Load Balancer**가 있고 Broker Instance 안에서 내부적으로 작동하는 **Internal Load Balancer**가 있는데 **Pod Router**는 Internal Load Balancer에 속함 - Broker Instance안에 있기 때문에 Broker Process에 걸리는 부하를 더 정확하게 파악할 수 있는 장점이 있다
5. Clustered Broker / Queue mirroring
	* 여전히 Pod Router를 이용해 다른 Broker Instance로 Forwarding하되, 다른 Broker Instance를 Synchronize하는 방법(Queue Mirroring)을 이용했을때의 누락률
	* 뭔말인고 하니 두개의 Broker Instance를 동기화시키고 하나가 죽으면 Pod Router로 Forwarding함
	* 이렇게 하면 Forwarding하기 전에 유실되더라도 나머지 하나의 Broker Instance가 Queue를 Mirroring하고 있었기 때문에 메세지가 남아있게 된다
	* 또한 Message 뿐만 아니라 Client Session Data까지 복사하기 때문에 Forwarding 후 Delay 없이 바로 작동이 가능하다는 장점도 있다
	* 하지만 당연히 두개의 Message Queue를 동기화시켜야되기 때문에 어느정도의 Latency는 발생할 수 밖에 없게 된다
* 하지만 _우리의 시스템에서는 Clustered Broker를 사용하지 않을 것이기 때문에 4, 5번에 대한 실험은 읽지 않음_
### Experiment
### Testing Result
1. Variant 0, 1 - Comparison of QoS 0, 1, 2 with no additional features (like Persistence)
	* 일단 이 실험은 Eclipse Mosquitto 를 Broker로 사용하여 실험했댄다
	* 보면 QoS 0도 25%의 데이터 유실률의 환경에서도 100%의 전송률을 보여주고 있는 것을 알 수 있다 - _TCP Retransmission으로도 상당히 Reliable한 통신_ 이 이루어지고 있는 셈
	* 따라서 _그러한 환경이 아니라면, QoS 등급을 올려서 불필요한 Packet이 오가게 하는 것(**Extra Round Trip**)은 비효율적_ 일 수 있다
	* 그리고 위 그래프를 보면 QoS 1에서 Latency가 가끔씩 뻗는 것을 볼 수 있다
	* 이건 왜냐하면 Message Frequency가 아주 높을 경우 Message들을 묶어서 전송하는 경우가 있기 때문인데, 묶어서 전송하다가 이놈이 유실되면 Retransmission에 걸리는 시간이 늘어나기 때문이다
	* 따라서 네트워크 환경이 안좋다면 빠른 속도로 메세지를 보내다가는 가끔씩 Latency가 아주 길어지는 문제가 생기게 되니 지양하도록 하랜다
2. Variant 2: Usefulness of Persistency Feature
	* 실험은 다음과 같은 방식으로 진행됨
    1. Publisher 한개가 5000개의 메시지를 보내고 Subscriber 두개가 각각 수신함
	2. 2000번부터 2500까지는 Subscriber하나를 꺼서 그놈한테 보내져야 할 패킷들이 Persistency Database에 쌓이도록 함
	3. 2500번에 다다르면 Broker를 강제 재실행하고 꺼놨던 Subscriber를 킴
	* 그러면 다음과 같은 결과가 예상된다
	1. Subscriber 1은 모든 패킷을 다 받는다 - 대신, 2000부터 2500까지는 중복된 패킷이 수신될 수 있다
	2. Subscriber 2또한 모든 패킷을 다 받는다 - Broker가 Persistency Database에서 2000~2500에 해당하는 메세지를 복원하여 전송하기 때문
	* 이러한 방식으로 4개의 Broker를 테스트한다 - EMQ X EE(Enterprise Edition), HiveMQ, Mosquitto, VerneMQ
	* 그러면 위와 같은 결과를 받을 수 있다
	* Single Broker체제에서 Persistency를 사용하는 경우에는 HiveMQ와 Mosquitto의 경우에 아주 훌륭한 결과가 나온다 - 메시지 유실과 순서 섞이는 문제가 일어날 확률이 0에 가깝고, 중복된 메시지가 수신될 확률도 아주 낮았음
	* 따라서 _Message Frequency가 아주 높지 않고 30초 정도의 Broker Restart를 견딜 수 있는 환경이라면, Broker Clustering등의 복잡한 설정 없이 간편하게 하나의 Broker와 Persistence Setting만으로 Broker System을 구성하는 것이 현명하다_
	* 하지만 저자는 Message의 Payload 가 아주 크거나 Frequency가 아주 높은 등의 Persistency에 영향을 주는 다른 극단적인 상황에서의 실험은 하지 않았고, 이럴 경우에의 결과는 달라질 수 있다고 덧붙였음
### Conclusion
* Availabilty가 높다는 것은 단순하게 Client가 언제나 Broker에 연결될 수 있는 것을 의미하는 것이지 이것이 High Reliability를 보장하지는 않는다 - Broker가 Subscriber에게 전달하기 전에 누락되는 경우도 있으므로
* Clustered Broker의 경우에 Load Balancer의 역할은 매우 중요하다 - Load Balancer의 설정에 따라 Reliability와 Availability가 많이 바뀐댄다
* TCP위에서 돌아가는 QoS 0은 상당히 Reliability가 좋다
* 어떤 Broker Application을 선택하고 어떻게 그들을 구성할지는 케바케이고 시스템의 Requirements가 정확하게 명시되어야 올바른 구성을 이끌어낼 수 있다
	* Broker의 Availability보다 Reliability가 더 중요한 상황이라면, Single Broker w/ Persistence Setup으로도 충분할 수 있다
- - - -
## Applying to Our Project
* 우리의 프로젝트에는 일반적인 경우 15초에 한번씩 Publish하고, Food Refill 같은 경우에 Publish Period가 짧아지긴 하지만 위 논문에서만큼 극단적으로 Period가 짧아지지는 않는다
* 또한, 일반적인 경우 Latency가 그리 길지 않으며 Latency에 민감한(즉각적인 반응이 요구되는) 상황도 자주 일어나지 않는다
* 따라서 Single Clustered w/ Persistence Setup이면 충분할 것이다
* 또한, 평소에는 QoS 2로 현재의 물과 사료 양을 Publish하다가 사료를 주는 경우에만 QoS 0으로 내리는 것으로도 충분히 효율적으로 통신할 수 있을 것이다 - 네트워크가 극단적으로 나쁘거나, Payload가 아주 크거나, Frequency가 아주 짧은 상황이 아니므로 Mosquitto + QoS 0으로도 누락된 패킷이 나오지 않을것이다
- - - -
## Another Literature
1. Comparison of Various MQTT Implementations in Performance / Security / Maintenance Perspective
```
H. Koziolek, S. Gruner, and J. R  ̈ uckert, “A Comparison of MQTT  ̈
Brokers for Distributed IoT Edge Computing,” in Software Architecture
- 14th European Conference, ECSA 2020, L’Aquila, Italy, September
14-18, 2020, Proceedings, ser. Lecture Notes in Computer Science,
A. Jansen, I. Malavolta, H. Muccini, I. Ozkaya, and O. Zimmermann,
Eds., vol. 12292. Springer, 2020, pp. 352–368. [Online]. Available:
https://doi.org/10.1007/978-3-030-58923-3 23
```
2. UDP vs TCP
> Roy et al. [13] showed in experiments that larger message payloads can lead to higher message losses in case of network disturbances in wireless networks when using MQTT-SN over UDP.  
```
[13] D. G. Roy, B. Mahato, D. De, and R. Buyya, “Application-aware end-to-
end delay and message loss estimation in internet of things (iot)—mqtt-
sn protocols,” Future Generation Computer Systems, vol. 89, pp. 300–
316, 2018.
```
