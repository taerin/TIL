# Guard 
빠른종료의 핵심 키워드는 guard 입니다. guard 구문은 if 구문과 유사하게 Bool 타입의 값으로 동작하는 기능입니다. guard 뒤에 따라붙는 코드의 실행 결과가 ture 일 때 코드가 계속 실행됩니다.
if 구문과 다르게 guard 구문은 항상 else 구문이 뒤에 따라와야 합니다. 만약 guard 뒤에 따라오는 Bool값이 false라면 else의 블록 내부 코드를 실행하게 되는데, 이때 else 구문의 블록 내부에는 꼭 자신보다 상위의 코드 블록을 종료하는 코드가 들어가게 됩니다. 그래서 특정 조건에 부합하지 않다는 판단이 되면 재빠르게 코드블록을 종료하는 코드가 들어가게 됩니다. 그래서 특정 조건에 부합하지 않다는 판단이 되면 재빠르게 코드 블록의 실행을 종료할 수 없습니다. 
이렇게 현재의 코드 블록을 종료할 시에는 return, break, continue, throw 등의 제어문 전환 명령을 사용합니다. 또는 fatalError()와 같은 비반환 함수나 메서드를 호출할 수도 있습니다.

``` swift
guard Bool 타입값 else {
	예외사항 실행문
	제어문 전환 명령어
}
```

guard 구문을 사용하면 if 코드를 훨씬 간결하고 읽기 좋게 구성할 수 있습니다. if 구문을 쓰면 예외사항을 else 블록으로 처리해야 하지만 예외사항만을 처리하고 싶다면 guard 구문을 쓰는 것이 훨씬 간편합니다. 
다음은 같은 기능을 처리하기 위한 if 구문과 guard구문의 비교입니다.

``` swift
// if 구문을 사용한 코드
for i in 0...3 {
	if i == 2 {
		print(i)
	} else {
		continue
	}
}
```

``` swift
// guard 구문을 사용한 코드
for i in 0...3 {
	guard i == 2 else {
		continue 
	}
	print(i)
}
```

Bool 타입의 값으로 guard 구문을 동작시킬 수 있지만 옵셔널 바인딩의 역할도 수행할 수 있습니다. guard 뒤에 따라오는 옵셔널 바인딩 표현에서 옵셔널의 값이 있는 상태라면, guard구문에서 옵셔널 바인딩된 상수를 guard  구문이 실행된 아래 코드부터 함수 내부의 지역상수처럼 사용할 수 있습니다.

아래 코드는 guard 구문의 옵셔널 바인딩 활용코드입니다.

``` swift
func greet( _ person: [String: String]) {
	guard let name: String = person["name"] else {
		return
	}

	print("Hello \(name)")
	
	guard let location: String = person["location"] else {
		print("I hope the whether is nice near you")
		return
	}

	print ("I hope the weather is nice in \(location)")
}
```

위 코드에서 guard를 통해 옵셔널 바인딩 된 상수는 greet(_:) 함수 내에서 지역상수 처럼 사용된 것을 볼 수 있습니다. 


조금 더 구체적인 조건을 추가하고 싶다면 쉼표(,)로 추가조건을 나열해주면 됩니다. 추가된 조건은 Bool 타입 값이어야 합니다. 또 쉼표로 추가된 조건은 AND 논리 연산과 같은 결과를 줍니다. 즉, 쉼표를 &&로 치환해도 같은 결과를 얻을 수 있다는 뜻입니다.

아래코드는 guard구문에 구체적인 조건을 추가한 예입니다.

``` swift
func enterClub(name: String?, age: Int?) {
	guard let name: String = name, let age: Int = age, age > 19, name.isEmpty == false else {
	print("You are too young to enter the club")
	}
	print("Welcome \(name)")
}

guard 구문의 한계는 자신을 감싸는 코드 블록, 즉, return, break, continue, throw 등의 제어문 전환 명령어를 쓸 수 없는 상황이라면 사용이 불가능하다는 점입니다.  함수나 메서드, 반복문 등 특정 블록내부에 위치하지 않는다면 사용이 제한됩니다.

``` swift
let first: Int = 3
let secont: Int = 5

guard first > second else {
	// 여기에 들어올 제어문 전환 명령은 딱히 없습니다. 오류!
}
```


