# NULL OBJECT 패턴

Null Object는 null의 행위를 정의한 객체로, Null Object 디자인 패턴은 그러한 객체들의 사용과 행위를 나타낸다.

## 만들어진 동기
다형성의 진가는 객체에 타입을 묻지 않고 함수를 호출 할 수 있는데에 있다. 그 객체는 타입에 따라서 적절한 동작을 한다.
이렇게 하기에 덜 직관적인 곳 중의 하나가 필드에 null 값을 가지고 있는 것이다.
Java나 C#과 같은 대부분의 객체지향 언어에서 참조값은 null일 수 있다. 이러한 참조값들은 메소드를 호출하기 전에 객체가 널인지 확인해야 한다. Objective-C 는 nil의 메소드를 호출하면 nil을 반환하는 접근 방법을 취하기도 한다.

## NULL OBJECT 구조
Ron Jeffries는 다음과 같이 이야기한다.
> 시스템에 있는 많은 코드가 객체에 메세지를 보내기 전에 객체의 존재 여부를 검사한다는 사실을 Rich Garzaniti가 발견했을 때, 우리는 null 객체 패턴을 처음으로 사용하기 시작했다. 
> null 객체는 언제나 상수라는 것을 명심하라.
> null  객체에 대한 어떠한 것도 변하지 않는다.
> 따라서 우리는 Singleton Pattern을 사용하여 null 객체를 구현한다.


``` java
Employee e = DB.getEmployee(" Bob ");
if (e != null && e.isTimeToPay(today))
	e.pay();
```	

우리 중 대부분은 또한 null 을 테스트하는 것을 잊어버려서 난감한 상황을 호되게 당한 경험이 있다. 이런 관용적 표현이 흔하긴 할지라도, 이것은 보기 싫고 에러가 발생하기 쉽다.
DB.getEmployee()가 Null을 반환하는 대신 예외를 발생시키도록 하면 에러가 발생할 위험을 감소시킬 수 있다. 그러나 try/catch 블록은 null 을 검사하는 것보다 보기 싫을 수도 있다.
더 나쁜 경우, 예외 사용은 throws 절에 이를 선언하도록 만든다. 이것은 이미 존재하는 애플리케이션에 예외를 끼워 넣는 것을 어렵게 만든다.

__NULL OBJECT 패턴을 사용하면 이런 문제를 해결할 수 있다.__
이 패턴은 종종 null 검사의 필요를 제거하고, 코드를 단순화하는 데 도움이 된다.

NullEmployee는 Employee의 모든 메소드가 '아무 일'도 하지 않도록 구현한다. '아무 일'이라는 것은 메소드에 달려 있다.
예를 들어， isTimeToPay는 false를 반환하도록 구현될 것으로 생각할 수 있고, NullEmployee에 임금을 지불할 시기는 있을 수 없다.
이 패턴을 사용하기 위해서 원래 코드를 다음과 같이 변경할 수 있다.

``` java
Employee e = DB.getEmployee(" Bob ");
if (e.isTimeToPay(today))
	e.pay();
```

이것은 에러가 발생하기 쉬운 것도 아니고 보기 싫지도 않다. 여기에는 멋진 일관성이 있다.
DB.getEmployee는 항상 Employee의 인스턴스를 반환한다.
이 인스턴스는 그 직원을 찾았든, 못 찾았든 상관없이, 올바른 동작을 하도록 보장된다.
물론 DB.getEmployee 가 어떤 직원을 찾는 데 실패했는지 알고 싶은 경우도 많을 것이다.
이는 NullEmployee 의 유일한 인스턴스를 저장하는 Employee 의 정적 final 변수를 만드는 것으로 해결할 수 있다.

``` java
public void testNull () throws Exception {
	Employee e = DB.getEmployee("Bob") ;

	if (e.isTimeToPay(new Date()))
		fail();

	assertEquals(Employee.NULL, e);
}
```

NullEmployee를 위한 테스트를 보여 준다. 이 테스트에서 "Bob"은 데이터베이스에 존재하지 않는다. 단지 설명을 위한 구현이다.
"Bob"이란 문자열은 DB에 존재할 수도 있으니 실제로 이렇게 구현하면 안된다.
이 테스트에서 isTimeToPay 가 false 를 반환할 것을 기대한다는 사실에 주목하자.
또 DB.getEmployee 가 반환한 직원은 Employee.NULL 이 되는 것을 기대한다는 사실에도 주목하자.

``` java
import java.util.Date ;

public interface Employee {
	public boolean isTimeToPay(Date payDate );
	
	public void pay();
	
	public static final Employee NULL new Employee() {
		public boolean isTimeToPay(Date payDat e) {
			return false ;
		}
		public void pay() {}
	}
}
```

null 직원을 익명 내부 클래스로 만드는 것은 이것의 인스턴스가 오직 하나라는 것을 보장하는 방법이다.
본질적으로 NullEmployee 클래스는 존재하지 않는 것이다.
다른 어떤 누구도 null 직원의 다른 인스턴스를 생성할 수 없다.
이것은 우리가 다음과 같이 표현할 수 있기를 원하기 때문에 바람직한 것이다.

``` java
  if (e == Employee.NULL)
```

이것은 null 직원의 인스턴스를 여러 개 생성하는 것 이 가능하다변 신뢰할 수 없는 표현이 될 것 이다.

## Null Object 패턴의 장점
* 수많은 널 검사 로직 없이도 널 값으로 인한 에러를 막을 수 있다.
* 널 검사 로직이 최소화되어 코드가 간단해진다.

