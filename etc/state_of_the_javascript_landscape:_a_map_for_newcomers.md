# JavaScript 생태계의 현상황 : 초심자를 위한 안내
-----
 프로그래밍 경험은 있지만 프론트엔드 JavaScript 을 처음 접했다면 많은 용어나 툴들이 생소할 수 있다. 진부한 토론의 늪에 빠지지 말고, 현재 "JavaScript 생태계" 에 대한 일반적인 조사 결과를 보자. 프론트엔드 개발을 시작하는 데에 훌륭한 기준점이 될 수 있을 것이다.

## 클라이언트측 JavaScript 는 어떻게 동작하며, 왜 사용해야 하는가?
요점 : DOM (Document Object Model), JavaScript, 비동기, AJAX

효율적인 프론트엔드 코드를 작성하기 위해, HTML, CSS, JavaScript 가 어떻게 엮여져 웹 페이지를 구성하는지 알 필요가 있다.

클라이언트 (보통 브라우저) 가 HTML 페이지에 접근하면, 다운받고, 파싱하고, DOM (Document Object Model) 을 구성하는 데에 사용한다.

JavaScript 는 DOM 을 조작하는 데에 사용되며 JavaScript 로 상호작용하는 웹사이트를 만들 수 있는 방법이다. DOM 에 대한 소개

JavaScript 는 어떻게 페이지 안에 포함될까? 이것은 별도의 script 태그로 시작한다.

JavaScript 의 실행은 DOM 생성을 중단시킨다. 이 말은, JavaScript 가 페이지를 반응하지 못하게 하는 데에 많은 시간을 쓴다는 것이다. 이런 상황을 피하기 위해 클라이언트측 JavaScript 는 종종 비동기로 동작한다. (AJAX 라는 말을 들어보았을 텐데, 이것은 단순히 Asynchronous JavaScript And XML 의 약자이다.)

상호작용할 수 있는 웹사이트를 만들고 있다면, 당신은 JavaScript 가 필요할 것이고, 아마도 많은 하나의 form 이나 다른 요소에 걸쳐 비동기를 다루게 될것이다.


## 프레임워크는 무엇인가? 유행을 따라가야 할까?
요점 : React, Angular, Ember, Backbone, jQuery, Underscore, Lodash

 "프레임워크" 는 많은 뜻이 있다. JavaScript 프레임워크의 목적은 보통 웹사이트에 필요한 작업을 하는 데에 불필요한 작업들을 줄이는 것이다. 프레임워크는 기본적으로 틀을 잡아주며, 특정 문제를 해결하기 위해 설계되어 있다.

현재 유행하고 있는 프레임워크들이 해결하려는 문제는, "사용자의 복잡한 행동을 지원하는 SPA(Single-page application, 페이지 갱신 없이 '하나의 페이지에서 동작하는' 어플리케이션) 를 만들 것이며, 프론트엔드의 업무로직을 관리할것인가?" 에 집중하고 있다. -- 예를 들면 Facebook 홈페이지나 Gmail 받은편지함과 같이

그렇다면 어떤 프레임워크를 써야 할까? React? Angular? Ember? 프레임워크가 필요하기는 할까? 잠시 결정을 미뤄두자!

이 프로젝트들은 더 나은 웹 어플리케이션을 작성하는 데에 도움이 될 것이다. 어떤 프레임워크를 써야하는지 정답은 없다. 아무거나 쓰면 된다.

JavaScript 를 이제 막 시작하고 있다면, 프레임워크를 아무것도 쓰지 않는 것이 좋을 수 있고, jQuery 나 작은 프레임워크를 일부 도입하는 것이 좋다. 이 방법은, 작업이 약간 지루할 수는 있지만, 당장 할 수 있고, JavaScript 가 어떻게 동작하는지 감을 잡는 데에 도움이 될 것이다. jQuery 로도 소프트웨어 개발 이론에 대한 것을 연습할 수 있다.

만약 적당히 복잡한 사이트를 만들고 있다면, 프레임워크를 찾게될 것이다. 현재는, Angular, React, Ember 가 가장 인기있고 타당한 선택이다. Backbone 은 약간 오래된 스타일이며, 범위가 좁다(하지만 Backbone 도 많은 프로젝트에 적합하다.) 올려둔 Starter kit 은 React 를 사용하지만, 잘못된 선택은 진짜 아니다. 많은 프레임워크를 비교하기 위해서는 TodoMVC 가 도움이 될 수 있다. 각각의 프레임워크에 대해 같은 기능의 checklist 를 구현해두었다.

JavaScript 는 다른 언어에서는 지원하는 기본적인 라이브러리 함수들에 대해 부족한 점이 있다(문자열에서 빈칸채우기나 배열 안에서 섞기). 이런 점 때문에 jQuery 나 Underscore, Lodash 가 종종 쓰인다. 이 라이브러리들은 일상적으로 포함되어 각각 $, _, _ 로 참조할 수 있고, 만약 JavaScript 파일 안에 많은 $ 기호가 보인다면, jQuery 를 호출하고 있을 가능성이 높다.

