# 디스트럭처링(Destructuring)

### 디스트럭처링(destructuring) 할당이란?
디스트럭처링을 이용하면 배열의 요소나 객체의 속성을 배열 리터럴(literal)이나 객체 리터럴과 비슷한 문법을 이용해서 변수에 할당할 수 있습니다.

디스트럭처링 할당이 없을 경우, 어떤 배열의 처음 3개 요소에 접근하는 코드는 다음과 같을 것입니다.

``` javascript
var first = someArray[0];
var second = someArray[1];
var third = someArray[2];
```
디스트럭처링 할당을 이용하면, 똑같은 코드가 좀 더 간결하고 읽기 쉬워집니다.

``` javascript
var [first, second, third] = someArray;
```

### 배열과 이터러블(iterable)을 디스트럭처링하기
우리는 이미 배열을 디스트럭처링하는 예제를 보았습니다. 이 문법의 일반형은 다음과 같습니다.

``` javascript
[ variable1, variable2, ..., variableN ] = array;
```

이 구문은 variable1부터 variableN을 각 순서에 해당하는 배열 요소들로 채웁니다. 변수의 할당과 선언을 동시에 하고 싶다면, 할당 구문 앞에 var, let, 또는 const를 추가합니다.

``` javascript
var [ variable1, variable2, ..., variableN ] = array;
let [ variable1, variable2, ..., variableN ] = array;
const [ variable1, variable2, ..., variableN ] = array;
```

사실 variable이라고 한정하는 것은 잘못입니다. 왜냐하면 원하는만큼 패턴을 중첩시켜 사용할 수 있기 때문입니다.

``` javascript
var [foo, [[bar], baz]] = [1, [[2], 3]];
console.log(foo);
// 1
console.log(bar);
// 2
console.log(baz);
// 3
```

아울러, 배열을 디스트럭처링할 때 일부 요소들을 건너뛸 수도 있습니다.

``` javascript
var [,,third] = ["foo", "bar", "baz"];
console.log(third);
// "baz"
```

그리고 “레스트(rest)” 패턴을 사용해서 배열 맨뒤의 요소들 모두를 다른 배열에 할당할 수도 있습니다.

``` javascript
var [head, ...tail] = [1, 2, 3, 4];
console.log(tail);
// [2, 3, 4]
```

범위를 벗어나거나 존재하지 않는 배열 요소에 접근하면, 해당 요소를 인덱스로 접근할 때와 같은 결과를 얻습니다. undefined를 얻습니다.

``` javascript
console.log([][0]);
// undefined

var [missing] = [];
console.log(missing);
// undefined
```

일러둘 것은 배열에 대한 디스트럭처링 할당 패턴이 모든 종류의 이터러블(iterable)에도 통한다는 점입니다.

``` javascript
function* fibs() {
	var a = 0;
	var b = 1;
	while (true) {
		yield a;
		[a, b] = [b, a + b];
	}
}

var [first, second, third, fourth, fifth, sixth] = fibs();
console.log(sixth);
// 5
```

### 객체를 디스트럭처링하기
객체를 디스트럭처링하면 변수에 객체의 속성값을 할당할 수 있습니다. 할당할 속성을 지정하고 그 속성값을 할당할 변수를 지정합니다.

``` javascript
var robotA = { name: "Bender" };
var robotB = { name: "Flexo" };

var { name: nameA } = robotA;
var { name: nameB } = robotB;

console.log(nameA);
// "Bender"
console.log(nameB);
// "Flexo"
```

속성의 이름과 변수의 이름이 같을 경우, 약식 문법을 사용할 수 있습니다.

``` javascript
var { foo, bar } = { foo: "lorem", bar: "ipsum" };
console.log(foo);
// "lorem"
console.log(bar);
// "ipsum"
```
그리고 배열의 경우와 똑같이 디스트럭처링 패턴을 중첩시켜 사용할 수 있습니다.

``` javascript
var complicatedObj = {
	arrayProp: [
		"Zapp",
	   { second: "Brannigan" }
   ]
};

var { arrayProp: [first, { second }] } = complicatedObj;

console.log(first);
// "Zapp"
console.log(second);
// "Brannigan"
```

존재하지 않는 속성을 디스트럭처링하면 undefined를 얻습니다.

``` javascript
var { missing } = {};
console.log(missing);
// undefined
```

한가지 주의할 것은 객체를 디스트럭처링해서 선언되지 않은 변수에 할당하는 경우입니다 (let, const, 또는 var를 함께 쓰지 않는 경우입니다).

``` javascript
{ blowUp } = { blowUp: 10 };
// Syntax error
```

