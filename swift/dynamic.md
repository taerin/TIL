# Dynamic

Objective-C에서는 클래스의 메서드를 호출하거나 프로퍼티를 참조하는 것을 “함수 호출”이라고 하지 않고 “메시지 전송” 혹은 “메시지 디스패치”라고 합니다. 
이렇게 부르는 이유는 Objective-C의 런타임의 동적 바인딩 속성과 관련이 있습니다. 전통적인 “메서드 호출”이 Objective-C에서는 해당 객체에 메시지를 전달하는 과정으로 구현되어 있습니다. 
호출자가 “메서드 f를 실행”이라는 메시지를 대상 객체에 전송하고 이 메시지를 수신한 객체는 요청받은 메서드의 구현체를 찾아서 실행하게 됩니다. 
여기서 메시지를 수신한 후에 구현코드를 찾는다는 점이 중요합니다. 정적 디스패치의 경우에는 컴파일 타임에 이미 어떤 구현코드가 호출 되어야할지 결정되어 있고 따라서 그 상황에 적절한 코드 최적화를 적용할 수 있습니다. 
하지만 동적 디스패치에서는 이러한 과정이 런타임에 발생하므로 컴파일 타임의 코드 최적화가 적용될 수 없는 반면에 런타임에 함수나 메서드의 구현 코드를 바꿔치기할 수 있습니다. 
이런 기법은 메서드 스위즐링(Swizzling)이라고 합니다. Objective-C의 메서드 스위즐링에 대한 자세한 내용은 [여기](http://nshipster.com/method-swizzling/)를 참조하시기 바랍니다.

dynamic 키워드는 함수나 변수의 선언문에 적용할 수 있는 선언 변경자 (declaration modifier)입니다. dynamic이 하는 일은 런타임이 정적 디스패치 (static dispatch)대신에 동적 디스패치(dynamic dispatch)를 사용하도록 합니다. dynamic을 함수나 변수에 적용하면 자동으로 @objc 어트리뷰트를 추가하게 됩니다.

여기서 중요한 점은 dynamic 키워드가 적용된 것은 스위프트 런타임 대신에 Objective-C 런타임을 사용하여 메시지를 전송한다는 것입니다.

대부분은 경우 정적 디스패치로 충분하지만 NewRelic과 같은 앱 분석기(app analytics)에서는 문제가 있습니다. 정적 디스패치로는 함수가 호출되는 과정에 분석을 위한 코드를 동적으로 생성하여 삽입하는 것이 어렵기 때문입니다. 정적 디스패치를 사용하여 얻을 수 있는 최적화를 포기하는 대신에 dynamic을 사용하면 이런 상황에 대처할 수 있게 됩니다. dynamic의 사용법은 다음과 같습니다.

``` swift
class MyClass {
	dynamic var imADynamicallyDispatchedString: String

		dynamic func imADynamicallyDispatchedFunction() {
			//여기의 구현 코드는 동적 디스패치로 호출됩니다.
		}
}
```

동적 디스패치를 사용하여 얻을 수 있는 또 다른 한 가지는 KVC/KVO에 의존적인 Core Data와 같은 Objective-C 런타임과의 효율적인 연동이 가능하다는 것입니다. Objective-C에서 오랫동안 사용해온 것들을 스위프트에서 그대로 사용하고 싶다면 dynamic을 적용하면 됩니다.

출처: https://outofbedlam.github.io/swift/2016/01/27/Swift-dynamic/
