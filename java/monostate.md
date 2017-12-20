# Monostate pattern
Monostate Pattern은 개념적인 싱글톤이다. Monostate내 모든 데이터 멤버는 static 이므로 Monostate의 모든 인스턴스는 동일한 static데이터를 사용한다.  
Monostate를 사용하는 어플리케이션은 각 인스턴스가 동일한 데이터를 사용하므로 원하는 만큼의 인스턴스를 만들 수 있다.
Monostate는 클래스에 관해서는 매우 좋은 설계이다. 클래스의 특정 인스턴스에 접근하는 것에 대한 복잡함을 줄일 수 있었기 때문이다. 
같은 알고리즘의 동작을 하나로 묶을 수 있다는 점도 이점이다.

대부분 클래스 이름끝에 s가 붙으니 참고하자

예) Java의 Collections / Arrays 

## Monostate가 주는 이점
* 투명성
사용자가 이 객체가 Monostate 라는 것을 알필요가 없다. 타 인스턴스와 똑같이 동작하기 때문
* 파생가능성
Monostate의 파생 클래스는 모두 Monostate다. 이들은 모두 같은 static 변수를 공유한다.
* 다형성
Monostate의 메소드는 static이 아니기때문에 override 가능
* 잘정의된 생성과 소멸
싱글톤과 달리 Monostate의 static변수는 잘 정의된 생성과 소멸시기를 가지게 된다.

[참고1](http://dsmoon.tistory.com/entry/SINGLETON-%EB%B0%8F-MONOSTATE-%ED%8C%A8%ED%84%B4)
[참고2](http://wiki.c2.com/?SingletonsAreEvil)
