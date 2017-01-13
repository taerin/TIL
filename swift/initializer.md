# Initializer (초기화 메소드)

## 기본 이니셜라이저
Java나 C#, C++ 에서는 클래스를 정의하고 사용자가 생성자를 정의하지않으면 기본 생성자를 컴파일러가 만들어줍니다. 마찬가지로 Swift에서도 아무 일도 하지 않는 기본 이니셜라이저를 만들어줍니다.

## 멤버와이즈 이니셜라이저
모든 프로퍼티들의 초기화를 수행하는 이니셜라이저를 말합니다. 멤버와이즈 이니셜라이저는 class에는 사용할 수 없는 property를 위한 특권입니다.

``` swift
property  User {
   var name: String
   var age: Int
   var level: Int
   var gold: Int
   var cash: Int
   
   init(name: String, age: Int, level: Int, gold: Int, cash: Int) {
       self.name = name
       self.age = age
       self.level = level
       self.gold = gold
       self.cash = cash
   }
}
```

## 사용자 정의 이니셜라이져
사용자 정의 이니셜라이저는 Java의 생성자 오버로딩과 비슷한 문법입니다.
만약 자바에서 사용자 정의 생성자를 정의했다면 기존의 컴파일러가 자동 생성해주는 기본 생성자는 사용 할 수 없고 같은 타입과 같은 인자 수를 가진 생성자는 오버로딩 될 수 없기때문에 여러개의 필드를 가진 클래스의 경우 특정 값만을 초기화하며 객체를 생성해주려면 정적 팩토리 메소드를 사용해야 합니다. 아래는 정적 팩토리메소드의 코드입니다.

``` java
class Point {

	int x;
	int y;

	Point(int x, int y) {
		this.x = x;
		this.y = y;
	}

	static Point initializeX (int x) {
		Point(x, 0);
	}

	static Point initializeY (int y) {
		Point(0, y);
	}
}
```



 

