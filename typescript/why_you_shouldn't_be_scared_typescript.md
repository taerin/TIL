# TypeScript를 무서워하지 않아도 되는 이유
 TypeScript는 컴파일하면 JavaScript가 되는(compile-to-JavaScript) 언어이며, 컴파일 시점에 타입 체크를 하고, 전통적인 객체기반 프로그래밍 패턴을 도입하는 것 이외에도 강력한 기능들을 JavaScript 에 추가한다.

그러나 적지 않은 수의 사람들이 TypeScript를 꺼리고 있다. 그도 그럴 것이, TypeScript 는 결국 컴파일 하면 JavaScript 가 되기 때문이다. 우리는 당연히 중간 과정을 필요로 하지는 않는다. 순수함을 지향하려는 입장에서 어떤 감정일지 짐작이 간다.
하지만TypeScript 사용 여부를 떠나서 TypeScript를 사용하면서 얻게 되는 강력한 이점이 있고, TypeScript에 대해 의심할 필요는 없을 것이다.

## 왜 순수한 Javascript를 사용하지 않는가?
컴파일해서 javaScript 가 되는 언어들에 대한 이야기들이 점점 많아지고 있다. CoffeeScript, TypeScript, ClojureScript, GorillaScript 등등 많은 언어가 있지만 결국은 "왜"의 문제가 나온다. 결국 JavaScript 를 얻기 위해 왜 새 언어의 복잡성이나 새로운 툴체인을 접하는 수고를 할 필요가 있을까? Vanilla JS 를 쓰면 안되나?

많은 이유들로 인해 사람들이 변환 언어(원문 : transpiled languages)를 만들지만 그 중 가장 중요한 이유는 이것들이다.
	* 기능의 추가
	* 혁신의 자유로움

## 변환 언어와 추가되는 기능들
변환 언어의 한 가지 중요한 장점은 기능이 추가된다는 것이다. 이것이 TypeScript 의 가장 중요한 메리트이며 TypeScript는 인터페이스와 추상 클래스, 대수(algebraic) 데이터 타입 등의 기능을 JavaScript 에 더하며, 다른 라이브러리들을 추가적으로 사용하지 않아도 된다.

변환 언어는 순수한 JavaScript 에 새로운 기능을 도입하며 그것들에 대해 자세히 알지 않더라도 인터페이스를 이용하여 사용할 수 있게 한다. 우리는 심지어 일반적인 JavaScript 를 쓸 때도 이미 이런 과정을 하고 있는데, JavaScript 의 최신 기능을 사용하기 위해 ES6 를 ES5 로 변환하는 트랜스파일러(transpiler)를 사용하는 것과 같은 방식이다. 일부 사람들이 ES6 가 완전히 지원되는 브라우저를 사용하겠지만.... 대체로 우리와 같이 변환 과정이 필요할 것이다.

## 변환언어는 혁신의 자유로움을 준다
CoffeeScript 는 JavaScript 기반에 가장 큰 혁신을 가져온 언어일 것이다. CoffeeScript는 명백히 "문법적(syntactically)"이다.

``` javascript
<span style="font-size: 12pt;"># Ruby-style comments w/ hash, no semicolons, only arrow functions
Person = (name) =>
	# @ indicates 'this'
	@name = name

	@speak = () =>
	console.log @name

	return @

Me = Person('Peleke')
Me.speak()
</span>
```

이 코드는 JavaScript 로 보이지는 않지만 다음과 같은 새로운 문법이 들어있다.

* @ 는 this 를 대신한다. 그러므로 this.user 는 @user 이다.
* 함수는 => 나 -> 로 선언되고 function 키워드는 사용하지 않는다.

