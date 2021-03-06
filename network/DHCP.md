# DHCP (Dynamic Host Configuration Protocol / 동적 호스트 구성 프로토콜)

* 호스트가 네트워크에 접속하고자 할 때마다 IP를 동적으로 할당받을 수 있도록 한다.
* 호스트가 빈번하게 접속을 연결하고 다시 갱신하는 가정 인터넷 접속 네트워크 및 무선랜(LAN)에서 폭넓게 사용된다.
* DHCP 서버는 IP주소들의 풀(pool)과 클라이언트 설정 파라메터를 관리한다. 

#### 순서
새로운 호스트(DHCP 클라이언트)로부터 요청을 받으면 서버는 특정 주소와 그 주소의 대여기간(lease) 기간을 응답한다. 클라이언트는 일반적으로 부팅 후 즉시 이러한 정보에 대한 질의를 수행하며 정보의 유효기간이 해제되면 주기적으로 재질의한다.

	1. DHCP 서버발견(DHCP Server Discovery):  새롭게 도착한 호스트는 자신이 접속 될 네트워크의 DHCP 서버 주소를 알지 못하다. 따라서 호스트는 DHCP 서버발견 메시지를 브로트캐스트 IP주소(출발지 주소: 0.0.0.0, 목적지: 255.255.255.255)로 캡슐화 하여 서브넷 상의 모든 노드로 전송한다.

	2. DHCP 서버제공(DHCP Server Offer): DHCP 발견 메세지를 받은 DHCP 서버는  DHCP 제공 메세지를 이용해 클라이언트로 브로드캐스트 한다. 즉, 송신 호스트의 IP 주소가 할당되기전이기 때문에(DHCP 서버 발견 메세지 상의 출발지 주소가 0.0.0.0이다) DHCP 서버는 서브넷 상의 모든 호스트로 응답한다. 서버제공 메세지는 클라이언트에 제공될 IP주소 네트워크 마스크, 도메인 이름, IP주소 임대 기간(유효기간) 등의 클라이언트 설정 파라메터 값들 포함한다.

	3. DHCP 요청(DHCP Request): IP 할당을 요청한 새 호스트는 하나 이상의 DHCP 서버 제공 메시지를 받고 그 중 가장 최적의 서버를 선택한 후, 그 서버측으로 DHCP요청메세지를 보낸다.

	4. DHCP ACK (Acknowledgement): 서버는 DHCP 요청 메세지에 대해 요청된 설정을 확인하는 ACK 메세지를 전송한다.


*wireshark라는 프로그램으로 패킷을 확인할 수 있다.
