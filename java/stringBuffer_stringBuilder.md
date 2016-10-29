# StringBuffer와 StringBuilder
	String과 StringBuffer와 StringBuilder는 모두 문자열 처리 Class이다. 
	자바 설계자들은 문자열 처리 클래스를 저렇게 나누어 놨을까?
	차이점을 살펴보도록 하자!

### mutable과 immutable pattern
공유 자원들은 사용시 thread safety (multi-thread safety)해야 올바른 결과를 보장할 수 있다.
그래서 immutable은 한번 만든 객체는 변경되지 않으며, 변경시에는 새로운 객체를 만든다.
이 말은 synchronized하지 않아도 thread safety하다는 뜻이다. 
mutable은 원본 자체를 수정해야하기 때문에 synchronized해야만 올바른 결과가 보장된다.
	
	- String Class
	이 녀석은 immutable한 클래스이다. 변경 불가능한 클래스라는 뜻이다.
	하지만 안의 메소드(toLowerCase(), trim()... 등등)를 생각해보면 자칫 변경가능한 녀석이라고 생각할 수 있다.
	하지만 실제론 안에서 원본 객체는 놔둔채 각 메소드에서 새로운 객체를 생성하여 기능을 처리한 후 반환한다.
	즉, 원본은 변경되지 않는 것이다. 
	그래서 String 클래스는 객체를 새로 할당하는 시간 및 새로운 메모리사용 때문에 다른 문자열 클래스에 비해 좀 더 느리다고 생각될 수 있다.
	(+ 문자열을 + 을 통하여 합치를 경우에는 매번 String 인스턴스를 생성하는 방식이었다. 그래서 성능상의 이슈가 존재했다.
	하지만 jdk 1.5 버전이후부터 컴파일 단계에서 StringBuilder로 컴파일 되도록 변경되어
	jdk 1.5버전 이후부터는 +를 사용해도 성능상의 큰 이슈는 존재하지 않는다.)  



	- StringBuffer Class
	 이 녀석은 mutable하다.
	 그러니까 가지고 있는 원본을 수정할 수 있도록 만든 Class이다.
	 당연 thread safety하기 위한 synchronized과정이 있다.
	 이 synchronized과정에 있어서 단순한 참조를 할경우 String보다 bad performance를 보인다.




	- StringBuilder Class
	  이 녀석 또한 mutable하다. StringBuffer와 동일한 기능을 갖고있는데 
	  차이점이라고 한다면 thread safety하지 않다.
	  즉, synchronized 과정이 없다는 것 이다.

StringBuffer, StringBuilder는 동기화 지원 여부에서 다르다.두 클래스가 제공하는 메소드는 같다. 단 메소드를 보면 StringBuffer는 각 메소드 별로 synchronized keyword가 존재하는 것을 확인할 수 있다.
즉, 멀티 쓰레드 상태에서 동기화를 지원한다는 것이 다르다. 

코드를 보면 다음과 같다!


``` java
public final class StringBuffer
	public synchronized StringBuffer append(String str) {
		super.append(str);
		return this;
	}


	public synchronized StringBuffer append(boolean b) {
		super.append(b);
		return this;
	}  


	[...]
}



public final class StringBuilder {
	public StringBuilder append(String str) {
		super.append(str);
		return this;
	}


	public StringBuilder append(boolean b) {
		super.append(b);
		return this;
	}     


	[...]
}
```

그래서 thread safety할 필요 없는 코드라면 stringBuffer가 아닌 StringBuilder를 써야 더 좋은 성능이 나온다.

정리 하자면 하나의 문자열에 대해 다른 문자열이 자주 추가되는 경우에는 StringBuffer와 StringBuilder가 유리하지만, 이 외의 용도에서는 오히려 StringBuffer나 StringBuilder가 훨씬 메모리 자원 낭비될 수 있다.


출처 :http://duehd88.tistory.com/entry/String-StringBuffer-StringBuilder-클래스-차이 
https://slipp.net/questions/271