새 프로젝트를 시작한다면, 나는 React 나 Angular를 Lodash 와 함께 쓰기를 권한다.

## JavaScript 를 직접 써야하나? 다른 어떤 것을 써야하나? JavaScript 의 종류는 어떤 것이 있나?

요점 : ES5, ES6, ES2015, CoffeeScript, TypeScript, ClojureScript, Babel, transpiling, compiling, MDN reference

"JavaScript" 는 실제로 하나의 언어를 말하는 것은 아니다. 각 브라우저 제공사는 각각의 JavaScript 엔진을 구현하고 있고, 그래서 브라우저와 브라우저 버전간에 차이가 존재하며, 실제로 JavaScript 의 심각한 파편화가 문제가 되고 있다. CanIUse.com 는 이런 불일치하는 내용에 대해 점검할 수 있으며, Mozilla 개발자 네트워크 문서도 도움이 될 수 있다.

ES2015, Harmony, ECMA Script 6, ECMA Script 2015 라고도 불리는 ES6 는 가장 최신 버전의 JavaScript 표준안이다. 이 표준안은 새로운 문법과 기능에 대해 소개하고 있다. Fat arrows(역주 : Arrow functions), ES6 클래스, 내장 모듈, 템플릿 문자열 등이 이 버전에 포함되어 있다. Treehouse 에서 ES6 를 접해볼 수 있다.

JavaScript 의 파편화된 환경에도 불구하고, 새 표준안을 사용할 좋은 방법이 있다. Babel 은 당신의 아름다운, 표준을 따르는 JavaScript 코드를 이전 버전의 플랫폼에서도 동작하는 코드로 바꿔줄 것이다. 이 작업을 transpiling 이라고 부른다. 컴파일과 많이 다르지는 않다. Babel 같은 툴을 사용함으로써, 어떤 브라우저에서 JavaScript 의 특정 기능이 동작하는지 더이상 머리 아프게 고민하지 않아도 된다.

Transpile 툴은 ES6 를 ES5 로 바꿔주는 것만 있는 것은 아니다. JavaScript 의 변형된 형태인 ClojureScript, TypeScript, CoffeeScript 들에 대해서 동작하는 것도 있다.

ClosureScript 는 Clojure 의 버전 중 하나이며, 컴파일하면 JavaScript 가 된다. TypeScript 는 본질적으로 JavaScript 이지만 type 에 대해 문법적 제약을 둔다. CoffeeScript 는 JavaScript 와 아주 비슷하지만, 좀 더 유려한 문법을 사용한다(CoffeeScript 에 사용된 문법적 트릭(syntax sugar) 들은 ES6에 도입되기도 했다). 모든 컴파일 결과물은 JavaScript 다.

그렇다면 무엇을 사용해야 할까? 프론트엔드 개발에 처음이라면, ES6 스타일로 작성하려고 할 것이다. ES6 문법과 기능들은 각 브라우저 제조사들이 지원하고 있다. 이전 플랫폼에서 동작하기를 원한다면 Babel 과 같이 ES6 코드를 ES5 로 변환해주는 툴을 이용할 수 있다. ClojureScript 와 같이 "JavaScript 로 컴파일되는" 기술은 현재로서는 피하는 것이 좋은데, 프론트엔드 개발 경험이 더 쌓이면, 좀 더 나은 방식으로 사용할 수 있을 것이다.

## 다른 사람의 코드는 어떻게 사용해야 할까?
요점 : AMD, comon JS 모듈, ES6 모듈, npm, Github

 JavaScript 에서 코드 공유와 모듈에 대한 역사는 살짝 복잡하다. Preethi Kasireddy 의 JavaScript Modules : A Beginner's Guide 를 읽어보기를 적극 권장한다.

우리의 입장에서, module 과 library 라는 말은 기본적으로 동일하다. 각각은 코드의 묶음이라는 말과 프로젝트에 재사용할 수 있는 묶음을 가리킨다. JavaScript 모듈은 보통 npm (node package manager) 으로 배포된다. npm 이나 GitHub 에서 JavaScript 모듈을 검색할 수 있다.

모듈을 정의하는 방법은 몇가지가 있다. 주된 것은 CommonJS, AMD, ES6 내장 모듈이다. CommonJS 는 동기적으로 서버측에 접근한다. 반대로, AMD(Asynchronous Module Definition) 는 모듈을 정의하고 로드하는 것을 비동기적으로, 중단없이(non-blocking) 수행한다. CommonJS 와 AMD 는 JavaScript 가 내부적으로 모듈과 의존성에 대한 지원을 하지 않는 상태에서 만들어졌다.

ES6 에서는 언어 내부적으로 JavaScript 모듈 로드를 지원하며, CommonJS 와 AMD 의 방식 모두를 지원한다. 결국, 모듈은 언어의 일부가 되었다.

작업에서 3가지 방식을 골고루 사용할 수 있다. 새 프로젝트에서 ES6 모듈 방식을 사용할 것을 권한다. webpack 과 같은 빌드 툴이 여러 가지 방식으로 구현되어 있는 프로젝트를 로드하는 데에 도움이 될 수 있다.




