# Story 01. 김 대리, 플랫폼 개발팀으로 발령나다

#### 의문1. 임베디드 시스템이란?
	소프트웨어를 설치만 하면 여러 작업을 할 수 있는 범용 목적의 PC와 달리 임베디드 시스템은 특정한 목적을 가지고 설계된다.
	전자레인지 처럼 범용의 목적이 아닌 정해진 용도에 국한된 기능을 제공해준다. 범용의 목적이 아니므로 각 시스템은 특수 목적을 가지고 제작되기 때문에 시스템을 구성하는 장치나 소프트웨어가 제한적이다.

#### 의문2. 임베디드 시스템의 구현
	임베디드 시스템의 구현은 하드웨어로만 구현할 수도 있고 하드웨어와 소프트웨어를 병행하여 구현할 수도 있다. 즉 시스템에서 어떤 기능이 동작하려면 회로를 이용해서 직접 하드웨어로 구현할 수도 있고, 소프트웨어로 구현할 수도 있다.
	1) 하드웨어만 사용해서 구현
		빠른 속도지원 But 기능 수정 및 확장의 어려움
	2) 소프트웨어와 하드웨어 병행하여 구현 ==> 대부분 이 방법으로 구현
		비용을 줄일 수 있고 기능의 수정이나 확장이 쉽다.

	* 임베디드용 프로세서와 PC용 프로세서는 다를까? 그렇다!
		PC에서는 주로 인텔 계열의 프로세서가 사용되지만 임베디드 시스템에 사용되는 프로세서는 다양하다. 
		ARM / MIPS 등등이 있다. 
		임베디드용 프로세서가  고려해야할 사항: 가격/ 전력소모/ 성능/ 크기

	*  동일한 프로세서, 국한된 운영체제 내에서 개발되는 PC 프로그램들과 달리 임베디드 시스템은 개발환경이 모두 달라서 컴파일러에 필요한 정보를 모두 설정해주거나 프로그램에서 직접 처리해야한다.

#### 의문 3. 임베디드 소프트웨어 개발방법
	임베디드 시스템은 범용으로 만들어진 것이 아니라 특수 목적으로 만들어진다. 특수 목적이라 함은 PC와 같이 모든 작업이 가능한 시스템이 아니라, 한두 종류의 기능에 특화되도록 시스템을 설계한다는 것이다. 

	* 네이티브 개발환경: 개발하는 시스템의 프로세서와 프로그램이 실행될 시스템의 프로세서가 같은 것
	* 크로스 개발환경: 개발하는 시스템의 프로세서와 프로그램이 실행될 시스템의 프로세서가 같지 않은 것

	* 크로스 컴파일러:  개발환경(PC)과 다른 프로세서(임베디드)용 기계코드를 생성해주는 컴파일러
		예) ARM용 크로스 컴파일러:  arm-linux-gcc / ADS
	
	크로스 개발환경에서 
	* 호스트 시스템: 소프트웨어를 개발하는 환경
	* 타겟 시스템: 임베디드 프로세서와 메모리 및 주변기기로 이루어진 임베디드 시스템

	일반 소프트웨어를 개발할 때에도 개발툴이 컴파일러, 어셈블러, 링커 등이 필요하듯이 임베디드 소프트웨어를 개발할 때에도 이러한 개발툴이 필요하다.
	* 툴체인(Tool Chain):  임베디드 시스템은 개발환경과 실행환경이 다른 크로스 개발환경이기 때문에 크로스 컴파일러나 크로스 어셈블러를 사용한다는 차이점이 있으며 이를 툴체인이라고 한다. 크로스 컴파일러, 크로스 어셈블러, 링커/로케이터 등으로 구성된 소프트웨어 개발도구를 말한다. 일반 PC용 컴파일러가 개발환경의 프로세서용 바이너리를 생성하는 반면, 크로스 컴파일러는 개발환경과 다른 타켓 시스템의 프로세서용 바이너리 코드를 생성한다. 

	* 로케이트란? 크로스 컴파일러와 어셈블러가 타겟 시스템을 위한 오브젝트 파일을 생성하는데 크로스 컴파일러와 크로스 어셈블러가 사용되었고, 이렇게 생성된 오브젝트 파일은 실행 가능한 바이너리 이미지로 변환되어야 하는데, 그 과정이 바로 로케이트(locate) 이다. 이때 타켓 보드의 메모리 정보를 로케이터에 알려주어야, 이 정보를 이용해서 실제 메모리 주소를 할당할 수 있다. 즉 로케이트는 프로그램 코드와 데이터 섹션들에 실제 메모리 주소를 할당하는 과정이다.

	* 타겟보드의 메모리 정보는 컴파일러의 옵션을 이용하여 설정할 수도 있고, 스크립트 파일을 사용할 수도 있는데 주로 스크립트 파일이 사용됨. 
	* 링커 스크립트에는 롬의 시작주소와 램의 시작주소, 각 섹션의 시작과 끝을 나타내는 심볼들로 구성되어 있다.


#### 의문 4. 프로그램을 어떻게 타겟 시스템으로 옮기나요
	호스트에서 개발한 소프트웨어를 타겟 시스템에 전송하려면 케이블이 필요하다.
	1) 시리얼 케이블: UART 통신*을 위한 케이블이다.
	2) JTAG  케이블: 타겟 시스템에 프로그램을 다운로드하거나 플래시 메모리에 프로그램을 탑재할 수 있다. 또 레지스터의 값을 읽어올 수 있거나 프로그램을 스템으로 작동시키는 등 디버깅 기능도 가능하다.
	3) 이더넷/USB 케이블: 타겟 시스템에 개발한 소프트웨어를 탑재할 수 있다.


	* UART란? Universal Asynchronous Receive / Transmitter 범용 비동기화 송수신기로써 직렬 장치를 이용한 통신을 말한다. 통신 내용은 시스템 콘솔을 사용해 확인 가능하다. 타겟 시스템의 프로그램이 제대로 작동되는지 모니터링 할 수 있고, 디버깅도 가능하게 한다.


#### 의문5. 임베디드 소프트웨어의 실행
	* 스타트업 코드(startup code): 하드웨어를 초기화 하고 운영체제 프로그램을 RAM으로 로딩하여 실행하는 부팅작업을 진행하는 코드. 
								   임베디드 시스템에서는 개발자가 직접 만들거나, 타겟 시스템 판매회사에서 제공하기도 한다.
								   시스템이 C를 인식하기 전의 코드이기 때문에 어셈블러 코드로 작성해야 한다.
	
	스타트업 코드는 인터럽트 벡터테이블*을 생성하고 메모리 검사와 C프로그램에서 사용할 스택과 힙을 생성하고 초기화 하는 등 C 프로그램이 작동하기 위한 초기화 작업을 수행한다. 

	* 인터럽트 벡터 테이블이란? 각각의 인터럽트가 걸리면 그에 해당하는 일을 하는 루틴을 인터럽트 핸들러라고 부르며, 즉 그 인터럽트가 걸리면 그 일을 처리하는 프로그램을 말한다. 이 인터럽트 핸들러라는 프로그램은  ROM BIOS 안에 어셈블러로 짜여있기도하고 DOS안에도 있고 우리가 직접 구현할 수도 있다. 이 각각의 인터럽트 핸들러의 시작번지를 모아 놓은 것을 인터럽트 벡터테이블 이라고 한다.
