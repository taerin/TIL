# Closure (클로져) 
	자신의 범위(Scope) 밖에있는 변수들에 접근할 수 있는 함수를 의미한다.

	보통 자바스트립트의 내에서는 함수의 생명주기는 끝이났지만
	함수내의 변수를 내부함수가 참조하기때문에 유지되어 접근할 수 있는함수를 클로저라고 한다.

#### 범위(Scope)
``` javascript
function init() {
	  var name = "모질라"; // init에 있는 지역 변수 name
	  function displayName() { // 내부 함수, 즉 클로저인 displayName()
	    alert(name); // 부모 함수에 정의된 변수를 사용한다
	   }
	  displayName();
}

init();
```
함수 init()은 지역 변수 name과 함수 displayName()을 정의한다. 
displayName()은 함수 init() 안에 정의되어 그 함수(init()) 안에서만 사용할 수 있는 내부 함수이다. 
함수 displayName() 자신은 지역변수를 가지지 않지만 외부 함수에 정의된 변수에 접근하는 권한이 있어 부모 함수에 있는 변수 name을 사용할 수 있다.

	자바스크립트에서 중첩된 함수는 그 함수 외부에서 정의된 변수를 사용할 수 있다. 

#### 클로저(Closure)
``` javascript
	function makeFunc() {
		var name = "모질라";
		function displayName() {
			alert(name);
		}
		return displayName;
	}

var myFunc = makeFunc();
myFunc();
```
이 코드를 실행하면 앞서 예로 들은 init() 함수와 동일한 결과를 보이는걸 알 수 있다(알람창에 "모질라" 문자열이 보일 것이다). 위 예제와 다른 점, 그리고 흥미로운 점은 외부함수의 리턴 값이 내부함수 displayName() 라는 것이다.

위 코드의 동작방식은 직관적이지 않다. 
일반적으로 함수안에 정의된 지역변수는 함수가 실행하는 동안에만 존재한다.
makeFunc() 함수가 종료될 때 이 함수 내부에 정의된 지역변수는 없어지는게 상식적이다.
하지만 이 코드가 문제없이 동작하는 걸 보면 다른 일이 일어나고 있는 것 같다!
이것은 myFunc 함수가 클로저이기 때문이다. 
	** 클로저는 두 개의 것(함수, 그 함수가 만들어진 환경)으로 이루어진 특별한 객체의 한 종류이다. **
	환경이라 함은 클로저가 생성될 때 그 범위 안에 있던 여러 지역 변수들로 이루어진다.
	이 경우에 myFunc는 displayName 함수와 "모질라" 문자열을 포함하는 클로저이다.

``` javascript
function makeAdder(x) {
	  return function(y) {
  	      return x + y;
  };
}

var add5 = makeAdder(5);
var add10 = makeAdder(10);

print(add5(2));  // 7
print(add10(2)); // 12
```
여기서 인자 x를 받아 새 함수를 반환하는 makeAdder(x) 라고 하는 하나의 인자를 받는 함수를 만들었다.
반환되는 함수는 인자 y를 받아서 x 값과 y 값의 합을 돌려주는 함수이다.
add5와 add10은 둘다 클로져이다.
두 함수는 같은 정의를 가지지만 다른 환경을 저장한다. add5의 환경에서 x는 5이지만 add10 의 환경에서 x는 10이다.

### 실용적인 클로저
#### 클로저는 실용적인가? 
	어떤 데이터(환경)와 함수를 연관시키는데 클로저를 사용할 수 있다.
	이건 객체지향 프로그래밍과 유사하다.
	객체지향 프로그래밍에서는 객체가 데이터(그 객체의 속성)와 하나 이상의 메소드를 연관시키는데 클로저를 사용할 수 있다. 
	
	결론적으로 오직 하나의 메소드를 가지고 있는 오브젝트를 사용하는 곳에 일반적으로 클로저를 사용할 수 있다.

### 클로저를 이용해서 private 함수 흉내내기
	몇몇 언어(예를들어 자바)는 같은 클래스 내부의 메소드에서만 호출할 수 있는 private 메소드를 지원한다.

	자바스크립트는 이를 지원하지 않지만 클로저를 이용해서 흉내낼 수 있다.
	private 함수는 코드에 제한적인 접근만을 허용한다는 점 뿐만 아니라
	전역 네임스페이스를 깔끔하게 유지할 수 있다는 점에서 중요하다.

``` javascript
var counter = (function() {
		var privateCounter = 0;
	
	function changeBy(val) {
		privateCounter += val;
	}
	
	return {
	increment: function() {
	changeBy(1);
	},
	decrement: function() {
	changeBy(-1);
	},
	value: function() {
	return privateCounter;
	}
  }   
})();

console.log(counter.value()); // logs 0
counter.increment();
counter.increment();
console.log(counter.value()); // logs 2
counter.decrement();
console.log(counter.value()); // logs 1
```
이전 예제에서는 각 클로저가 자기만의 환경을 가졌지만 이 예제에서는 하나의 환경을 counter.increment, counter.decrement, counter.value 세 함수가 공유한다.

공유되는 환경은 정의되자마자 실행되는 익명 함수 안에서 만들어진다.
이 환경에는 두 개의 private 아이템이 존재한다. 
하나는 privateCounter라는 변수이고 나머지 하나는 changeBy라는 함수이다.
이 두 아이템 모두 익명함수 외부에선 접근할 수 없다.
하지만 익명함수 안에 정의된 세개의 public 함수에서 사용되고 반환된다.

