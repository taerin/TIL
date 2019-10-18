# Arrow function
ES6(ES 2015) 부터 도입된 Arrow function은 코드를 간결하게 만들어 주는 역할만 하는것이 아니다. this 바인드 방법에서도 차이가 있다.


``` javascript
const obj = {
  name: "taerin",
  fn: function (arr) {
    arr.forEach(function (e) {
      console.log(`${name} is ${e}`);
    });
  }
};

obj.fn(["nice", "good"]);
```

위와 같은 코드는 잘 동작해 보이지만, 
ReferenceError: name is not defined 라는 참조 에러를 발생시킨다.

fn함수 내부에서는 this가 obj로 내 유지되지만, fn 내의 다른 함수 스코프에서는 this가 자동으로 전역 객체로 바인딩된다.


같은 객체 내의 값에 접근하기 위해서는, 코드를 아래와 같이 수정하면된다.


``` javascript
const obj = {
  name: "taerin",
  fn: function (arr) {
    const that = this;
    arr.forEach(function (e) {
      console.log(`${that.name} is ${e}`);
    });
  }
};

obj.fn(["nice", "good"]);
```


하지만 arrow function은 이러한 작업없이, this를 자동으로 obj내의 스코프로 바인딩한다.


``` javascript
const obj = {
  name: "taerin",
  fn: function (arr) {
    arr.forEach((e) => {
      console.log(`${this.name} is ${e}`);
    });
  }
};
```

하지만 객체 내의 필드값에 접근하기 위해서 this를 명시적으로 작성해주어야 한다. this를 명시적으로 작성하지 않으면 name을 전역 스코프에서 찾는다.
