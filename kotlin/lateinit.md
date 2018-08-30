# lateinit

``` kotlin 
  class Person {
    val name : String? = null
    var age : Int? = null
  }
```

위 코드와 같이 코틀린에서 클래스의 멤버로 사용하는 프로퍼티는 초깃값을 명시적으로 지정해야하며, 그렇지 않을 경우 컴파일 에러가 발생한다.
단 생성자에서 프로퍼티의 값을 할당한다면 선언 시 값을 할당하지 않아도 된다.

프로퍼티 선언 시점이나 생성자 호출 시점에 값을 할당할 수 없는 경우, __lateinit__ 키워드를 사용하여 이 프로퍼티의 값이 나중에 할당될 것임을 명시할 수 있다.

lateinit 키워드는 var 프ㄹ로퍼티에만 사용 가능하며, 선언 시점에 값 할당을 요구하는 val 키워드에는 사용할 수 없다.  

``` kotlin
  clas Person {
    val name : String? = null // val 프로퍼티는 항상 선언과 함께 값을 할당해야 한다.
    lateinit age : Int? //  선언시점에 값을 할당하지 않아도, 컴파일 에러가 발생하지 않는다.
  }
```

__lateinit__ 키워드를 사용한 프로퍼티를 초기화 없이 사용하려 한다면, UninitializedPropertyAccessException 예외가 발생한다.
