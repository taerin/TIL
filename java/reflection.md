#Reflection
리플렉션이란 객체를 통해 클래스의 정보를 분석해 내는 프로그램 기법을 말한다. Class 이름만으로 클래스 정보(필드, 메소드)를 찾거나, 변경하거나 동적으로 생성할 수 있는 기능이다.
Java와 C#은 Reflection이라고 부르고, Objc, Swift는 Introspection이라고 부른다.

## 클래스의 Class를 얻는 방법 3가지
1) 객체를 통해서 얻기
2) 클래스를 통해서 얻기
3) 문자열 이름을 통해서 얻기 => try-catch

## 리플렉션 용도
1) 클래스의 속성 얻기 (예: abstract 클래스 여부등..)
2) Method 속성 얻기 (메소드 이름이나, 파라미터 수를 알 수 있다)

``` java
public class Reflection {
	public static void main(String[] args) {
		Person person = new Person("Tom");

		// 클래스의 Class 를 얻는 방법 3가지
		// 1) 객체를 통해서 얻기
		Class c1 = person.getClass();

		// 2) 클래스 통해서 얻기
		Class c2 = Person.class;

		// 3) 문자열 이름을 통해서 얻기
		try {
			Class c3 = Class.forName("example7.Person");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		// 용도
		// 1) class의 속성 얻기
		int m = c1.getModifiers();
		System.out.println("is abstract: " + Modifier.isAbstract(m));
		System.out.println("is final: " + Modifier.isFinal(m));
		System.out.println("is public: " + Modifier.isPublic(m));

		// 2) Method 속성 얻기
		Method[] methods = c1.getMethods();
		for (Method e : methods) {
			System.out.println(e.getName());
			System.out.println(e.getParameterCount());
			Class[] params = e.getParameterTypes();
			for (Class p : params)
				System.out.println("\t" + p.getName());
		}

	}
}

class Person {
	public String s;
	private String name;
	private int age;

	public Person(String name) {
		this.name = name;
	}

	private Person(String name, int age) {
		this.name = name;
		this.age = age;
	}


	public String getName() {
		return name;
	}

	public void setName(String s) {
		this.name = s;
	}
}
```

## 필드 속성 얻기 용도
1) public field 값을 읽거나 쓰기
2) public 아닌 field 값을 읽거나 쓰기

``` java 
class Point {
	public int x;
	private int y;

	@Override
	public String toString() {
		return "Point{" +
			"x=" + x +
			", y=" + y +
			'}';
	}
}

public class Reflection2 {
	public static void main(String[] args) throws Exception {
		Point p = new Point();
		System.out.println(p);

		// 1. public field 값을 읽거나 쓰기
		Class c1 = p.getClass();
		Field xField = c1.getField("x");

		xField.set(p, 3);
		System.out.println(xField.get(p));

		// 2. public 아닌 field 값을 읽거나 쓰기
		Field yField = c1.getDeclaredField("y");

		yField.setAccessible(true);  // 접근 할 수 없는 private필드에 접근하여 값을 변경할 수 있다.
		yField.set(p, 100);
		System.out.println(p);
	}
}
```

## 객체를 Class를 통해서 생성하기
1) 객체 생성하기 - 기본 생성자의 호출만 가능하다.
2) 인자있는 생성자 호출하기

``` java
public class Reflection3 {
	public static void main(String[] args) throws Exception {
		Class c1 = Class.forName("example7.Point");

		// 1. 객체 생성하기.
		//  newInstance() - 기본 생성자의 호출만 가능하다.
		Point point = (Point) c1.newInstance();
		System.out.println(point);

		// 2. 인자 있는 생성자 호출하기
		Class<Person> c2 = Person.class;
		Class[] paramTypes = {
			String.class, int.class
		};

		Constructor<Person> constructor = c2.getDeclaredConstructor(paramTypes);
		constructor.setAccessible(true);

		Person p = constructor.newInstance("Tom", 42);
		System.out.println(p);
	}
}
```
