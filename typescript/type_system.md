# TypeScript 유형 시스템
* TypeScript의 타입시스템은 옵셔널이므로 장신의 자바스크립트는 TypeScript입니다.
* TypeScript는 타입에러가 있는 상태에서 자바스크립트 코드를 없애는 것을 차단하지않으므로 점직적으로 JS를 TS로 업데이트 할 수 있습니다.

## Basic Annotations

타입은 ':{type}' 구문을 사용합니다.

``` javascript
var num: number = 123;
function identity(num: number): number {
	return num;
}

```

### Primitive Types
자바스크립트의 primitive 타입들은 타입스트립트에도 잘 나타납니다.

``` javascript

var num: number;
var str: string;
var bool: boolean;

num = 123;
num = 123.456;
num = '123'; // Error

str = 'str';
str = 123; // Error

bool = true;
bool = false;
bool = 'false'; //Error
```


### Arrays
기본적으로 syntax는 어떠한 타입이든 타입 뒤에 '[]' 을 붙이는 것입니다. 이것은 당신이 잘못된 타입을 배열에 할당하는 것을 방지합니다.

``` javascript
var boolArray: boolean[];

boolArray = [true, false];
console.log(boolArray[0]); // true
console.log(boolArray.length); // 2
boolArray[1] = true;
boolArray = [false, false];

boolArray[0] = 'false'; // Error!
boolArray = 'false'; // Error!
boolArray = [true, 'false']; // Error!
```

## Interface
인터페이스는 여러 annotation을 단일 annotation으로 작성하게 해주는 타입스크립트의 핵심적인 방법입니다.

``` javascript
interface Name {
	first: string;
	second: string;
}

var name: Name;

name = {
	first: 'John',
	second: 'Doe;
};

name = {           // Error : `second` is missing
	first: 'John'
};

name = {           // Error : `second` is the wrong type
	first: 'John',
	second: 1337
};
```

인터페이스를 통해 first: string, second: string 을 미리 정의해둠으로서 Name 개별 프로퍼티에 대한 형식을 검사할 수 있습니다.
인터페이스는 타입스크립트에서 많은 힘을 발휘합니다. 

### Inline Type Annotation

새로운 인터페이스를 생성하는 것 대신에, inline을 사용하여 { /* Structure */ } 으로 사용할 수 있습니다.
위의 예를 inline으로 변경해보겠습니다.

``` javascript
var name: {
    first: string;
    second: string;
};
name = {
    first: 'John',
    second: 'Doe'
};

name = {           // Error : `second` is missing
    first: 'John'
};
name = {           // Error : `second` is the wrong type
    first: 'John',
    second: 1337
};
```

인라인 유형은 신속하게 일회성 annotation에 적합합니다. 잠재적인 불량 유형 이름을 찾는 번거로움을 덜어줍니다. 그러나 같은 유형의 주석을 여러번 인라인하는 경우, 인터페이스 또는 뒤에 나올 type alias로 리팩토링하는 것이 좋습니다.

## Special Type
앞서 설명한 primitive 타입외에도 타입스크립트에서는 특별한 의미를 갖는 type들이 있습니다. 바로
any, null, undefined, void 입니다.


### any
any는 컴파일러에게 타입시스템으로부터 벗어나기위한 탈출법을 제공합니다. 타입스크립트의 모든 타입과 any는 호환되기 때문이죠.
any는 any를 가질 수도 있고 모든 타입들을 다 포함할 수 있습니다. 어떠한 타입에도 할당될 수 있고, 어떠한 타입도 자신에게 할당 할 수 있습니다.

``` javascript
var power: any;

// Takes any and all types
power = '123';
power = 123;

// Is compatible with all types
var num: number;
power = num;
num = power;

```

만약 자바스크립트 코드를 타입스크립트 코드로 이전하고자 할때, 처음엔 any가 좋은 친구가 될 것입니다만. 하지만 any는 타입안정성을 보장하지 않으므로 주의하세요. 만약 당신이 그렇게 한다면, 컴파일러에게 어떠한 의미있는 static 분석은 하지말라고 말하는 거랍니다.

### null and undefined
자바스크립트 null 과 undefined 리터럴은 any유형과 동일하게 처리됩니다. 이 리터럴들은 다른 타입에 할당될 수 있습니다. 아래 코드를 보세요.

``` javascript
var num: number;
var str: string;

// These literals can be assigned to anything
num = null;
str = undefined;
```


### :void
:void 는 함수가 어떠한 값도 반환하지 않는다는 것을 의미합니다.

``` javascript
function log(message): void {
	console.log(message);
}
```

## Generics
많은 알고리즘과 데이터 구조는 실제 오브젝트 타입에 의존하지 않습니다. 그러나 여전히 다양한 변수간 제약조건은 필요하죠. 간단한 toy 예제는 아이템 리스트를 받아 이를 반대로 리턴하주는 예제입니다. 여기서 주의할 점은 함수에 전달되는 타입과, 함수에 의해 반환되는 것 사이의 제약사항입니다.

