# 연산자 오버로딩

property의 내용이 같은 객체가 같은지를 판단하고자 한다면 대부분의 사람들은 아래와 같은 코드를 작성할 것이다.

``` swift
struct Person {
	    var name: String
			    var age: Int
}

let person1 = Person(name: "Tom", age: 42)
let person2 = Person(name: "Tom", age: 42)

if person1 == person2 {
	    print("same")
} else {
	    print("diff")
}

```

하지만 이 코드는__Binary operator '==' cannot be applied to two 'Person' operands__ 라는 에러를 내며 컴파일조차 되지 않는다.
이는 swift 에서 사용하는 '==' 라는 연산자가 해당 객체에 정의되지 않았기 때문이다.

``` swift
struct Person: Equatable {
	var name: String
		var age: Int

		static func ==(lhs: Person, rhs: Person) -> Bool {
			return lhs.name == rhs.name && lhs.age == rhs.age
		}
}

let person1 = Person(name: "Tom", age: 42)
let person2 = Person(name: "Tom", age: 42)

if person1 == person2 {
	print("same")
} else {
	print("diff")
}
```

해당 struct에 Equatable 이라는 Protocol을 따르게 하고 아래 코드와 같이 구현을 해주면 연산자'=='가 해당 struct 객체에 '==' 연산자로 비교가 가능하다.

``` swift
public static func ==(lhs: Self, rhs: Self) -> Bool
```



