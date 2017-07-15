# 상속과 프로토타입
Java 나 C++ 같이 클래스 기반의 언어를 사용하던 프로그래머는 자바스크립트가 동적인 언어라는 점과 클래스가 없다는 것에서 혼란스러워 한다. (ES2015부터 class 키워드를 지원하기 시작했으나, 문법적인 양념일 뿐이며 자바스크립트는 여전히 프로토타입 기반의 언어다.)

	상속이라는 점에서 자바스크립트는 오브젝트라는 오직 하나의 생성체만을 가지고 있다. 각각의 오브젝트는 [[Prototype]]이라는 속성을 가지는데 프로토타입을 가리키는 내부 링크를 가지고 있다. 한 오브젝트의 프로토타입 또한 프로토타입을 가지고 있고 이것이 반복되다, 결국 null을 프로토타입으로 가지는 오브젝트에서 끝난다. null은 더 이상의 프로토타입이 없다고 정의되며, 프로토타입 체인의 종점 역할을 한다.

	종종 이러한 점이 자바스크립트의 약점이라고 여겨지지만, 프로토타입적 상속 모델은 사실 고전적인 방법보다 좀 더 강력한 방법이다. 그 말은, 예를 들자면, 프로토타입적 모델에서 고전적인 방식을 구현하는 건 꽤나 사소한 일이지만, 그 반대는 훨씬 더 어려운 일이라는 것이다.

# 프로토타입 체인을 이용한 상속
## 속성 상속하기
자바스크립트 오브젝트는 속성을 저장하는 동적인 "가방"과 (자기만의 속성이라고 부른다) 프로토타입 오브젝트(또는  null)에 대한 링크를 가진다. 객체의 어떤 속성에 접근하려할 때 그 객체 자체 속성 뿐만 아니라 객체의 프로토타입, 그 프로토타입의 프로토타입 등 프로토타입 체인의 종단에 이를 때까지 그 속성을 찾으려 한다.

> ECMAScript 표준은 someObject.[[Prototype]]을 객체 someObject의 프로토타입을 지시하도록 명시하였다. ECMAScript 2015부터 [[Prototype]]에 조상 Object.getPrototypeOf()과 Object.setPrototypeOf()을 이용하여 접근하기 때문이다. 이것은 자바스크립트의 표준은 아니나 많은 브라우저에 구현되어 사실상의 표준이 된 속성 __proto__과 동일하다.

``` javascript
// o라는 오브젝트가 있고, 속성 'a' 와 'b'를 갖고 있다고 하자.
// {a: 1, b: 2}
// o.[[Prototype]]은 속성 'b'와 'c'를 가지고 있다. 
// {b: 3, c: 4}
// 마지막으로 o.[[Prototype]].[[Prototype]]은 null이다. 
// null은 프로토타입의 종단을 말하며 정의에 의해서 추가 [[Prototype]]은 없다. 
// {a: 1, b: 2} ---> {b: 3, c: 4} ---> null

console.log(o.a); // 1
// o는 'a'라는 속성을 가지는가? 그렇다. 속성의 값은 1이다.

console.log(o.b); // 2
// o는 'b'라는 속성을 가지는가? 그렇다. 속성의 값은 2이다.
// 프로토타입 역시 'b'라는 속성을 가지지만 이 값은 쓰이지 않는다. 이것을 "속성의 가려짐(property shadowing)" 이라고 부른다.

console.log(o.c); // 4
// o는 'c'라는 속성을 가지는가? 아니다. 프로토타입을 확인해보자.
// o.[[Prototype]]은 'c'라는 속성을 가지는가? 가지고 값은 4이다.

console.log(o.d); // undefined
// o는 'd'라는 속성을 가지는가? 아니다. 프로토타입을 확인해보자.
// o.[[Prototype]]은 'd'라는 속성을 가지는가? 아니다. 다시 프로토타입을 확인해보자.
// o.[[Prototype]].[[Prototype]]은 null이다. 찾는 것을 그만두자.
// 속성이 발견되지 않았기 때문에 undefined를 반환한다.

```

오브젝트의 속성에 값을 지정하면 "자기만의 속성"이 생긴다.  단, getter or a setter로 상속된 속성에 대해서는 get과 set시 예외적인 동작을 보인다.

## 메소드 상속하기
자바스크립트에 "메소드"라는건 없다. 하지만 자바스크립트는 오브젝트의 속성으로 함수를 지정할 수 있고 속성 값을 사용하듯 쓸 수 있다. 속성 값으로 지정한 함수의 상속 역시 위에서 본 속성 값의 상속과 동일하다. (단 위에서 언급한 "속성의 가려짐" 대신 "메소드 오버라이딩, method overriding" 라는 용어를 사용한다)

상속된 함수가 실행 될 때,  this 라는 변수는 상속된 오브젝트를 가르킨다. 그 함수가 프로토타입의 속성으로 지정되었다고 해도 말이다.

``` javascript
var o = {
  a: 2,
  m: function(b){
    return this.a + 1;
  }
};

console.log(o.m()); // 3
// o.m을 호출하면 'this' 는 o를 가리킨다.

var p = Object.create(o);
// p 는 프로토타입을 o로 가지는 오브젝트이다.

p.a = 12; // p 에 'a'라는 새로운 속성을 만들었다.
console.log(p.m()); // 13
// p.m이 호출 될 때 'this' 는 'p'를 가리킨다.
// 따라서 o의 함수 m을 상속 받으며,
// 'this.a'는 p.a를 나타내며 p의 개인 속성 'a'가 된다.
```

