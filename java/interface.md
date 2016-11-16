# Interface 사용

기본적으로 더하기와 빼기연산만을 하는 계산기를 만드는 예제로 설명하겠다.

``` java
// 1. 인터페이스를 이용하면 교체 가능한 유연한 디자인을 가능하게 한다.
// 2. 범용 인터페이스 보다는 세분화된 인터페이스가 낫다.
	// ISP(Interface Segregation Principle)

interface Calculator{
	int add (int a, int b);
	int sub (int a, int b);
}

class CalculatorFactory {
	static class BasicCalculator implements Caculator{
		public int add (int a, int b){
			return a + b;
		}

		public int sub (int a , int b){
			return a - b;
		}
	}

	// 4. 정적 팩토리 메소드를 이용하여 클라이언트가 구체적인 타입이 아닌
	// 인터페이스나 추상클래스를 통해 객체를 이용할 수 있도록 하는 설계
	public static Calculator defaultCalculator(){
		return new BasicCalculator();
	}
}


public class InterfaceSample {
	public static void main(String[] args){
		// 3.  클라이언트는 구체 클래스가 아닌 추상 클래스에 의존해야 한다.
		// BasicCalculator cal = new BasicCalcultor();
		// Calculator cal = new BasicCalculator();

		Calculator calculator = CalculatorFactory.defaultCalculator();
	}
}
```

추가적으로 클라이언트가 곱셈(mul)의 기능을 요구한다.

``` java
interface Calculator{
	int add (int a, int b);
	int sub (int a, int b);

	// 6. java 8: default(defender) method
	// - 인터페이스 메소드의기본 동작을 정의하는 메소드 (구현을 가질 수 있다.
	// - 새로운 API의 추가로 인한 인터페이스의 변경으로 인해 자식클래스가 깨지는 문제를 방어한다. -> defender method 인 이유
	default int mul (int a, int b){
		int n = 0;
		for(int i = 0; i < b; i++)
			n += add(n, a);

		return n;
	}

	class CalculatorFactory implemets Calculator {
		static class BasicCalculator implements Caculator{
			public int add (int a, int b){
				return a + b;
			}

			public int sub (int a , int b){
				return a - b;
			}

			// 오버라이딩을 통한 동작의 변경이 가능하다.
			@Override
				public int add (int a, int b) {
					return a * b;
				}
		}

		// 5. java 8 에서는 인터페이스 안에 정적 메소드를 두는 것을 허용한다.
		public static Calculator defaultCalculator(){
			return new BasicCalculator();
		}
	}


	public class InterfaceSample {
		public static void main(String[] args){
			Calculator calculator = CalculatorFactory.defaultCalculator();
		}
	}
```


