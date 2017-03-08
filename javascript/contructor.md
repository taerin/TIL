# 자바스크립트 객체 생성

javascript에서의 생성자 함수는 대문자로 시작하는 함수이고 이 함수를 new 라는 키워드를 함께 쓰면 그것이 바로 객체를 생성하는 방법입니다.
만약 대문자로 시작된 이름을 가진 함수가 new 키워드와 함께 호출되지 않았을 경우에는 올바른 객체생성을 한 경우가 아니게 됩니다.
new 를 통해 생성된 함수의 컨텍스트는 객체를 생성해서, this로 넘겨주고 그 this를 반환합니다.

``` javascript
function User(name, age) {
	// new를 통해서 호출되지 않았을 경우 원하는 동작이 아니므로 이를 처리하기 위한 조건문 
	if (!(this instanceof User)) {
		return new User(name, age);
	}

	this.name = name;
	this.age = age;
}

const user = new User('Tom', 42);
const user2 = User('Tom', 42);
console.log(user2);
```

User라는 객체에 foo라는 메소드를 등록하고 싶다면, User 객체를 선언하는 function에 두지않고, User의 prototype에 등록해야 하나의 객체에 정의되고, 만약 이렇게 하지않고 User 선언부에 함께 작성해 두게 되면 객체 각각이 foo함수를 갖는 비효율적인 구조가 됩니다.
``` javascript
User.prototype.foo = function () {
	return 'foo';
};
```

class를 통해 객체를 선언하고, 함수를 정의하면 foo()라는 함수는 위와 같은 루트(prototype)로 정의됩니다. 즉 prototype에 하나만 정의되는 것이죠.
``` javascript
class User {
	constructor(name, age) {
		this.name = name;
		this.age = age;
	}

	foo() {
		return 'foo';
	}
}
```
