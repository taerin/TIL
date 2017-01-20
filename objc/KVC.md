#Key-Value Coding (KVC)

키 밸류 코딩(key-value coding, KVC)은 문자열(키)를 이용해 객체의 프로퍼티에 접근(set or get)할 수 있게 해준다. 키 벨류 코딩(key-value coding, KVC)은 문자열(키)를 이용해 객체의 프로퍼티에 접근(set or get)할 수 있게 해준다.

KVC를 구현하는 메소드는 NSKeyValueCoding Protocol에 의해 정의되며 NSObject는 이를 구현하고 있다.

KVC 가 문자열을 통해 객체 프로퍼티에 접근하는 내부 구현은 다음과 같다. (valueForKey : 메소드와 setValue: ForKey: 메소드의 상세 내부 원리는 차이가 있으나 큰 틀에서는 비슷하다.)

	1. key 값과 일치하는 프로퍼티를 찾는다.
	2. 프로퍼티가 없으면 key 값과 일치하는 인스턴스 변수명을 찾는다.
	3. 프로퍼티 또는 인스턴스 변수가 발견되면 발견된 프로퍼티 또는 인스턴스 변수를 적용한다.
	4. 일치하는 프로퍼티 또는 인스턴스 변수가 없으면 valueForUndefinedKey : 또는 setValue: ForUndefinedKey: 메시지를 호출한다. (기본적으로 이 메소드는 Exception 을 발생시키며, 필요에 따라 override를 통해 재정의 가능하다.) 

위와 같은 내부 원리로 인해 KVC 는 접근자를 통한 프로퍼티 접근보다 속도가 약간 느리다. 따라서 KVC 는 소프트웨어 구조 측면에서 유연성이 필요한 경우에만 사용하는 것이 좋다.
KVC 는 KVO(Key-Value Observing), Cocoa Binding, Core Data, 어플리케이션의 AppleScript 적용의 기술적 기반이 된다.
 
## KVC 호환 클래스 설계
Key-Value Observing, Key-Value Binding, Key-Value Scripting 같은 기술을 사용할 때 대부분 KVC를 간접적으로 사용한다. 프로퍼티를 조사하거나 바인딩 할 때 모두 KVC를 사용하기 때문이다. KVC를 사용하려면 객체가 KVC와 호환되게 해야한다.
위에서 설명한 바와 같이 KVC는 인스턴스 변수에 대해 인트로스펙션을 
@property를 이용할 경우 애플에서 권고하는 네이밍 룰을 사용해야 한다. 




