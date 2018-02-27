# Abstract Class vs Interface
많은 사람들이 Abstract class와 인터페이스를 헷갈려하죠. 물론 저도 그래요! 
그래서 오늘들었던 강의를 바탕으로 정리를 하려고 합니다 :)

## Abstract class와 interface
**interface** 는 구현을 갖지 않고, 기능 상세를 약속해 둔 것입니다.
interface에서는 필드를 가질 수는 있지만, 이는 인스턴스 필드가아니라 public static final로 작성된 상수를 가지게됩니다.
하지만 이 상수는 사용하지 않는 것을 추천합니다.

**abstract 클래스** 는 하나 이상의 abstract 메소드를 가진 클래스를 말합니다.
하나 이상의 abstract 메소드라는 말에서 abstract가 아닌 메소드를 가져도, 즉 구현을 가진 함수를 가지고 있을때도 생성이 가능합니다.
abstract 함수는 마치 인터페이스처럼 굳이 기능의 구현을 해당 클래스에서 작성할 필요가 없을때 사용합니다. 
예를 들면 부모클래스에서 자식클래스가 각각 가져야할 기능을 작성할 필요가 없을때의 경우를 생각하세요.

## Abstract class는 구현을 가질 수 있다.
abstract 클래스는 필드를 물려줄 수 있습니다. 또한 구현을 가진 메소드를 물려줄 수 도 있습니다.
하지만 interface는 기능의 상세만을 나열한 것일뿐, 구현을 가질 수 없어요. 하지만 이말은 이제 틀렸습니다.
interface는 기능의 상세가 추가되거나 변경되면 이를 구현하고있는 클래스들의 구조가 모두 깨져버리는 단점이 있었죠. 그래서 업데이트 해야할 많은 클래스들을 변경하지 못하는 문제점이 있었습니다.
**Java 8** 부터 **dafault 메소드** 를 제공하여 interface 내부에 default 예약어와 함께 메소드를 작성하면 구현을 가질 수 있을 뿐만아니라 하부 구조의 파괴를 막을 수 있습니다.

``` java
interface MP3 {
    void play();
    void stop();
    default void replay() {
        // 구현
    }
}
```
