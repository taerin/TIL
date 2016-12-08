# Property
-----
## 1.Property 란? 
필드 생성과 접근자 메소드를 한번에 생성해주는 기법이다.
클래스와 구조체에 공통되는 요소로, 프로퍼티는 OOP에서 멤버변수(Member Variables) 혹은 속성(Attributes)이라고도 불리우는 개념이다. 쉽게 말해 클래스나 구조체 안에 선언되어서 사용하는 '소속된 변수'이다.


## 2. Field VS Property
* Field : Instance Variable로 해당 필드에 접근하거나 접근하여 어떤 동작을 하고싶다면 getter 와 setter(accessor method, 접근자 메소드)를 따로 작성해주어야 합니다.
* Property : C#과 Swift에서 사용되는 개념으로 field와 비슷하나 자동으로 getter 와 setter가 생성됩니다. 

아래 코드는 C# 에서field 와 property 개념이 어떻게 구분되는 지를 알려줍니다.
``` csharp
public class MyClass
{
	// this is a field.  It is private to your class and stores the actual data.
	private string _myField;

	// this is a property.  When you access it uses the underlying field, but only exposes
	// the contract that will not be affected by the underlying field
	public string MyProperty
	{
		get
		{
			return _myField;
		}
		set
		{
			_myField = value;
		}
	}
}
```
## 3. 읽기쓰기(read-write)와 읽기전용(read-only)
프로퍼티를 엑세스 관점에서 보면 크게 두 분류로 나누어진다. 

* 클래스나 구조체 내부나 외부에서 마음껏 읽고 쓸 수 있는 프로퍼티(read-write)
* 읽기만 가능한 프로퍼티(read-only)

이건 정말 단순하게 구분된다. 상수나 변수 선언하는 것과 동일하게, var로 선언되면 읽기쓰기가 자유로운 프로퍼티가 되고, let으로 선언되면 읽기 전용 프로퍼티가 된다. 
다만 var로 선언된 프로퍼티라도 getter 기능만이 제공되면 읽기 전용으로 사용된다.

## 4. 나중에 생성되는 프로퍼티 (Lazy Stored Propeties)
``` swift 
class SomeClass {
	
	@lazy var date = BaseDate()

}

var some = SomeClass()
some.date.print()
```
위 코드에서 @lazy로 선언된 date 프로퍼티는 SomeClass가 인스턴스화 될 때 생성될 것 같지만, 실제로는 가장 마지막의 date를 액세스 하는 순간에 생성된다. 만약 이 프로퍼티의 인스턴스가 메모리를 많이 잡아먹는다면 이런 식으로 필요할 때 생성되도록(lazy) 선언해두면 메모리 관리 효율이 좋아질 것이다.


## 5. Getter와 Setter 
프로퍼티를 그냥 변수 처럼 사용 할 수도 있지만, 프로퍼티에 데이터를 넣거나 프로퍼티를 다른 곳에서 참조 할 때 특별한 일을 하게 만들 수도 있다. 
``` swift
class DoublingClass {
	var a = 0
		var b = 0
		var data: Int {
			get {
				return a + b
			}
			set(value) {
				self.a = value / 2
				self.b = value / 2
			}
		}

	init() {}
}
```
위 예제에서 data 프로퍼티는 Int 타입이지만 set과 get이라는 기능을 추가로 정의하고 있다. 여기서 get은 이 data에 데이터를 넣으려고 할 때 작동하는 코드이다.

실제로 테스트 해 보면 이런 식으로 동작한다. 

``` swift
var d = DoublingClass()
d.a             // 0
d.b             // 0
d.data = 10     // a=5, b=5
d.a             // 5
d.b             // 5
d.a = 6
d.b = 10
d.data          // 16
```

굵게 표시한 부분이 위에서 와etter를 정의한 data를 다루는 부분이다. .data에 값을 대입하니 자동으로 a와 b 프로퍼티에 해당 값을 2로 나눈 값이 할당된다. 반대로 .data의 값을 읽을 때는 a와 b 프로퍼티의 내용을 더한 값을 돌려준다. 

스위프트의 프로퍼티는 이렇게 setter와 getter라는 특징을 부여 할 수 있다.

## 6. 축약형 setter와 getter
앞의 예제에서 data의 setter를 약간 변형해보자. 

``` swift
var data: Int {
	get {
		return a + b
	}
	set {
		self.a = newValue / 2
		self.b = newValue / 2
	}
}

```

앞서 set(value) 라는 정의가 그냥 set으로 바뀌었다. 그리고 set 코드 내부에서는 newValue 라는 정의되지도 않은 심볼이 쓰이고 있다.

이 코드는 축약형 setter 정의(ShortHand Setter Declaration)를 활용한 것으로, setter의 매개변수가 하나이기 때문에 생략시키고 이를 newValue 라는 이름으로 쓸 수 있도록 미리 스위프트가 준비해 주는 것을 이용한 것이다.

