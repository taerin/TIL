# SAX (Simple API for XML)
	- Simple API for XML(보통 SAX라고 한다)는 XML문서를 애플리케이션에서 사용하기 위한 API이다.
	- SAX는 이벤트 중심의 인터페이스이다. 프로그래머가 일어날 수 있는 이벤트를 설정해 놓으면, SAX는 그 이벤트가 일어났을 때 제어권을 가지고 상황을 처리한다. SAX는 직접 XML 파서와 함께 일한다.
	- DOM에 비해 단순한 인터페이스, 처리해야할 파일이 많거나 매우 큰경우에 용이하다.
	- XML 문서를 처리하기 위해 DOM 대신 사용할 수 있는 방안이지만 DOM 보다 데이터 내용을 조작할 수 있는 기능은 상대적으로 적다.

### 동작
	문자열을 앞에서 부터 차례로 읽어가면서 정보를 받아들이고
	문자열을 읽으면서 계속 event를 발생시킨다.
	프로그래머들은 이에맞는 event에 알맞게 프로그램을 작성해준다.



### XML 문서 생성과정
	* 1단계 : XML문서를 취급하기 위하여 프로그램에서 XML문서를 읽어들임
	* 2단계 : DOM처럼 불러들인 XML문서를 XML 파서(XML Parser, XML 해석기)에 의해 트리구조로 만들지 않고 직접 프로그램상에서 XML문서를 차례로 읽으면서 그에 맞는 이벤트가 발생하였을 때 SAX API를 이용하여 사용자가 작성한 문서대로 XML문서를 조작
	* 3단계 : 조작되어진 XML 문서를 프로그램이 마무리하여 생성 혹은 갱신

### DOM과 SAX 비교

비고| SAX | DOM
----|-----|-----
접근방법|이벤트 기반|트리기반
장점|메모리 효율| 빠른 속도 문서의 임의접근
단점| 구조에 대한 접근 곤란, 읽기 전용으로 데이터 수정 불가능, 사용법 어려움| 브라우저 지원 안됨 메모리 사용량 큼 속도 느림
적용분야| 문서 일부분만 읽을 때 데이터 변환시|구조적 접근이 필요한 경우 문서 정보를 쉽게 파악할 때


