# Vagrant
Vagrant는 한마디로 이야기 하면, “간소화된, VM 관리 서비스이다”. 이미 Virtual Machine 환경은 보편화 되서 사용되고 있고, VMWare나 Oracle의 Virtual Box등을 이용하면 PC에서도 손쉽게 VM 환경을 구축할 수 있다. 
그러나 문제점은, Virtual Box와 같은 Hypervisor가 있다고 해도, VM을 생성하는 것 자체가 번거로운 작업이라는 것이다.
Hypervisor에서 논리적인 가상 하드웨어 머신을 생성하고 가상머신에 OS를 설치하고, 일일이 설정을 해줘야 한다. 이런 반복적인 작업을 조금더 손쉽게 자동화 할 수 없을까? 하는 아이디어에서 시작한 것이 Vagrant이다.

## 설치 후 변경해줘야할 사항
저장소(Repository)는 우분투 (Ubuntu)에서 배포하는 각종 업데이트가 있는 곳이다. 기본으로 설정되어 있는 KAIST 미러(ftp.kaist.ac.kr, kr.archive.ubuntu.com)도 속도가 많이 빨라졌지만, 다음카카오에서 제공하는 쾌적한 저장소를 이용하는 것도 좋다.
설치 후sources.list 파일에서 우분투 저장소(repository)를 kr.archive.ubuntu.com 에서 __ftp.daumkakao.net__ 로 변경해준다.

* 참고
[출처](http://bcho.tistory.com/806)
[출처](https://openwiki.kr/tech/ubuntu_daumkakao_repository)
