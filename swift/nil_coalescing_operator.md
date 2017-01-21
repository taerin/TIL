# Nil 병합 연산자

소위 “Nil 병합 연산자”라고 불리는 연산자는 옵셔널과 함께 사용할 수 있는 흥미로운 연산자라고 할 수 있습니다.

## 예제
anOptionalInt라고 하는 옵셔널 값이 있고 이 변수에 옵셔널이 아닌 값을 대입하려고 한다고 가정해 보겠습니다. 만약 옵셔널 값이 nil이면 어떤 값을 할당하는 과정은 아래와 같은 코드로 나타낼 수 있습니다.

``` swift
var anOptionalInt: Int? = 10
 
var anInt: Int = 0
 
if anOptionalInt != nil {
    anInt = anOptionalInt!
}
```

이 코드에서 하고자 하는 일에 비해서 상대적으로 코드가 길다고 할 수 있습니다만, 무엇을 하려고 하는지는 명확하게 나타납니다. 물론 이보다 간결하게 작성할 수 있습니다.

## 삼원 조건 연산자
C언어처럼 스위프트에도 삼원 조건 연산자가 있습니다. 이 연산자를 사용하는 것이 옳은가에 대한 많은 논란이 있기는 합니다. 보통 읽기가 어려워진다는 관점에서 이 연산자를 사용하는데 반대하는 의견이 많습니다.

``` swift
var anOptionalInt: Int? = 10
 
var anotherOptional = (anOptionalInt != nil ? anOptionalInt! : 0)
```
첫 번째 예보다 코드의 길이가 훨씬 짧아졌지만 어떤 의미인지 파악하려면 코드를 한 번 더 읽어봐야하는 것이 단점입니다.

## Nil 병합 연산자
스위프트에는 이런 상황에 사용할 목적의 전용 연산자로 Nil 병합 연산자(nil coalescing operator)가 있습니다.

``` swift
var anOptionalInt: Int? = 10
 
var anotherOptional = anOptionalInt ?? 0
```

삼원 연산자에 대비하면 상대적으로 읽기도 쉽고 코드의 길이도 짧아집니다. 처음에 접했을 때 이 연산자를 사용하는 것이 좋을지 확신하지 못하였지만, 스위프트의 특징인 옵셔널 값을 다루기 위한 전용 연산자이므로 한 번 익숙해지도록 사용해봐야 하겠습니다.

출처: https://outofbedlam.github.io/swift/2016/04/14/NilCoalescingOperator/
