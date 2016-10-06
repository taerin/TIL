# Rest Parameter 와 Default Parameter
#### Rest Parameter
일반적으로 API를 정의할 때 variadic function이 필요한 경우가 있다.
variadic function은 인자의 개수가 가변적인 함수이다.
예를 들어 String.prototype.concat 메소드는 문자열을 인자의 임의의 개수만큼 받는다.
레스트 파라미터는 variadic function을 작성하기 위한 ES6의 새로운 문법이다.

* ES5 의 가변인자 함수

``` javascript
function foo (fixArg){
	for (var i = 0;  i< arguments.length; i++)
		console.log(arguments[i]);
}
```

위 코드는 마법의 arguments 객체를 사용합니다. arguments 객체는 함수에 전달된 파라미터들을 담고있는 배열이다.
이 코드는 우리가 원하는대로 동작하지만 가독성이 좋지 않다.
함수의 파라미터 목록에는 fixArg 파라미터 하나만 정의되어 있다.
그래서 이 함수가 여러개의 인자를 취한다는 사실을 한번에 알아보기 어렵다.
더구나 arguments 객체를 순회할때 0 이 아닌 1부터 인덱스를 시작해야만 한다.
arguments[0]은 fixArg 이기 때문입니다. 만약 fixArg 인자의 앞이나 뒤에 파라미터를 추가하고 싶다면 반드시 루프도 함께 수정되어야만 한다.
이는 OCP를 만족하지 못하는 설계가 된다.
레스트 파라미터는 이러한 문제 (1. 가독성이 떨어진다 / 2. OCP를 만족하지 않는다)를 보완한다. 

```javascript
function goo (fixArg, ...args){
	for(let arg of args){
		console.log(arg);
	}
}

goo('fruit', 'grape', 'apple'); 
```
이 함수도 위 ES5 코드와 똑같이 동작하지만 ...args라는 문법을 쓰고있다. fixArg는 위 처럼 처음 전달되는 인자가 전달된다.
args 앞에있는 생략부호 '...'는 레스트 파라미터(rest parameter)임을 표시한다. 
전달되는 나머지 파라미터들이 args 배열 변수에 담겨 전달 된다는 사실을 나타낸다. 
args 라는 배열 변수는 ['grape', 'apple'] 이다. 

* 주의
함수의 마지막 파라미터만 레스트 파라미터가 될 수 있다. 함수 호출시 레스트 파라미터 앞에 파라미터들은 통상적인 규칙에 의해 채워진다.
추가 인자들만 레스트 파라미터에 담겨진다. 만약 추가인자가 없다면 레스트 파라미터는 그냥 빈 배열이 된다. 
레스트 파라미터 배열 변수의 값이 undefined가 되는 경우는 절대 없다.

#### Default Parameter
함수 호출시 함수의 파라미터들을 모두 채울 필요가 없는 경우가 많다.
그리고 전달 되지 않은 파라미터들에 할당할 적절한 디폴트 값이 있는 경우가 많다.
지금까지 javascript에서는 값을 전달하지 않는  파라미터의 디폴트 값은 undefined  였다.
ES6는 파라미터에 임의의 디폴트 값을 지정할 수 있게 하는 새로운 방법을 제공한다.

``` javascript
function animalSentence(animals2="tigers", animals3="bears") {
	    return `Lions and ${animals2} and ${animals3}! Oh my!`;
}
```
각 파라미터의 '=' 기호 다음 부분이 함수를 호출할 때 파라미터 값을 전달하지 않으면 사용하는 디폴트 값을 의미한다.
 그래서 animalSentence()라고 호출하면 "Lions and tigers and bears! Oh my!"가 리턴되고, animalSentence("elephants")라고 호출하면 "Lions and elephants and bears! Oh my!"가 리턴된다. 그리고 animalSentence("elephants", "whales")라고 호출하면 "Lions and elephants and whales! Oh my!"가 리턴한다.

 Python과 달리, 디폴트 값은 함수를 호출하는 시점에 계산됩니다. 
 계산 방향은 왼쪽에서 오른쪽입니다. 이것은 디폴트 값 표현식에 바로 직전에 채워진 파라미터 값을 사용할 수 있음을 의미합니다. 예를 들어 우리는 animalSentence()를 다음처럼 조금 더 팬시(fancy)하게 만들 수 있다.

``` javascript
function animalSentenceFancy(animals2="tigers", animals3=(animals2 == "bears") ? "sealions" : "bears")
{
	  return `Lions and ${animals2} and ${animals3}! Oh my!`;
}
```
그러면 animalSentenceFancy("bears")라고 호출할 때 "Lions and bears and sealions. Oh my!"가 리턴된다.

* undefined를 전달하는 것은 아무것도 전달하지 않는 것과 동일하다. 그래서 animalSentence(undefined, "unicorns")라고 호출하면 "Lions and tigers and unicorns! Oh my!"가 리턴된다.

디폴트 값을 지정하지 않은 파라메터의 디폴트 값은 암묵적으로 undefined 이다. 그래서
``` javascript
function myFunc(a = 42, b) {...}
```

라고 정의하는 것이 허용되며, 이것은 다음과 같이 정의하는 것과 동일하다.
``` javascript
function myFunc(a = 42, b = undefined) {...}
```
arguments 객체를 쓰지 않는 편이 코드를 읽기 쉽게 만든다. 마법의 arguments 객체는 코드를 읽기 어렵게 만들 뿐 아니라 JavaScript VM의 성능을 최적화하는 것도 어렵게 만든다.

레스트 파라메터(rest paramenter)와 디폴트 파라메터(default parameter)로 arguments 객체를 완전히 대치하는 것이 바람직하며 이를 위한 첫단계로 레스트 파라메터나 디폴트 파라메터를 사용하는 함수에서는 arguments 객체를 쓰지 말아야 한다.


[출처: http://hacks.mozilla.or.kr/2015/08/es6-in-depth-rest-parameters-and-defaults/]