그리고 CoffeeScript는 == 를 허용하지 않고 === 를 강제한다. 예외가 되는 케이스는 강제 형변환이나 ` 사이에 JavaScript 를 넣어서 사용할 때다.

TypeScript 는 완전히 다른 목표를 갖고 있고 CoffeeScript 보다 좀 더 보수적이다. 새로운 문법이나 디자인 패턴을 제안하기 보다는 JavaScript 자체를 시작점으로, 기본에 작은 것을 더하는 것으로 시작했다. 예외사항은 거의 없으며 심지어 vanilla ES6 는 TypeScript 의 문법과 완벽하게 호환된다. 다른 JavaScript로 컴파일 되는 언어들에 비해 좀 더 접근하기 쉬운 이유이다.

변환 언어는 새 버전의 JavaScript 를 이전 버전의 JavaScript 로 변환하는 것보다 좀 더 급진적인 아이디어 이지만, 원리는 비슷하다. 그리고 변환 언어의 가치는 명백하다 : 변환 언어는 새로운 방식을 실험, 확장, 탐험하는 데에 원동력이 된다.

## TypeScript 의 장점
TypeScript 는 몇 가지 새로운 기능을 도입한다. 가장 주목할만한 것은 클래스와 인터페이스, 컴파일타임 타입 체크이며, 이외에도 많은 기능이 숨어있다.
이들 중 몇가지에 대해서는 이야기해 보겠지만, 잘 알려지지 않은 장점 몇가지는 이런 것들이 있다.

	* 익숙함
	* 커뮤니티의 지원과 툴페인의 발전
	* JavaScript 표준과 상호 호환

### 친숙함
TypeScript 의 특징에 대해 할 이야기는 아주 많다. 왜 그런지 약간만 이야기를 해보자.

친숙함의 장점은 아주 큰데, TypeScript 의 특징 중 컴파일시점의 타입 체크, 인터페이스, 클래스 기반의 디자인 패턴 등은 다른 언어 기반에서도 많은 개발자들에게 이미 익숙하다. JavaScript 에 이런 내용들이 없다는 것은 다른 언어를 사용하다 온 개발자들이 공통적으로 느끼는 단점이었고, 전통적인 OOP 가 디자인하고 개발하고 논의하기 편하다고 생각했기 때문에 TypeScript 에서는 이런 사항을 추가했다.

이것이 지금 쓰던 언어를 버리고 새로운 언어를 배워야 한다는 이유인지는 의문이 들 수도 있다. 해스켈 커뮤니티에게 왜 바로 IO를 할 수 없는가라고 묻는 것이 더이상 의미가 없다는 것 뿐 아니라 자바스크립트가 그 자체로 가지고 있는 부족함에 대하여 투덜거리는 것이 개발자들 사이에서 나온다는 것에 대하여 논쟁하는 것은 타당할 것이다.

무엇보다도, 사람들은 툴에 익숙할 때 생산성이 높아진다는 것은 엄연한 사실이다.

TypeScript가 개발자들에게 좀 더 나은 생산성을 준다면, 개발자들이 사용할 수 있을 것이고 사용해야 할 것이다. 그 언어만의 러닝 커브가 있는 언어에 당장 뛰어드는 것은 현실 프로젝트에서 말이 안되는 일이다.
TypeScript 에 대해 적당한 비판이 될 수 있는 것 중 하나는, JavaScript에 존재하지 않는 기능을 TypeScript가 어떤 환상으로 만든다는 것이다. 클래스, 인터페이스, 정적 타입들은 JavaScript에 곧 나올 것이라고 기대하는 내용이지만 TypeScript 는 이미 구현해두었고, 둘이 같은 내용이 아니라는 것이 문제다.

TypeScript 가 "진짜로" 클래스, 인터페이스, 런타입 타입 체크를 구현한다는 오해를 갖고 코드를 작성하면 상당히 어색한 코드를 볼 수 있을 것이다. 분명한 사실은, JavaScript의 취약점을 문법적인 꾸밈으로 TypeScript에 추가한 것이지 JavaScript 베이스에서 무언가를 구현한 것이 아니라는 것이다. 하지만, JavaScript 를 잘 쓰고 있는 사람에게 TypeScript의 추가되는 점은 좀 더 나은 방법으로 생각을 해보고 작업 효율을 높여줄 수 있을 것이다.

### 지원
TypeScript는 그 뒤에 몇몇의 거인들(Giants)에 의해서 또한 장점을 갖는다.
대부분의 JavaScript 로 변환되는 언어들이 커뮤니티의 노력으로 운영되는 반면, TypeScript 는 공식적으로 Microsoft 의 지원을 받는다. MS 에서는 TypeScript를 개발하기 위해 많은 시간을 들였고, 개발자들은 기술적인 거인들의 지원을 받으면서 편안하게 TypeScript를 접할 수 있다.
TypeScript 는 인기있는 에디터들이 모두 지원하며 Sublime Text, Atom, Eclipse, Emacs, WebStorm, Vim 들과 함께 당연히 Microsoft Visual Studio 제품군도 지원한다.

TypeScript는 실제 프로젝트에도 많이 사용되고 있고, 어떤 환경에서 다루던지 문제 없을 것이다.
	* Black Screen 은 OS X 터미널 에뮬레이터이며 IDE 이다.
	* Angular 2 의 메인 코드는 TypeScript 로 작성되었고, 상당한 제안들이 커뮤니티에 계속되고 있다.
	* Visual Studio 의 일부인 MicroSoft Salva 서비스도 TS 를 사용한다.

[TypeScript를 사용하는 목록](https://www.typescriptlang.org/community/friends.html) 을 확인해 보는 것도 좋다.

Angular 2 나 Visual Studio 를 사용하는 것과 무관하게, Microsoft 와 Google 의 웹 개발팀은 당신이 밤에도 잠들 수 있도록 최선의 지원을 다할 것이다.

TypeScript는 IDE 를 만드는 사람에게도 중요한 한 걸음이 될 것이다. TypeScript 프로젝트의 리더인 Hejlsberg 에 따르면, JavaScript는 어노테이션이 없기 때문에 엄격한 IDE 를 만드는 것이 사실상 불가능하다고 한다. 강력한 개발 환경은 팀의 협력방식과 대규모 프로젝트를 좀 더 생산성있게 도울 것이다.

### JavaScript 표준과 상호 호환
순수주의자의 한 사람으로써, TypeScript의 가장 중요한 점은 TypeScript가 그냥 JavaScript라는 것이다. 순수한 JavaScript 를 TypeScript 컴파일러에 넣고 돌리면 거의 문제가 발생하지만(클래스 선언에서의 일반적인 예외), TypeScript 마이그레이션은 점차적으로 진행되고 있다.
이 말은, 당신에게 도움이 되는 기능만을 사용할 수도 있다는 것이고, 필요없는 기능은 쓰지 않으면 된다. 내가 TypeScript를 사용할 때, 클래스, 믹스인, 제네릭, enum 과 같은 기능은 사용하지 않지만 타입 어노테이션, alias, ADT(역주 : Algebraic Data Type)의 일부는 사용하고 있다.
툴을 사용할 때 타입 어노테이션을 매번 사용할 것인지 정할 수 있다. 이것이 TypeScript 장점이다.
기능을 많이 사용하거나, 적게 사용하는 것은 모두 당신에게 달려있다. 모두 쓰거나 전혀쓰지 않거나의 문제가 아니다. 당신이 원하는 것에 전적으로 정해진다.

## TypeScript의 역사
핵심 개발자인 Anders Hejlsberg에 따르면 TypeScript는 JavaScript가 대규모 어플리케이션에 적합하지 않다는 내부 팀과 고객사의 불평들을 대응하기 위해 만들어졌다.
목표는 "클래스, 모듈, 정적 타입과 같은 것들을 통해 JavaScript를 강화하는 것" 이며, open-standard 나 크로스 클랫폼에 대한 이점을 포기하지 않는 것이다.그 결과로 "JavaScript 개발 범위의 어플리케이션을 위한 언어"가 되었고, JavaScript 의 상위언어집합(superset)이 되었다.

## TypeScript vs *Scripts
TypeScript가 많은 장점을 가져왔다고 해도, 다른 JS컴파일 언어들이 필요하냐는 문제가 남아있다.

각각 다른 개발자들에 의해 다른 프로젝트가 시작되었고, 각각의 언어는 다른 솔루션 셋을 제공하거나 장단점이 있기도 하다. 서로 다른 JS컴파일 언어는 문제 해결방식의 간결함이나 스트림라인 처리, 강화 방식이 각각 다르다.
이 말은, 각각이 처한 다른 문제를 다른 방식으로 처리하고 있다는 것이며, 어떤 특정 작업에 특히 어울릴 수도 있다. CoffeeScript는 환경설정 방식이나 아름다운 테스트 방식을 선도하고 있고, 두 가지 모두 내가 TypeScript 에서보다 선호하는 방식이다.

TypeScript와 비교할 만한 것은 Dart와 CoffeeScript이다. 솔직히 말하면, 이 세 언어의 공통점은 JavaScript로 컴파일 된다는 것 뿐이다. 사과와 귤을 비교하는 것과 비슷하다. 왜 그런지 각각의 구조적인 디자인의 차이점을 보도록 하자.

## COFFEESCRIPT
Anders Hejlsberg 는 TypeScript와 CoffeeScript의 기본적인 차이점을 두 가지로 꼽는다.

	1. CoffeeScript는 다른 언어이다. TypeScript는 JavaScript의 상위언어셋이다. CoffeeScript는 JavaScript플랫폼을 타겟으로 하지만 다른 언어이다.
	2. CoffeeScript는 정적 타입의 특성을 갖지 않는다. 이것은 IDE를 사용하는 사람들에게 가장 적절한 이야기이다.

Hejlsberg의 말을 더 인용하자면, "당신이 JavaScript를 알고 있다면 TypeScript는 이미 알고 있는 것이다." 라고 한다. 추가 기능중 마음에 드는 것을 골라 쓸 수 있고, 순수한 JavaScript나 ES6에 익숙하다면 하루면 될 것이다. 하지만 CoffeeScript는 완전히 다른 문법을 배워야 한다. 접하기는 좋지만, 러닝 커브는 비교적 가파르다.

목표하는 언어(역주 : JavaScript)와 일부가 겹친다는 것이 TypeScript 디자인의 기초적인 원칙이다. TypeScript의 요점은 최소한의 표준을 시작으로 출발하여 대규모 JavaScript 어플리케이션을 간단하게 만드는 언어가 되는 것이다.

CoffeeScript는 JavaScript의 상위언어셋과는 관련이 별로 없다. 대신에, CoffeeScript는 "좋은 점을 더욱 부각시키고" 불편한 "나쁜 부분"을 숨기면서 언어의 표현력을 증가시키는 것을 목표로 한다.

두 언어의 접근방식에서 가장 확실한 차이는 다음과 같다.
	* TypeScript는 대체로 독선적이지 않고(역주 : JavaScript를 기반으로 했기 때문에 TypeScript자체의 철학이 상대적으로 적다는 의미) 확장에 적합하다, 반면에
	* CoffeeScript는 언어의 철학을 언어에 녹여냈고, 대규모 어플리케이션의 간편화를 위한 어떤 것은 추가하지 않는다.

TypeScript가 클래스 기반의 프로그래밍이나 정적 타입을 도입하는 것은 확실히 편한 도구가 될 수 있지만, TypeScript는 이것들에 대한 사용을 강제하지는 않는다. 반면에 CoffeeScript는 JavaScript의 좋은 것과 나쁜 것에 대한 강한 의견을 갖고 있고, 그에 맞춰 코딩을 하기를 강요한다.

어떤 것이 다른 것보다 좋다라는 것은 아니며, Brendan Eich는 CoffeeScript는 JavaScript에 몇번이고 영향을 미쳤다고 언급했다. 요점은, 두 언어는 다른 생물이고, 다른 목표를 갖고 있고, 다른 해결책을 갖고 있다는 것이다.

## DART
Dart는 문법적으로 CoffeeScript보다는 TypeScript에 좀 더 가깝지만, 두 언어보다는 Dart 언어 자체의 디자인 철학을 더 강조하는 것으로 시작한다.

Dart와 CoffeeScript는 JavaScript에 개선이 필요하다는 것에 동의하지만, 다른 방식으로 문제에 접근한다. Dart 팀은 CoffeeScript와의 차이점을 크게 아래와 같이 꼽는다.
	* Dart는 다른 문법적 선택을 만들었다.
	* "CoffeeScript가 JavaScript의 구조 안에 남아있을 때 Dart는 새로운 구조를 만들어냈다."

비슷하게, Dart와 TypeScript는 "대규모 웹 어플리케이션을 쉽게 만들게 한다는 비슷한 목표를 가지고 있지만", 다른 접근방식을 택한다. "Dart는 일부러 JavaScript의 문법과 구조를 벗어나서 다량의 버그를 배제하고 성능의 향상을 노리"지만 TypeScript는 JavaScript의 호환성을 저변에 유지한다.

이것이 TypeScript 팀에서 이야기하는 가장 큰 차이점이다.

> 본질적으로 볼 때, JavaScript의 모든 장점을 방해하지 않으면서 JavaScript에 빠진 몇몇을 어떻게 넣어야 할 것인가 - Hejlsberg

Dart 팀은 "JavaScript에 빠진 몇몇" 보다 더 많은 것이 있다고 판단했고, 언어를 그에 따라 디자인했다. 그리고 TypeScript가 웹에서의 개발 경험의 향상을 목표로 하는 중에 Dart는 모바일 앱 개발에 비슷한 목표를 갖고 있다. 언어 디자이너에게 새로운 문제거리가 될 수도 있겠지만, TypeScript와는 매우 다른 언어이면서도 환상적인 언어이다.

## 결론
JavaScript는 20년동안 제 역할을 잘 수행해왔다. 이제와서 우리가 또다른 뭔가가 필요한지에 대해 논의하는 것은 어렵다. 반면에, 또다른 무언가에서 이득을 보지 않는다고 할 수도 없다. TypeScript는,
	* JavaScript보다 좀 더 사람들에게 편하고,
	* 무엇을 취하고 무엇을 버릴 것인지 자유롭고,
	* 더 강력한 툴에서도 사용할 수 있으며,
	* 결국엔 단지 JavaScript이다.

내 기준에서, 나는 Angular 2나 Rx.js를 작성할 때 TypeScript를 사용하며 긴 함수형 코드를 작성할 때도 TypeScript를 사용한다(나는 함수를 타이핑하는 취미가 있다). 그 외에는 vanilla JS를 선호한다. 둘을 왔다 갔다 하는 것은 아주 간단하고 거의 신경쓸 것이 없다.

TypeScript를 사용하든지 그렇지 않든지, TypeScript는 반박할 수 없는 장점이 있고 이런 것들을 경험해보는 것은 유익한 일이다. 당신이 새로운 것을 배우기 좋아한다면 이 문서를 슬쩍 보고, 작은 무언가를 만들어보고 어떤지 보라. 마음에 든다면 그럼 된 것이다. 마음에 들지 않는다면, 그것도 괜찮다. 확장자를 .js 로 바꾸고 원래 하던대로 해라!

[출처](http://han41858.tistory.com/14)
[원문](https://scotch.io/tutorials/why-you-shouldnt-be-scared-of-typescript?utm_content=buffer12781&utm_medium=social&utm_source=facebook.com&utm_campaign=buffer)




