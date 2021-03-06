# 함수의 toString 메서드에 의존하지 마라
-------

자바스크립트 함수에는 놀라운 기능이 있다.
함수는 toString 메서드를 통해 그 소스코드를 문자열로 재생산 할 수 있다.

``` javascript
(function(x) {
	return x + 1;
}).toString(); // "function (x) {\n return x + 1; \n}"
```

함수의 소스코드를 다시 볼 수 있다는 점은 매우 강력하다. 하지만 함수의 to String 메서드에는 중대한 제약이 있다.
첫째로, ECMAScript 표준은 함수의 toString 메서드의 결과로 나오는 문자열에 대한 어떤 요구사항도 강요하지 않는다. 
이는 자바스크립트 엔진에 따라 결과 문자열이 달라질 수도 있고, 심지어 함수의 내용을 담은 문자열을 만들어 내지 않을 수 도있다는 것이다.

실제로 자바스크립트엔지은 함수 소스코드의 신뢰할 만한 표현을 제공하려고 시도한다.
함수가 순수 자바스크립트로 구현되어 있다면 말이다.
호스트 환경의 내장 라이브러리로 만들어진 함수는 이에 준하지 않는 실패 사례 중 하나다.

``` javscript
(function (x){
	return x + 1;
}).bind(16).toString(); // "function (x) {\n [native code]\n"
```


많은 호스트 환경에서, bind 함수는 또다른 프로그래밍 언어(일반적으로 c++)로 구현되었기 때문에, 실행 환경에 보여주기 위한 자바스크립트 코드를 전혀가지지 않는 컴파일된 함수를 생성한다.

브라우저 엔진은 표준에 의해 toString의출력으로 다양한 값을 반환할 수 있도록 허용하기 때문에 하나의 자바스크립트 시스템에서는 제대로 동작하지만 다른 곳에서는 실패하는 프로그램을 만들어 내기 쉽다.
자바스트립트의 구현체가 매우 작은 수정 (예를들어, 공백 문자열 포맷팅)을 할 수 있고, 이로인해 함수 소스코드 문자열의 정확한 세부 사항에 매우 민감한 프로그램을 망가 뜨릴 수도 있다.
마지막으로, toStringㅇ으로 생성된 소스코드는 그 내부 변수 참조에 연관된 클로저의 값을 표현하지못한다.
예를들면 다음과 같다.

``` javascript
(function (x){
	return function(y){
		x + y;
	}
}).(42).toString(); // "function (y) {\n ruturn x + y;]\n"
```

함수는 실제로 클로저이고 x를 42로 바인딩하고 있음에도 불구하고 결과문자열이 x의 변수 참조를 여전히 가지고 있다는 점에 주목하라.

이러한 제약 때문에 유용하고 신뢰할 만한 함수 소스를 추출하기 어렵고, 일반적으로 이 방법을 사용해서는 안된다. 함수 소스를 추출하기 어렵고 매우 복잡하기 때문에 반드시 주의 깊게 만들어진 자바스크립트 파서와 프로세싱 라이브러리를 사용해야한다.
하지만 약간이라도 의심스럽다면, 자바스크립트 함수를 쪼갤 수 없는 추상으로써 다루는 것이 가장 안전하다.

### 기억할점
* 자바스트립트 엔진은 toString을 통해 함수 소스코드의 정확한 내용을 생성할 필요가 없다.
* 함수 소스의 정확한 세부 사항에 절대로 의존하지 마라. 다른 엔진은 toString에 다른 결과를 만들어 낼 수 있기 때문이다.
* toString의 결과는 클로저에 보관된 지역변수의 값을 노출하지 않는다.
* 일반적인 경우 함수의 toString()을 사용하지마라.
