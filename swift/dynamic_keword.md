# dynamic 키워드

``` swift 
class User {
  @objc dynamic var name = "taerin"
  // - dynamic 키워드를 사용하지 않았을 때의 동작: user.name 이라는 메모리에 직접 접근(call name(&User))
  // - dynamic 키워드를 사용했을 때의 동작: user 객체에 name 이라는 프로퍼티를 접근하고 싶다는 메세지를 보내고 해당 값을 응답으로서 받는다.
}
``` 

우리가 종종 마주하는 에러중 Unreconized selector("name") 란 에러는 해당 객체에 메세지를 보냈으나 해당 프로퍼티를 읽을 수 없다는 에러다. (Unreconized selector에서 'selector'는 'message'로서 이해해도 좋다.)
객체의 함수를 호출하거나 프로퍼티를 참조하는 동작을 Obj-C 에서는 메세지를 보낸다고 표현한다. 

dynamic 키워드는 정적 디스패치의 빠른 이점을 포기하고 동적 디스패치를 사용하는 방법이다. 
그럼 동적 디스패치가 어떨때 유용하냐면, 함수의 성능을 측정하는 instumentation과 기능을 구현할 때 유용하다.

정적 바인딩 시스템에서 foo() 함수의 실행 성능을 측정한다고 해보자. 
바로 foo() 함수를 호출하는 것이 아니라 goo() 라는 함수를 대신 호출하는데, goo() 함수는 아래와 같이 생겼다.

``` swift

func foo() {
  //
}


func goo() {

  // 측정을 위한 setup

  foo()

  // 측정 후
}
``` 

동적 바인딩은 실제 코드를 찾아서 실행 전과 실행 후에 원하는 동작을 수행 할 수 있다는 점에서 차이가 난다. 

[참고](https://outofbedlam.github.io/swift/2016/01/27/Swift-dynamic/)
