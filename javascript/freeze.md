# Freeze()
Object.freeze() 메소드는 객체를 얼려버린다. 
얼려 버린다는 것은 객체에 새로운 속성(property)를 추가할 수 없고, 객체에 원래 존재하던 속성을 제거할 수 없으며,
객체의 속성, 열거가능성(enumerability), 설정가능성(configurability), 값 쓰기가능성(configurability)을 변경 할 수 없게 만든다는 것을 의미한다.

Object.freeze() 메소드는 __객체를 불변(immutable)__하게 만들어 준다.
Object.freeze() 메서드는 얼려진, 즉, 불변화 된 객체를 반환한다.

``` javascript
Object.freeze(obj);
```

#### 사용
얼려진 객체에는 어떤 속성도 추가되거나 제거될 수 없다. 
이런 시도는 암묵적이든, 아니면 strict mode에서와 같이 명시적으로 TypeError 예외를 던지든 모두 실패로 끝이 난다.

데이터 속성에 의한 값은 변경될 수 없으며, getters와 setters 같은 접근자 속성에 의해서도 값은 변경될 수 없다. 
-> 접근자 속성을 통해 값을 변경하면 오류가 발생하지 않으므로 값이 변경되었다고 생각할 수 있지만, 실제 값을 찍어보면 값은 변경되어 있지 않다!

하지만, 얼려진 객체의 속성값이 객체인 경우에는 (즉, 값이 참조형일 경우에는) , 그 객체를 명시적으로 얼리지 않으면 그 객체는 변경될 수 있다는 점을 꼭 기억해야 한다.


``` javascript
var obj = {
  prop: function() {},
  foo: 'bar'
};

// 새 속성을 추가할 수 있고, 기존 속성을 변경하거나 제거할 수 있음
obj.foo = 'baz';
obj.lumpy = 'woof';
delete obj.prop;

var o = Object.freeze(obj);

assert(Object.isFrozen(obj) === true);

// 얼린 후에는 모든 변경 시도가 실패로 끝남
obj.foo = 'quux'; // 에러가 나지는 않지만 값은 변경되지 않음
obj.quaxxor = 'the friendly duck'; // 에러가 나지는 않지만 속성이 추가되지 않음

// strict mode에서 위와 같이 변경을 시도하면 명시적으로 TypeError 발생
function fail(){
	  'use strict';
	    obj.foo = 'sparky'; // TypeError 발생
	    delete obj.quaxxor; // TypeError 발생
	    obj.sparky = 'arf'; // TypeError 발생
}

fail();

// 점(dot) 참조를 이용한 변경 뿐아니라 Object.defineProperty를 통한 변경 시도에서도 TypeError 예외 발생
Object.defineProperty(obj, 'ohai', { value: 17 }); // TypeError 발생
Object.defineProperty(obj, 'foo', { value: 'eit' }); // TypeError 발생
```

 얼려진 객체의 속성값이 객체인 경우에는 (즉, 값이 참조형일 경우), 그 객체를 명시적으로 얼리지 않으면 그 객체는 변경될 수 있다는 것을 꼭 기억해야 한다.
 
 ``` javascript
 obj = {
 	   internal: {}
 };

 Object.freeze(obj);
 obj.internal.a = 'aValue';

 obj.internal.a // 'aValue' 가 출력됨

 // obj 객체를 그 내부까지 완전히 얼리려면, obj 내의 모든 객체를 각각 얼려야 함
 // 완전히 얼리려면 다음과 같은 함수를 이용할 수 있음

 function deepFreeze(o) {
 	   var prop, propKey;
 	   
 	   Object.freeze(o); // 외부의 감싸는 객체 o부터 얼림

 	   for (propKey in o) {
 	     prop = o[propKey];
 	    
 	    if (!o.hasOwnProperty(propKey) ||
 	    	!(typeof prop === 'object') ||
 	    	Object.isFrozen(prop)) {
 	    // 내부 객체인 prop이 o에 있지 않고 프로토타입 객체에 있거나,
 	    // prop의 타입이 object가 아니거나, prop이 이미 얼려있다면 얼리지 않고 통과
 	    // 이렇게 하면 이미 얼려진 prop 내부에 얼려지지 않은 객체 A가 있을 경우, 
 	    // A는 여전히 얼려지지 않는 상태로 남게됨
 	    
 	    continue;
			}
        deepFreeze(prop); // 재귀호출 
        }
 }

 obj2 = {
 	   internal: {}
 };

 deepFreeze(obj2);
 obj2.internal.a = 'anotherValue';
 obj2.internal.a; // 새 속성인 a를 추가할 수 없으므로 undefined
 ```

#### ES6에서의 freeze
ES5에서는 Object.freeze() 메서드의 인자가 객체가 아닐 때(즉, 원시형일 때)는 TypeError가 발생한다. ES6에서는 원시형 인자도 얼려진 객체라고 취급해서 TypeError를 발생시키지 않고 원시형 인자를 그대로 반환한다.

``` javascript
> Object.freeze(1)
TypeError: 1 is not an object // ES5 code

> Object.freeze(1)
1                             // ES6 code
```