``` javascript
function reverse<T>(items: T[]): T[] {
	var toReturn = [];

	for(let i = items.length - 1; i >= 0; i--) {
		toReturn.push(items[i]);
	}

	return toReturn;
}

var sample = [1, 2, 3];
var reversed = reverse(sample);
console.log(reversed); // 3, 2, 1

// Safety!
reversed[0] = '1';     // Error!
reversed = ['1', '2']; // Error!

reversed[0] = 1;       // Okay
reversed = [1, 2];     // Okay
```

위 코드에서 함수 reverse는 any타입의 array items 를 사용하고, T 형식의 배열을 반환한다고 선언했습니다. 이 reverse 함수는 필요한 것과 동일한 유형의 항목을 반환하기 때문에, TypeScript는 reversed의 타입이 number[]라는 것을 알기에 타입 안전성을 보장해줄 수 있습니다.
만약 처음 전달한 타입이 string 이었다면 동일한 에러가 발생하겠죠.

``` javascript
var strArr = ['1', '2'];
var reversedStrs = reverse(strArr);

reversedStrs = [1, 2]; // Error!
```

실제로 JavaScript 배열은 이미 .reverse함수를 가지고 있으며 TypeScript는 사실 제네릭을 사용하여 구조를 정의합니다.

``` javascript
interface Array<T> {
	 reverse(): T[];
	  // ...
}
```

즉 아래와 같이 .reverse 를 호출할때, 타입안정성을 얻을 수 있습니다.

``` javascript
var numArr = [1, 2, 3];
var reversedNums = numArr.reverse();

reveredNums = ['1', '2'];
```

## Union Type
꽤 빈번하게 자바스크립트에서는 프로퍼티가 여러 타입의 프로퍼티를 갖도록 허락해야할 때가 있습니다.
이것은 Union 타입 ( | , 사용 예: string|number)이 유용 할 때 사용됩니다. 일반적인 사용 사례는 단일 객체 또는 객체의 배열을 취할 수있는 함수입니다. 예 :

``` javascript
function formatCommandline(command: string[]|string) {
    var line = '';
    if (typeof command === 'string') {
        line = command.trim();
    } else {
        line = command.join(' ').trim();
    }

	
    // Do stuff with line: string
}
```

## Intersection Type
extend는 JavaScript에서 두 개의 객체를 가져 와서 이 두 객체의 기능을 가진 새 객체를 만드는 매우 일반적인 패턴입니다.

``` javascript
function extend<T, U>(first: T, second: U): T & U {
    let result = <T & U> {};

    for (let id in first) {
       result[id] = first[id];
	}

	for (let id in second) {
		if (!result.hasOwnProperty(id)) {
			result[id] = second[id];
		}
	}
	return result;
}

var x = extend({ a: "hello" }, { b: 42 });

// x now has both `a` and `b`
var a = x.a;
var b = x.b;
```

## Tuple Type
자바스크립트는 퍼스트 클래스의 튜플을 지원하지 않습니다. 사람들은 일반적으로 배열을 튜플로 사용합니다. 튜플은 :[typeofmember1, typeofmember2] 이렇게 annotation 해줍니다. 튜플은 여러개의 멤버를 가질 수 있습니다.

``` javascript
var nameNumber: [string, number];

// Okay
nameNumber = ['Jenny', 8675309];

// Error!
nameNmber = ['Jenny', '867-5309'];
```

이것을 TypeScript에서의 구조화 지원과 결합하면 튜플은 배열에도 불구하고 first class 처럼 느껴집니다.

``` javascipt
var nameNumber: [string, number];
nameNumber = ['Jenny', 8675309];

var [name, num] = nameNuber;
```

## Type Alias
두번이상 등장하는 유형에 type annotation을 제공하는 편리한 syntax를 제공합니다. type alias는 type SomeName = someValidTypeAnnotation 이러한 syntax로 생성합니다.  

``` javascript
type StrOrNum = string|number;

// Usage: just like any other notation
var sample: StrOrNum;
sample = 123;
sample = '123';

// Just checking
sample = true; // Error!
```

인터페이스와 다르게 당신은 type alias를 어떠한 type annotation 에도 줄 수 있습니다(union 과 intersection type에 유용합니다).

``` javascript
type Text = string | {text: string}';
type Coordinates = [number, number];
type Callback = (data: string) => void;
```

> TIP: 만약 당신이 계층구조를 가진 type annotation을 갖는 것이 필요하다면 인터페이스를 사용하세요. 인터페이스는 extends 와 implements를 사용할 수 있습니다.

> TIP: 단순히 그들에게 의미를 부여하기 위한 이름을 위해 간단한 오브젝트 구조를 위한 type alias (Coordinates 와 같은)를 사용하세요. 또한 당신이 Union 이나 Intersection type에 이름을 부여하길 원할 때도, type alias는 좋습니다.


[출처](https://basarat.gitbooks.io/typescript/content/docs/types/type-system.html)
