# bind
함수와 객체를 말그대로 bind하여 생성하는 역할을 한다. 말그대로 생성이지 호출이 아니다.


호출하는 방법과 상관없이 함수 내부의 this를 특정 객체로 묶는 역할을 한다. bind할 특정 객체를 인자로 넘긴다.

# apply와 call
this를 지정한 객체로 직접 바인딩하므로 '명시적 바인딩'이라 한다.


두 함 수 모두 this에 바인딩 할 객체를 첫 번째 인자로 받아, 함수 호출 시 이 넘겨받은 객체를 this로 셋팅한다.


__apply__ : 두 번째 인수를 배열로 가져와서 인수로 호출된 함수에 전달


__call__: 첫 번째 인수 이후의 모든 인수를 호출된 함수로 전달


``` js
function foo () {
  console.log(arguments.length);
}

foo.call(this, [1, 2, 3]); // 1
foo.apply(this, [1, 2, 3]);// 3
```


## 동작 방법

``` js
function foo(a) {
  console.log(`Hello!, ${a} ${this.a}`);
}

foo();  // Hello!, undefined undefined
const obj = {
  a: "Taerin"
};

const fun = foo.bind(obj);
fun("Yoon"); // Hello!, Yoon Taerin

foo.apply(obj, ["Yoon"]); // Hello!, Yoon Taerin
foo.call(obj, "Yoon"); // Hello!, Yoon Taerin
```
