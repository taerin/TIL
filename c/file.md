# C언어의 파일 지원
C언어가 제공하는 파일 입출력 방식은 고수준과 저수준 두 가지가 있다. 잘 알겠지만 저수준과 고수준의 분류 방법은 사람에게 얼마나 가까운가, 즉 얼마나 쓰기 쉬운가를 기준으로 하는 것이지 기능의 좋고 나쁨을 의미하는 것은 아니다. 두 방식의 특징과 장단점을 도표로 정리해 보자.

/ | 고수준 | 저수준
--|--------|--------
버퍼사용 | 사용 | 메모리로 직접 읽어들임
입출력 대상 | 스트림 | 파일 핸들
속도 | 느리다 | 빠르다
문자 단위 입출력 | 가능 | 가능하지만 비효율적이다
난이도 | 비교적 쉽다 | 조금 어렵다
세밀한 조작 | 어렵다 | 가능하다 

두 방식의 가장 큰 차이점은 버퍼를 쓰는가 그렇지 않은가 하는 점이다. 나머지 차이점은 버퍼의 사용 유무에 따라 파생되는 특성들이다. 버퍼는 파일로부터 입출력되는 데이터를 잠시 저장하는 메모리 영역이다. 파일이 저장되는 하드 디스크는 모터에 의해 기계적으로 구동되므로 전자적으로 동작하는 메모리보다 상대적으로 느리다. 그래서 가급적이면 하드 디스크를 액세스하는 회수를 줄이기 위해 버퍼를 사용한다.
파일을 문자 단위로 읽을 때 버퍼없이 하드 디스크를 직접 액세스한다면 한 번 회전할 때 한 바이트밖에 읽지 못하므로 백만 바이트를 읽기 위해 하드 디스크가 백만번 회전할 때까지 기다려야 할 것이고 파일 액세스 속도는 형편없이 느려진다. 한 번 읽을 때 미리 주변 데이터를 버퍼에 읽어 놓으면 다음 읽기 요청은 하드 디스크 액세스없이 버퍼에서 바로 읽을 수 있다.
저수준과 고수준은 버퍼의 사용 유무에 따라 속도에 약간의 차이가 있기는 하지만 사실 현대의 컴퓨터 환경에서 이정도 속도차는 무시해도 될 정도이다. 아주 정밀하게 측정해 본다면 저수준이 조금 더 빠르기는 하겠지만 CPU와 메모리, 하드 디스크가 워낙 빠르기 때문에 체감한다는 것은 불가능하다. 그래서 요즘은 저수준 파일 입출력이 큰 이점이 없는 셈이다.
