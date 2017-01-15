# 튜플(Tuple)

튜플은 단순히 정의하자면 변경이 불가능한 배열(Immutable Array)이라고 할 수도 있다. 그래서 배열과는 다르게 괄호를 이용해 아이템을 정의한다.

``` swift
let tup = (1, "second item", 0.3)
```

참조는 점(.)을 찍고 인덱스를 주는 독특한 방식으로 할 수 있다

``` swift
let first = tup.0      // 1
let second = tup.1     // "second item"
```

좀 더 편하게 변수에다 튜플을 흩어 뿌리는 것도 할 수 있다. 

``` swift
let (first, second, third) = tup
```

이렇게 하면 first에는 1, second에는 "second item", third에는 0.3이 들어간다. 그런데 흝어 뿌리기 중 필요한 것만 변수로 받고 싶을 때도 있을 것이다. 

``` swift
let (_, second, _) = tup
```

언더라인(_)은 무시하겠다는 표현으로 생각하자. 이렇게 하면 second에는 두 번째인 "second item" 값이 배당된다. 물론 이 코드를 tup.1를 이용해 받을 수도 있겠지만 이렇게 할 수도 있다는 것을 알려주기 위한 용도다.

## 이름이 붙은 튜플 아이템
스위프트의 튜플이 좀 독특한 점이 있다면 개별 요소에 인덱스 대신 쓸 이름을 줄 수도 있다는 것이다. 

``` swift
let httpStatus = (code: 404, description: "Not Found")
```

이렇게 정의하면 인덱스가 아닌 이름으로 참조가 가능해진다. 

``` swift
println(httpStatus.code)   // 콘솔에 404가 찍힌다
```

## 튜플이 왜 좋을까?
### 1. 구조체의 대체가 가능하다
이름이 붙은 튜플 아이템은 구조체 등 다량의 데이터를 표시하기 위한 특수 데이터구조를 쉽게 만들 수 있다. 

``` swift
let whoAmI = (name: "Seorenn", age: 24, gender: "Etc")
println("I am \(whoAmI.name), \(whoAmI.age) years old, and gender is \(whoAmI.gender)")
```
이렇게 구조체 데이터를 간략하게 만들 수 있다는 것은 축복에 가깝다.

### 2. 멀티 리턴값을 만들 수 있다
함수는 일반적으로 하나의 값 만을 리턴한다. 하지만 2개 이상의 값을 리턴해야 할 필요가 있을 수도 있다. 보통은 함수에서 리턴할 구조체나 클래스를 만들어서 그 인스턴스를 함수에서 만들어서 리턴하는 경우가 다반사다.
이러한 상황에서 swift에서는 튜플을 활용하면 간단하게 처리가 가능하다.

``` swift
func plusAndMinus(a: Int, b: Int) -> (Int, Int) {
    return (a + b, a - b)
}

let (plusResult, minusResult) = plusAndMinus(1, 2)
```

위 코드의 plusAndMinus 함수는 두 인자를 받아서 두 인자를 더한 값과 뺀 값 두 가지를 한 번에 리턴하는 함수다. 단순화된 코드를 작성하려다 보니 그다지 유용한 예제는 아닌 것 같지만 어쨌든 이런 식으로도 쓸 수 있다는 것을 보여준다.

이 외에 튜플의 활용은 함수의 인자로 전달 할 때 등등 다양한 요소에 활용이 가능하다. 꼭 알아두자.