이런 축약형은 getter에도 존재하는데 좀 다른 제한이 있다. read-only로 정의하려는 경우에만 사용이 가능하다. 아래 코드는 data 프로퍼티의 setter를 없애고 read-only getter를 정의하는 코드이다. 

``` swift
var data: Int {
	return a + b
}
```
get이라는 이름이 아예 사라졌다. 그리고 프로퍼티 선언 뒤에 바로 중괄호가 시작되고 getter의 내용이 들어간다.

이렇게 만든 .data 프로퍼티는 이제 read-only 로만 동작하게 된다. 하지만 data의 참조 결과는 이전과 동일하다.

* 읽기 전용으로 getter만 있는 프로퍼티라도 let으로는 선언하지 못 한다. setter나 getter가 필요하다면 무조건 var로 선언해야 한다.

## 7. 프로퍼티 상속
앞서 설명한 프로퍼티의 Setter와 Getter 덕분에 스위프트에는 프로퍼티 상속이 꽤 중요하다. 참고로 상속은 클래스만의 기능이기 때문에 프로퍼티 상속 또한 클래스의 프로퍼티만 가능하다.

스위프트의 프로퍼티는 setter와 getter 라는 특유의 함수와 비슷한 능력을 가질 수 있다. 그래서 프로퍼티 자체를 상속받아 이 setter와 getter를 오버라이드 하는 것도 가능하다. 

``` swift
class DdablingClass : DoublingClass {
	override var data: Int {
	   return (a + b) * 2
	}
}

var dd = DdablingClass()
dd.a = 10
dd.b = 20
dd.data   // 60

```
더블링클래스를 상속받은 따블링클래스(-_-)를 만들었다. 그리고 data 프로퍼티를 override(상속 및 재구현)해서 getter를 재정의했다. 그리고 물론 결과는 오버라이드된 결과물이 나온다.

메소드 편에서도 이야기 하겠지만, 스위프트는 오버라이드를 하려는 것 앞에 반드시 override 키워드를 붙여야 한다.

## 8. 정적 프로퍼티
정적 프로퍼티라는건 클래스가 인스턴스화 되지 않아도 참조가 가능한 프로퍼티를 의미힌다. 사실 이 부분의 정확한 명칭은 타입 프로퍼티(Type Properties)가 되어야 하지만 일반적으로는 정적 멤버(Static Member)로 불리우기 때문에 그냥 제목을 이렇게 적었다.

C++이나 Objective-C나 기타 많은 언어에서 비슷한데, 구조체(struct)나 열거형(enum)에서 static 키워드를 이용한다. 

``` swift
struct HTTPResponseStruct {
	static var success = 200
	static var notFound = 404
	static var serverError = 500
}

var code1 = HTTPResponseStruct.success

enum HTTPResponseEnum {
	static var success = 200
	static var notFound = 404
	static var serverError = 500
}

var code2 = HTTPResponseEnum.notFound
```


특징은 인스턴스로 만들지 않아도 멤버를 바로 액체스 할 수 있다는 점이다. 그래서 특정한 구조체 등에 소속되는 매크로 상수와 비슷한 용도로 사용한다.
하지만 var로 선언한 이상 쓰기가 가능하다는 특징을 염두해 두자. 위에서 HTTPResponseStruct에 정의된 정적 프로퍼티는 모두 외부에서 값을 어싸인 할 수 있다. 본의아니게 마치 싱글톤처럼 이용하는게 가능해진다. 어쨌든 외부 변경을 피하려면 let으로 선언하는 것을 잊지 말자.


그런데 정작 클래스(class) 에서는 정적 프로퍼티를 사용 할 수가 없다. 미래에 지원할지 모르겠지만 '아직 클래스에서 static을 사용 할 수 없다'는 오류메시지가 뜬다. 대신 클래스 내부에서는 class var 라는 독특한 타입을 명시해 주면 동일하게 사용이 가능하다. 

``` swift
class HTTPResponseClass {
	class var success: Int {
		return 200
	}
	class var notFound: Int {
		return 404
	}
	class var serverError: Int {
		return 500
	}
}

var code3 = HTTPResponseClass.serverError

```
결과적으로 클래스로도 동일하게 인스턴스(객체)를 만들지 않고도 참조가 가능하다.


## 9. Property의 장점
java 에서 처럼 this.name  = // 방법과 같이 메모리에 직접 접근하는 것보다 property를 사용하는 것의 장점은 정책이나 이름이 변경되었을때 getter와 setter만을 찾아 변경해주면 된다는 장점이 있다.
C#을 예로 들면 한 프로그램 내에서 고객의 이름이 반드시 존재하도록 하고 싶다고 하면 해당 property로 가서 set 관련 함수를 변경해주면 된다.
또 만일 public 데이터 멤버 형태로 고객의 이름을 저장하고 있었다면 코드 전체에서 customer이름을 변경하는 부분을 모두 찾아내어 수정해야 하는데, 이는 많은 시간이 소모된다.

출처: http://seorenn.blogspot.kr/2014/06/swift-properties.html
