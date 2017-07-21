# 믹스인 패턴
자바스크립트의 객체 패턴에서 클래스 상속과 프로토타입상속 말고 믹스인이라는 기법을 통해서 의사상속을 하는 방법이 있다. 이 믹스인이란 프로토타입을 바꾸지 않고 한 객체의 프로퍼티를 다른 객체에게 ‘복사’해서 사용하는 방식이다. 일반적으로 믹스인은 아래 함수를 사용해 구현한다.

``` javascript
function mixin(receiver, supplier) {
	for (var property in supplier) {
		if(supplier.hasOwnProperty(property)){
			receiver[property] = supplier[property]
		}
	}
	return receiver;
}
```

첫 번째 객체 receiver는 두 번째 객체인 supplier로 부터 프로토 타입을 복사 받는다. supplier의 프로퍼티들을 순회하면서 프로토 타입이 같을 경우에만 첫 번째 객체 receiver에 복사해서 주는 방식이다. 이 방식은 얕은 복사라서 프로퍼티 값이 객체이면 receiver와 supplier가 같은 객체를 가르키게 된다.

그럼 이 믹스인 패턴은 어디에 쓰일 수 있을까? 이 패턴은 기존에 있던 객체의 기능을 그대로 가져가면서 다른 객체에 추가할 때 주로 사용된다. 예를 들어 이벤트를 지원할 때는 상속보다는 믹스인이 더 어울린다.

아래 간단한 예시들을 보면서 어떤 경우에 믹스인이 어울리는지 살펴보자.

``` javascript
function EventTarget(){}

EventTarget.prototpye = {
	addListener : function(){
		....
	},
	fire : function(){
		....
	}
	...
}
```
위와 같이 이벤트를 정의한 객체가 있다. 이 이벤트 객체의 프로퍼티를 기존의 객체에 추가하면서 기존 객체에 새로운 프로퍼티 또한 추가 하고 싶으면 어떻게 해야 할까? 먼저 인스턴스를 만들고 프로퍼티를 추가 해 줄 수 있다. 나 또한, 가장 먼저 떠오른 방법이기도 하다.

``` javascript
var person = new EventTarget();
Person.sayHello = function(){
	...	
};
```

이 패턴에서 아쉬운 점은 person이 EventTarget의 인스턴스가 되어버린다는 점이다. 또한 새 프로퍼티를 일일이 추가해야 하는 점도 있다. 두번째는 psudoclaasical inheritance(책에서는 의사클래스상속으로 번역)이다.

``` javascript
var Person = function(){}
Person.prototype = Object.create(EventTarget.prototpye);
Person.prototpye.constructor = Person;

Person.prototpye.sayHello = function(){ ... };

var person = new Person();
```

n 타입을 만들고 프로토타입에 이벤트 타겟의 프로토타입을 상속받는다. 이 방식은 원하는 프로퍼티를 추가 할 수도 있고 person변수가 Person의 인스턴스이다. 하지만 Person은 EventTarget을 상속받았으므로 person변수는 EventTarget의 인스턴스이기도 하다. 과연 Person이 EventTarget과 상속관계가 되는것이 맞을까? 사람이 이벤트 타겟의 일종은 아닐것이다. 그래서 이 믹스인패턴을 이용하면 프로퍼티만 원하는 객체에 할당 할 수 있다.

``` javascript
var Person = function(){}

mixin(Person.prototype, new EventTarget());
mixin(Person.prototype, {
	constructor: Person, //위에도 있지만 constructor 또한 prototype 메소드이기 때문에 다시 할당해줘야한다.
	sayHello: function(){ ... }
});

var person = new Person();
```

이렇게 하면 Person은 EventTarget의 프로토타입만 상속받고 인스턴스를 상속받지 않으므로 person객체는 Person의 인스턴스이지만 EventTarget의 인스턴스는 아닌것이 된다.

프로퍼티만 상속받고 클래스 상속은 받고 싶지 않을때 바로 이 믹스인 패턴을 이용하면 된다.

출처 - [자바스크립트의 믹스인패턴](https://vnthf.github.io/blog/mixin/)


