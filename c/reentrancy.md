# Reentrancy (재진입성)

1. 재진입성이란?
재진입성은 동일한 함수가 병렬적으로 호출되었을 때 서로 다른 공간을 가지므로 서로 크리티컬 섹션 문제와 같은 오염에 대한 걱정을 할 필요가 없는 경우의 환경으로 디자인 된 것을 의미한다.
	* 병렬실행이 가능하다.
	* 재진입이 가능하려면 전역-정적변수를 제거하여 인자로 상태를 저장할 버퍼를 제공해야한다.
	* 순수함수가 되기위해 만족해야하는 참조투명성이란 전역-정적변수에 의존하지 않는 상태를 말한다. 
	* 재진입성은 Functional Programming의 핵심
	* 재귀호출을 포함한 병렬 실행을 완벽히 보장

	Reentrant 하면 ---X--> 순수함수다
	Reentrant 하면 <--O--- 순수함수다


2. Unix / Windows 차이점
	* Unix : strtok(buf, delimeter) / strtok_r(buf, delimeter, &ptr) 두가지 저번의 함수를 생성
	-> 함수의 인터페이스를 변경함
	
	* Windows : strtok -> TLS로 수정
	-> 함수의 인터페이스를 변경하지 않고 라이브러리를 변경
	
	* Windows의 장점 : 기존 인터페이스 변경이 필요 없다.
	  Windows의 단점 : C표준과 다르다.(C표준의 strtok 는 전역 상태에 의존)

3. Thread-safe와 Reentrancy의 차이점

	* Thread-safe : 동기화를 스레드 안전하게 동작하게 하는 것
				복수의 스레드에서 호출 될 수 있고 병렬로 실행 될 수 도 있다. 다만 완벽히 병렬을 보장하지는 않고 전역/정적변수나 공유객체가 있다면 Mutex와 같은 매커니즘으로 보호해야만 한다. 오직 Thread-safe만을 만족하는 코드라면 정적공간이나 공유객체 사용시 진입순서에 따라 실행결과가 달라질 수 있다.

	* 어떤 함수가 병렬실행이 가능하고 정적공간을 사용하지 않는 구조 
				-> reentrancy 하다.
	* 어떤 함수가 병렬실행이 가능하지만 서브루틴에서 정적공간이나 공유객체를 사용하며 Mutex와 같은 상호배제 기술을 사용하였다면
				-> Thread-safe 하다.

	Reentrant 하면 ---O--> Thread-Safe 하다
	Reentrant 하면 <--X--- Thread-Safe 하다

4. Thread가 공유하지 않는 전역 변수가 필요한 경우
 TLS(Thread Local Storage) / TSS(Thread Specific Storage) 을 사용한다.
