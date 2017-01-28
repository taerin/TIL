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
@property를 이용할 경우 애플에서 권고하는 네이밍 룰을 사용해야 한다. @synthesize 를 이용하면 프로퍼티의 get/set 메소드를 자동으로 생성하기 때문에 상관 없지만 get/set 메소드를 직접 구현할 경우 룰을 따라야 한다.

일반적으로  get 메소드는 프로퍼티 이름을 get 메소드 이름 그대로 사용한다. Boolean 타입의 경우 프로퍼티 이름 앞에 is 를 붙일 수 있다.  set  메소드의 경우 프로퍼티 이름앞에 set 을 붙이고 프로퍼티 이름 첫글자는 대문자를 사용한다. 
KVC 는 non-object 타입 (scalar 와 struct) 도 지원하며 자동으로 NSNumber, NSValue 로 자동 wrapping 된다.

프로퍼티가 object 타입이 아닌 경우, nil 값 설정을 대비한 조치를 취할 필요도 있다. setNilValueForKey : 메소드는 프로퍼티에 nil 값이 설정될 때 호출되는데 이 메소드를 이용하면 Boolean 타입 같은 non-object 타입에 nil 값이 설정될 때 적절한 값으로 대체할 수 있다.

아래 예제 코드는 Boolean 타입인 hidden 프로퍼티에 nil 값 설정이 시도되면 ‘YES’ 값으로 초기화 하고, hidden 프로퍼티가 아닌 경우에는 nil 값을 설정하는 코드다.

``` objc
-(void)setNilValueForKey:(NSString *)theKey{

	if([theKey isEqualToString:@"hidden"]){

		[self setValue:@"YES" forKey:@"hidden"];

	} else {

		[super setNilValueForKey:theKey];

	}

}
```

* 출처: https://soulpark.wordpress.com/2012/09/03/objective-c-key-value-coding/





