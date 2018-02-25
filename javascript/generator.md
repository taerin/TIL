# Generator (제너레이터)
제너레이터는 이터레이터를 반환하는 함수이다. 제네레이터 함수는 function 키워드 뒤에 별표(*)를 사용하여 표현하고 새로운 키워드인 yield 를 사용한다. 
자신의 상태를 유지할 수 있는 단일 함수를 작성하여 반복 알고리즘을 정의할 수 있게한다. 또한 이터레이터에 데이터를 제공하는 하나의 방법이다.
제너레이터의 가장 큰 특징은 상태를 제어할 수 있다는 점에서 큰 장점을 가진다는 것이다.

제너레이터를 만드는 방법은 function에 별표(*)를 붙이는 것인데 별표를 function 다음에 바로 사용해도 되고, 아래의 코드와 같이 공백을 두고 사용해도 된다.

``` javascript
function *createIterator() {
	yield 1;
	yield 2;
	yield 3;
}

// 제네레이터는 보통의 함수처럼 호출되지만 이터레이터를 반환한다.
const iterator = createIterator();

console.log(iterator.next().value); // 1
console.log(iterator.next().value); // 2
console.log(iterator.next().value); // 3
```

아니면 아래처럼 for문과함께 사용해도 된다.
``` javascript
const createIterator = function* (data) {
    for (let i = 0; i < data.length; i++) {
        yield data[i];
    }
};

const iterator = createIterator([1, 2, 3]);

console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());

console.log(iterator.next());
```

결과는 아래와 같다.

``` shell
Object {value: 1, done: false}
Object {value: 2, done: false}
Object {value: 3, done: false}
Object {value: undefined, done: true}
// 이후 동일
``` 

(Introducin python 참조) 
제너레이터는 한 번만 실행될 수 있다. 변수들은 메모리에 존재하지만 제너레이터는 즉석에서 그 값을 생성하고, 이터레이터를 통해서 한번에 값을 하나씩 처리한다. 제너레이터는 이 값을 기억하지 않으므로 다시 시작하거나 제너레이터를 백업할 수 없다.
