# 인트로스펙션 (Introspection)
인트로스펙션 (Introspection)은 자바의 리플렉션(reflection)과 같이 객체의 메타데이터(객체의 클래스, 구현 메소드, 프로퍼티, 프로토콜 등의 객체정보)를 조사하는 과정을 의미한다.
객체의 클래스에 대한 가정이 적을 수록 코드는 강력하고 유연해진다. 따라서 각 객체의 클래스 타입, 구현 메소드 이름 등을 직접 확인할 수 있다면 프로그래밍이 더 간결해질 수 있다.

코딩 중에 흔히 발생하는 - 쓰이는 - 질문들은 다음과 같다.
	* 이 객체가 특정 메소드를 구현하고 있는가?
	* 이 객체는 특정 클래스가 인스턴스인가?
	* 이 객체는 특정 클래스나 서브클래스의 인스턴스인가?

## 메소드 구현 확인
NSObject의 -respondsToSelector: 메소드를 이용하면 해당 객체의 메소드 구현 여부를 간단히 확인할 수 있다.
예) if (myObject respondsToSelector: @selectro(testMethod))
객체가 해당 메소드에 반응하면 YES(true)를 반환한다. 리스너 그룹에 메소드 구현 여부에 따라 특정 메시지를 전달하는 예제는 아래와 같다. 

``` objc
-(void)updateListenersUsingSelector:(SEL)sel{

    for(id listener in listeners){

        if(listener respondsToSelector:sel]){

            [listener performSelector:sel withObject:self];

        }

    }

}
```

참고로 어떤 메소드를 구현했는지를 근거로 객체의 역할을 인지하는 방법을 비공식 프로토콜(informal protocol)이라고 한다.

## 클래스 타입 확인
자바는 instanceof 연산자를 이용하여 객체의 역할을 인지하는 방법을 비공식 프로토콜(informal protocol)이라고 한다.

## 클래스 타입 확인
자바는 instanceof 연산자를 이용하여 객체의 클래스의 정보(타입, 인터페이스 상속 여부 등)를 확인한다. Objective-C 에서는 NSObject 에서 구현하고 있는 다음 메소드들을 이용한다.
	* -isKindOfClass:(Class)class : 어떤 클래스의 인스턴스인지, 어떤 클래스의 서브클래스인지 확인.
	* -isMemberOfClass:(Class)class : 특정 클래스인지 확인
	* confirmsToProtocol:(Protocol*)protocol : 어떤 프로토콜을 따르는지, 어떤 프로토콜을 준수한 클래스를 상속하는지 확인.

Objective-C 는 내부적으로 클래스와 프로토콜 채택을 다르게 취급한다. 따라서 자바의 instanceof 연산자처럼 하나의 메시지를 갖지 않고, __클래스 확인은 -isKindOfClass:__ , __프로토콜 확인은 -confirmsToProtocol:__ 을 사용한다.
	
``` objc
if([myObject isKindOfClass:[MyClass class]]){

    MyClass *newObject = myObject;

    ...

}

if([myObject confirmsToProtocol:@protocol(MyProtocol)]){

    id<MyProtocol> newObject = myObject;

}
```

NSObject  메소드를 이용하면 위에서 설명한 것처럼 간단한 경우에 객체 정보를 쉽게 확인할 수 있다. NSObject 메소드 외에 Objective-C 런타임을 이용하면 더 다양한 객체의 정보를 확인할 수 있다. 
Objective-C 의 런타임 시스템은 자바와는 다르게 투명성을 갖도록 설계되었다. Objective-C 런타임을 이용하면 클래스의 생성, 등록, 수정, 인스턴스화, 메시지 전송 등이 직접 가능하다.
인트로스펙션을 지원하는 전체 메소드의 상세 정보는 Objective-C Runtime Reference 를 참고하자. (Objective-C Runtime Reference) 여기서는 간단히 몇 가지만 확인해보겠다. (NSObject 메소드를 이용한 인트로스펙션이 일반적인 경우 많이 사용될 것 같다.)

## 1) 클래스 조사
	* objc_getClass(const char*) : 해당 이름의 클래스
	* class_getName(Class) : 해당 클래스의 이름
	* class_getSuperclass(Class) : 해당 클래스의 슈퍼 클래스

``` objc
Class class = [myObject class];

While(class != Nil){

	// 

    class = class_getSuperclass(class);

}
```

## 2) 프로토콜 조사
	* objc_getProtocol(const char*) : 해당 이름의 프로토콜
	* class_copyProtocolList(Class, unsigned int*) : 해당 클래스가 준수하는 프로토콜 목록
	* protocol_getName(Protocol *) : 해당 프로토콜의 이름

## 3) 메소드 조사
	* class_getClassMethod(Class,SEL) : 셀렉터가 클래스로 전달되는 경우에 Method 반환
	* method_getName(Method) : Method 에 대한 셀렉터 상수
	* NSSelectorFromString(NSString * ) : 이름에 해당하는 셀렉터
	* method_getImplementation(Method) : Method 를 구현하는 코드의 주소

## 4) 프로퍼티 조사
	* class_getProperty(Class, const char*) : 해당 이름의 프로퍼티에 대한 objc_property_t 구조체
	* property_getName(objc_property_t) : 프로퍼티 이름
	* property_getAttributes(objc_property_t) : 프로퍼티의 속성(read-only, nonatomic 등 ) 문자열

## 5) 인스턴스 변수 조사
	* ivar_getName(Ivar) : 변수의 이름
	* object_getIvar(id, Ivar) : 객체 변수의 값

(key-value coding) 는 Objective-C 의 핵심 기능으로 인트로스펙션과 밀접한 관련이 있다. 
*Reference : Learn Objective-C for Java Developers

* 출처: https://soulpark.wordpress.com/2012/09/03/objective_c_introspection/