이 세개의 public 함수는 같은 환경을 공유하는 클로저이다.
자바스크립트 문법적 스코핑(lexical scoping) 덕분에 세 함수 모두 privateCounter 변수와 changeBy 함수에 접근할 수 있다.

### 반복문안에서의 클로저
``` javascript
<input type="button" id="btn1"/>
<input type="button" id="btn2"/>
<input type="button" id="btn3"/>
<input type="button" id="btn4"/>
```
위와 같이 버튼이 4개 있고 각 버튼을 클릭했을때 각 버튼당 1,2,3,4가 찍히게 하고 싶다. 
당연히 가장 쉬운 방법은 각 버튼에 인라인으로 onclick="alert('1')" 처럼 
각 버튼당 파라미터를 주는 것이 쉽겠지만 이럴 경우 요즘 일반적인 구조와
동작을 불리하는 Unobtrusive Javascript에도 맞지 않고 유지보수에도 별로 좋지 않다. 

일반적으로 사람들이 위와같은 구현을 하기 위해서 가장 먼저 시도하는 코드는 아래와 같을 것이다.
 
``` javascript
window.onload = function() {
	 for(var i = 1; i < 5; i++ ) {
		 document.getElementById("btn" + i).addEventListener("click", function() {
				 alert(i);
				 }, false);
	 }
}
```
위 코드는 제대로 동작하지 않는다. 
for문을 돌면서 각 버튼에 click 이벤트리스너를 등록하고 각 루프에서의 i를 alert으로 보여준다. 
이 경우 1,2,3,4의 alert()을 의도한것이지만 alert()에 넘겨준 파라미터는
i의 값이 아닌 i의 참조이기 때문에 실제 버튼을 클릭하면 모든 버튼을 클릭할 때 i의 최종값이 5가 모두 찍혀버린다.

위 예제는 클로저의 생성으로 인한 부작용을 보여준다.
원래 의도는 각 버튼마다 alert시에 1,2,3,4를 결과로 보여주려는 의도이나
이벤트 핸들러 함수의 i값이 바깥쪽 변수인 i값에 대한 참조를 유지하고 있어, 즉 클로저의 생성으로 인해 최종값인 5를 모두 가리키게 되는 예제이다.

이 상황에선 클로저를 쓰는 것이 적당하다.
``` javascript
 window.onload = function() {
	 for(var i=1; i < 5; i++ ) {
		 (function(m) {
		  document.getElementById("btn" + m).addEventListener("click", function() {
			  alert(m);
			  }, false);
		  })(i);
	 }
 }
```
for문안에 실행할 구문을 익명함수((function() {})와 같은 형태)로 만들고 i를 파라미터로 넘기면서 실행시켜버린다.(익명함수에 (i)를 붙혀서 바로 실행시킴.)
이렇게 하면 익명함수안의 내부변수인 m에 i의 값이 할당되고 구조상으로는 실행뒤에 소멸되어야 하지만
클로저로 인하여 각 값으로 할당된 멤버변수를 각 이벤트리스너에서 그대로 사용할 수 있게 된다.
위 코드로 실행하면 각 버튼을 클릭시 1,2,3,4의 원하던 값이 찍히게 됩니다.

	클로저의 부작용을 막기위한 처리로 제시한 예제인데, 이 예제도 클로저가 생성되지만
	익명함수의 인자로 값을 넘겨버림으로써 바깥쪽 변수인 i에 대한 변수스코프를 끊어버리고,
	이벤트 핸들러에서는 익명함수의 인자값에 접근함으로써 의도한 대로 처리가 되게 된다.
	** 괄호로 둘러싼 함수표현식 안에서는 바깥쪽 변수에 접근하지 못한다는 것을 여기서 알 수 있다. **

### 성능
	클로저가 필요하지 않은 작업인데도 함수안에 함수를 만드는 것은 스크립트 처리 속도와 메모리 사용량 모두에서 현명한 선택이 아니다.

	예를들어 새로운 오브젝트나 클래스를 만들 때 오브젝트 생성자에 메쏘드를 정의하는 것 보다 오브젝트의 프로토타입에 정의하는것이 좋다.
	오브젝트 생성자에 정의하게 되면 생성자가 불릴때마다 메쏘드가 새로 할당되기 때문이다.

``` javascript
function MyObject(name, message) {
	this.name = name.toString();
	this.message = message.toString();
	this.getName = function() {
		return this.name;
	};

	this.getMessage = function() {
		return this.message;
	};
}
```
위의 코드는 일일히 메쏘드를 만들면서 클로저의 이점을 살리지 못하고 있다.

``` javascript
function MyObject(name, message) {
	this.name = name.toString();
	this.message = message.toString();
}

MyObject.prototype = {
getName: function() {
			 return this.name;
		 },
getMessage: function() {
				return this.message;
			}
};
```
위 코드 방법 또는
``` javascript 
function MyObject(name, message) {
	this.name = name.toString();
	this.message = message.toString();
}
MyObject.prototype.getName = function() {
	return this.name;
};
MyObject.prototype.getMessage = function() {
	return this.message;
};
```
위의 두 예제에서는 상속된 속성은 모든 오브젝트에서 사용될 수 있고 메쏘드 정의가 오브젝트가 생성될 때마다 일어나지 않는다.

출처: https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/Closures
	/ https://blog.outsider.ne.kr/506
