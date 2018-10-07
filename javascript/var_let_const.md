# var, let 그리고 const
var를 쓰지말고 let을 쓰자.

## 1. 이미 선언 하셨는데요? 
var는 상당히 너그럽다.
``` javascript
var a = 'aaa';
var a = 'bbb';
```
같은 이름의 변수를 두번 선언하고 있다. 변수 a에는 'aaa'라는 문자열이 할당되었다가 'bbb'라는 문자열이 할당된다.

하지만 let과 const는 엄격하다.

``` javascript
let a = 'aaa';
let a = 'bbb';
```
앞서 선언한 변수를 다시 선언하게 되면 칼 같은 오류룰 발생시킨다.
규모가 큰 코드에서 버그를 방지할 수 있는 매우 바람직한 특징이다.

## 2. 난 그때 거기 없었어요
``` javascript
console.log(a);
// Error: Uncaught ReferenceError: a is not defined
```
어디에도 존재하지 않는 변수 a를 호출하면 당연히 에러가 발생한다.
하지만 

``` javascript
console.log(a); // undefined
var a;
```
var를 이용해 아래 변수를 선언하면 더이상 에러가 발생하지 않는다. 에러가 아니라는 이 점이 아주 주의해야 할 점이다.
변수 a는 값이 정의되지 않은 타입인 undefined가 되어있을 뿐이다. 
선언보다 호출이 먼저 되어있었음에도 불구하고 이 코드는 정상적으로 작동한다. 호이스팅(Hoisting)이 발생했기 때문이다.

그럼  let 과 const는 어떨까?
``` javascript
console.log(a); // Error: Uncaught ReferenceError: a is not defined 
let a;
```
호출한 시점에서 변수가 선언되어 있지 않음을 알리는 에러가 발생한다.
일시적 사각지대(Temporal Dead Zone ; TDZ)라는 개념이다.

## 3. 이 블록의 변수는 나야!
var의 경우에는 Function-scope라고한다. 유효범위가 함수 단위라는 뜻이다.
``` javascript
var a = 'bar1';
cosole.log(a); // bar1
 
 if (true) {
 	 var a = 'bar2';
 	 console.log(a); // bar2
 }
  
console.log(a); // bar2
```

위 코드가 하나의 함수 구문안에 존재한다고 가정했을때, if문 밖에 변수 a와  if문 안의 변수 a는 동일한 변수가 된다.
중복 선언을 했지만 앞서 말한바와 같이 별다른 에러를 발생시키지 않고, 값마저 ‘bar2’로 변경해버린다.

하지만 let과 const는 __Block-scope__ 이다. 유효 범위가 블록, 즉 {}로 감싸지는 범위라는 뜻이다.
``` javascript
let a = 'bar1';
console.log(a); // bar1
 
 if (true) {
 	 let a = 'bar2';
 	 console.log(a) // bar2
 }
  
console.log(a); // bar1
```
위 코드에서는 var를 사용한 경우와는 달리 if문 밖의 a와 if문 안의 a는 서로 다른 변수다. 
따라서 중복 선언으로 인한 에러도 발생하지 않으며, if문 안쪽에서 선언한 a의 경우는 if문이 닫히는 시점에서 유효범위가 끝난다.

``` javascipt
let a = 'bar1';
console.log(a); // bar1
 
 if (true) {
 	 console.log(a) // bar1
 	 a = 'bar2';
 	 console.log(a) // bar2
 }
  
console.log(a); // bar2
```
정상적으로 호출도되고 값의 변경에도 아무 문제가 없다. 
a 호출 이후에 let으로 a를 선언한다면

``` javascript
let a = 'bar1';
console.log(a); // bar1
 
 if (true) {
 	   console.log(a);
 	   // Uncaught ReferenceError: a is not defined
 	      
 	   let a = 'bar2';
 }
  
console.log(a);
```
a는 정의되지 않았다는 에러가 발생한다. 앞에서 말한 임시적 사각지대(TDZ) 이다. 어떤 변수가 호출되었을 때 블록 안에 같은 이름의 변수가 없으면 상위 블록에서 선언된 같은 이름의 변수를 호출한다.
하지만 블록 안에서 let이나 const로 변수 선언이 있었다면 그 이름의 변수는 변수가 선언되기 이전까지 그 블록안에서는 정의되지 않은 변수로 간주된다.

## 4. let과 const는 적절한 관계
실제로 원시형(Primitives type: string, number, boolean, null, undefined)에서 const는 상수로 동작한다. 따라서 const로 선언되면 값을 재할당 할 경우 에러가 발생한다 (당연하지만 초기값을 설정하지 않아도 에러가 발생한다.)

``` javascript
const a = 0;
a = 1;
// Error: Uncaught TypeError: Assignment to constant variable.
```

따라서 단순형의 경우 값의 변경이 있는 경우에는 let으로, 상수로 사용하는 경우에는 const로 선언하는 것이 바람직하다.

하지만, 참조형(Complex type: array, object, function)의 경우 const로 선언하는 것이 바람직 하다. 참조형은 const로 선언하더라도 멤버값을 조작하는 것이 가능하다.

``` javascript
const a = [0, 1];
const bar = a;
 
a.push(2);
bar[0] = 10;
  
console.log(a, bar); // [10, 1, 2] [10, 1, 2]
```

위의 코드에서 보이듯 const bar = a; 의 선언으로 bar는 a를 참조한다. 참조가 아니라 값을 복사(copy)하는 경우에는 array는 … 연산자를 사용하고, object는 assign()함수를 사용한다.

``` javascript
const arg = [0, 1];
const obj = {a: 'bar'};
 
const newArg = [...arg];
const newObj = Ojbect.assign({}, obj);
  
newArg[0] = 10;
newObj.a = 'rab';
   
console.log(arg, obj);
// [0, 1], {a: 'bar'}
    
console.log(newArg, newObj);
// [10, 1], {a: 'rab'}
```
## 5. 결론
– ES6 에서는 var는 지양하고 가급적 let과 const를 사용하자
– 원시형에서 변수는 let, 상수는 const로 선언한다
– 참조형은 const로 선언한다

출처: http://blog.nekoromancer.kr/2016/01/26/es6-var-let-그리고-const/