# 오브젝트를 생성하는 다른 방법과 프로토타입 체인 결과
## 문법 생성자로 오브젝트를 만들어서

``` javascript
var o = {a: 1};

// o 오브젝트는 프로토타입으로 Object.prototype 을 가진다.
// 이로 인해 o.hasOwnProperty('a') 같은 코드를 사용할 수 있다.
// hasOwnProperty 라는 속성은 Object.prototype 의 속성이다.
// Object.prototype 의 프로토타입은 null 이다.
// o ---> Object.prototype ---> null

var a = ["yo", "whadup", "?"];

// Array.prototype을 상속받은 배열도 마찬가지다.
// (이번에는 indexOf, forEach 등의 메소드를 가진다)
// 프로토타입 체인은 다음과 같다.
// a ---> Array.prototype ---> Object.prototype ---> null

function f(){
  return 2;
}

// 함수는 Function.prototype 을 상속받는다.
// (이 프로토타입은 call, bind 같은 메소드를 가진다)
// f ---> Function.prototype ---> Object.prototype ---> null
```
## 생성자를 사용해서
자바스크립트에서 생성자는 단지 new 연산자를  사용해 함수를 호출하면 된다.

``` javascript
function Graph() {
  this.vertexes = [];
  this.edges = [];
}

Graph.prototype = {
  addVertex: function(v){
    this.vertexes.push(v);
  }
};

var g = new Graph();
// g 'vertexes' 와 'edges'를 속성으로 가지는 오브젝트다.
// 생성시 g.[[Prototype]]은 Graph.prototype의 값과 같은 값을 가진다.
```

## Object.create를 사용해서
ECMAScript 5는 새로운 방법을 도입했다. Object.create라는 메소드를 호출하여 새로운 오브젝트를 만들 수 있다. 생성된 오브젝트의 프로토타입은 이 메소드의 첫 번째 인수로 지정된다.

``` javascript
var a = {a: 1}; 
// a ---> Object.prototype ---> null

var b = Object.create(a);
// b ---> a ---> Object.prototype ---> null
console.log(b.a); // 1 (상속됨)

var c = Object.create(b);
// c ---> b ---> a ---> Object.prototype ---> null

var d = Object.create(null);
// d ---> null
console.log(d.hasOwnProperty); // undefined이다. 왜냐하면 d는 Object.prototype을 상속받지 않기 때문이다.
```

## class 키워드 이용
ECMAScript2015에는 몇 가지 키워드가 도입되어 class를 구현하였다. 이런 생성 방식은 클래서 기반 언어의 개발자들에게 친숙하게 다가오나 동작 방식이 같지는 않다. 자바스크립트는 여전히 프로토타입 기반으로 남아있다. 새로 도입된 키워드는 class, constructor, static, extends, 그리고 super가 있다.

``` javascript
'use strict';

class Polygon {
  constructor(height, width) {
    this.height = height;
    this.width = width;
  }
}

class Square extends Polygon {
  constructor(sideLength) {
    super(sideLength, sideLength);
  }
  get area() {
    return this.height * this.width;
  }
  set sideLength(newLength) {
    this.height = newLength;
    this.width = newLength;
  }
}

var square = new Square(2);
```

## 성능
프로토타입 체인에 걸친 속성 검색으로 노력이 상당히 들어 성능에 나쁜 영향을 줄 수 있으며, 성능이 중요한 상황에서 치명적일 수 있다. 또한 존재하지도 않는 속성에 접근하려는 시도는 항상 모든 프로토타입 체인인 전체를 탐색해서 확인하게 만든다.

오브젝트의 속성에 걸쳐 루프를 수행 하는 경우 프로토타입 체인 전체의 열거자 속성에 대하여 적용된다.

오브젝트의 개인 속성인지 프로토타입 체인상 어딘가에 있는지 확인하기 위해서는 Object.prototype에서 모든 오브젝트로 상속된 hasOwnProperty 메소드를 이용할 필요가 있다.

hasOwnProperty 메소드를 통해야만 프로토타입 체인 전체를 탐색하는 것을 막을 수 있다.

참고: undefined 속성인지만을 확인하는 것은 충분하지 않다. 속성은 존재하지만 값이 undefined으로 설정되어 있을 수도 있다.

## 좋지 않은 사례: 기본 프로타입의 확장 변형
Object.prototype 혹은 빌트인 프로토타입의 확장은 종종 이용되지만 오용이다.

이 기법은 Monkey patching으로 불리며 캡슐화를 망가뜨린다. Prototype.js와 같은 유명한 프레임워크에서도 사용되지만, 빌트인 타입에 비표준 기능을 추가하는 것은 좋은 생각이 아니다.

유일하게 좋은 사용 예라면, 사로운 자바스크립트 엔진에 Array.forEach등의 새로운 기능을 추가하면서 빌트인 프로토타입을 확장하는 것 정도다. 

# 예
B는 A를 상속한다:

``` javascript


[출처](https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/Inheritance_and_the_prototype_chain)