## Null Object 패턴의 단점
* Null Object를 도입하면 null 체크는 줄어들게 되지만 클래스의 수가 증가한다. -> nulll 오브젝트의 클래스를 원래 네스트한 클래스로 실현으로 해결
* Null Object 패턴은 전략패턴이나 상태패턴의 특수한 경우로 볼 수도 있다.
* "Design Patterns"에서 나온 패턴은 아니지만, Martin Fowler의 Refactoring (한글판 298쪽)과 Joshua Kerievsky의 책에 "Insert Null Object refactoring"으로 나와있다.

## Special case pattern
여러 종류의 null을 가질 수도 있다.
* 예) NoCustomer - 고객이 없는 경우. 새로운 빌딩을 지었는데 아직 입주하지 않은 경우.
	  UnknownCustomer - 누군가 있다는 것을 알지만, 그게 누구인지 모르는 경우.


* 숫자의 예
	* 양의 무한대, 음의 무한대, 숫자가 아닌 경우(NaN) 등등
	* NaN에 대한 연산은 NaN을 반환한다.
* Special case들은 에러를 다루는 작업을 줄이는데 도움이 된다는 점에서 도움이 된다.


## 결론
C 기반 언어를 오래 사용해온 사람들은 어떤 종류의 실패에 대해 null이나 0을 반환하는 함수에 익숙하다. 이들은 이런 함수의 반환값은 검사되어야 할 펼요가 있다.그러나 __NULL OBJECT__ 패턴은 다르다. 이 패턴을 사용하면, 우리는 함수가 실패한 경우에도 항상 유효한 객제를 반환한다는 것을 보장할 수 있다.
실패를 나타내는 객체들은 ‘아무 일도’ 하지 않는다.

## Test

### 리팩토링 전

``` java
class Label {
	private String label;

	public void display() {
		System.out.println(this.label);
	}

	public Label(String label) {
		this.label = label;
	}
}

class Person {
	private Label name;
	private Label email;

	public Person(Label name, Label email) {
		this.name = name;
		this.email = email;
	}

	public Person(Label name) {
		this.name = name;
		this.email = null;
	}

	public void display() {
		name.display();

		if (email != null) {
			email.display();
		}
	}
}

public class Program {
	public static void main(String args[]) {
		Person[] people = {new Person(new Label("taerin"), new Label("taerin@gmail.com")),
			new Person(new Label("tom"))};

		for (Person p : people) {
			p.display();
		}
	}
}

```

### 리팩토링 후
``` java
class Label {
	private String label;

	public void display() {
		System.out.println(this.label);
	}

	public boolean isNull() {
		return false;
	}

	public Label(String label) {
		this.label = label;
	}
}

// 1. Null 오브젝트 클래스 만들기
class NullLabel extends Label {
	public NullLabel() {
		super("(none)");
	}
	// 2. isNull 메소드 만들기
	@Override
		public boolean isNull() {
			return true;
		}

	// 아무일도 하지 않는 display  메소드 생성
	@Override
		public void display() {
		}
}

class Person {
	private Label name;
	private Label email;

	public Person(Label name, Label email) {
		this.name = name;
		this.email = email;
	}

	public Person(Label name) {
		this.name = name;
		this.email = new NullLabel();
	}


	public void display() {
		name.display();

		// 3. null check를 메소드 호출로 치환하기.
		if (!email.isNull()) {
			email.display();
		}
	}
}

public class Program {
	public static void main(String args[]) {
		Person[] people = {new Person(new Label("taerin"), new Label("taerin@gmail.com")),
			new Person(new Label("tom"))};

		for (Person p : people) {
			p.display();
		}
	}
}

```

## 발전된 모양
``` java
class Label {
	private String label;

	// 내부 정적 클래스를 사용하는 싱글톤 사용 - IODH(Initialization On Demand Holder)
	// 많은 클래스가 생성되는 문제를 해결할 수 있다.
	private static class NullLabel extends Label {
		private static final NullLabel INSTANCE = new NullLabel();

		private static NullLabel getInstance() {
			return INSTANCE;
		}

		public NullLabel() {
			super("(none)");
		}

		@Override
			public boolean isNull() {
				return true;
			}

		@Override
			public void display() {
			}
	}

	// 정적 팩토리 메소드 - 인스턴스의 생성에 직접 클래스명을 사용하는 것을 숨기고 싶어서 사용
	public static Label newNullLabel() {
		return NullLabel.getInstance();
	}

	public void display() {
		System.out.println(this.label);
	}

	public boolean isNull() {
		return false;
	}

	public Label(String label) {
		this.label = label;
	}
}

class Person {
	private Label name;
	private Label email;

	public Person(Label name, Label email) {
		this.name = name;
		this.email = email;
	}

	public Person(Label name) {
		this.name = name;
		this.email = Label.newNullLabel();

		// Label$NullLabel@511d50c0
		// Label$NullLabel@511d50c0
		// 싱글톤을 사용하기 때문에 실제로 만들어지는 객체의 주소가 같은 것을 확인할 수 있다.
		System.out.println(this.email);
	}

	public void display() {
		name.display();

		if (!email.isNull()) {
			email.display();
		}
	}
}

public class Program {
	public static void main(String args[]) {
		Person[] people = {new Person(new Label("taerin"), new Label("taerin@gmail.com")),
			new Person(new Label("tom")),
			new Person(new Label("kkk"))};

		for (Person p : people) {
			p.display();
		}
	}
}
```