이 구문이 에러를 일으키는 이유는 JavaScript 문법에 따라 엔진이 \{ 로 시작하는 모든 구문을 블록(block) 구문으로 해석하기 때문입니다. 
(예를 들어, { console } 은 유효한 블록 구문입니다).
구문 에러를 해결하는 방법은 문장 전체를 괄호로 감싸는 것입니다.

``` javascript
({ safe } = {});
// No errors
```

### 객체도, 배열도, 이터러블(iterable)도 아닌 값을 디스트럭처링 하기
null이나 undefined를 디스트럭처링하려고 하면 타입 에러(type error)가 발생합니다.

``` javascript
var [missing = true] = [];
console.log(missing);
// true

var { message: msg = "Something went wrong" } = {};
console.log(msg);
// "Something went wrong"

var { x = 3 } = {};
console.log(x);
// 3
```
### 디스트럭처링의 실용적 응용사례

* 함수의 인자 정의

개발자로서 API를 만들 때, API 사용자가 API의 파라메터 순서를 기억하도록 강요하는 것은 인간적이지 않습니다. 대신 여러개의 속성을 가진 객체를 파라메터로 전달 받는 것이 좀 더 나은 접근입니다. 디스트럭처링을 이용하면 API 함수 안에서 파라메터 속성을 참조할 때마다 파라메터 객체를 반복해서 사용하는 것을 피할 수 있습니다.

``` javascript
function removeBreakpoint({ url, line, column }) {
	  // ...
}
```

* 설정 객체의 파라메터
앞서 소개한 예제를 확장해서, 디스트럭처링하려는 객체의 속성에 디폴트 값을 줄 수도 있습니다. 이것은 설정값을 관리하는 객체가 있고, 각 설정값에 적절한 디폴트 값이 존재할 때 특히 도움이 됩니다. 예를 들어, jQuery의 ajax 함수는 함수의 2번째 인자로 설정 객체를 전달받습니다. 이 함수를 다음과 같이 다시 쓸 수 있습니다.

``` javascript
jQuery.ajax = function (url, {
		async = true,
		beforeSend = noop,
		cache = true,
		complete = noop,
		crossDomain = false,
		global = true,
		// ... more config
		}) {
	// ... do stuff
};
```

이렇게 하면 설정 객체의 각 속성마다 var foo = config.foo || theDefaultFoo; 처럼 코딩하는 것을 피할 수 있습니다.

* ES6 이터레이션 프로토콜과 함께
ECMAScript 6는 이터레이션 프로토콜을 제공합니다. 시리즈 초반에 소개한 바 있습니다. Map 객체 (ES6 제정과 함께 표준 라이브러리에 추가된 객체)를 순회할 때, 우리는 일련의 [key, value] 페어(pair)를 얻습니다. 이 페어를 디스트럭처링하면 키(key)와 밸류(value)에 쉽게 접근할 수 있습니다.

``` javascript
var map = new Map();
map.set(window, "the global");
map.set(document, "the document");

for (var [key, value] of map) {
	  console.log(key + " is " + value);
}
// "[object Window] is the global"
// "[object HTMLDocument] is the document"
```

순회하면서 키(keys) 값에만 접근하는 코드는 다음과 같습니다.

``` javascript
for (var [key] of map) {
	  // ...
}
```
그리고, 밸류(value) 값에만 접근하는 코드는 다음과 같습니다.

``` javascript
for (var [,value] of map) {
	  // ...
}
```
* 여러개의 값을 리턴하기
비록 여러개의 값을 리턴하는 기능이 랭귀지에 추가되지는 않았지만, 배열을 리턴하고 그 결과를 디스트럭처링할 수 있기 때문에 여러개의 값을 리턴하는 기능을 대신할 수 있습니다.

``` javascript
function returnMultipleValues() {
	  return [1, 2];
}
var [foo, bar] = returnMultipleValues();
```

또, 객체를 컨테이너로 이용해서 리턴값의 이름을 지정할 수도 있습니다.

``` javascript
function returnMultipleValues() {
	return {
	foo: 1,
		 bar: 2
	};
}
var { foo, bar } = returnMultipleValues();
```
이 2가지 패턴 모두 임시 컨테이너를 사용하는 코드보다 훨씬 낫습니다.

``` javascript
function returnMultipleValues() {
	return {
foo: 1,
		 bar: 2
	};
}
var temp = returnMultipleValues();
var foo = temp.foo;
var bar = temp.bar;
```

또는 continuation passing style을 사용할 수도 있습니다.

``` javascript
function returnMultipleValues(k) {
	k(1, 2);
}
returnMultipleValues((foo, bar) => ...);
```

출처: http://hacks.mozilla.or.kr/2015/09/es6-in-depth-destructuring/
