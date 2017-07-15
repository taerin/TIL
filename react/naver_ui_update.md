# React 적용 가이드 - 네이버 메일 모바일 웹 적용기

제는 네이버의 다른 서비스에도 React와 Redux를 적용하는 사례가 늘고 있어 시간이 많이 지났지만 네이버 메일 모바일 웹에 React와 Redux를 적용하기까지의 이야기를 풀어 봅니다. 그 당시에 왜 React와 Redux를 사용하는 구조를 선택했는지를 이야기하고, React와 Redux를 학습하고 개발에 적용하면서 겪은 경험을 이야기하겠습니다.

## 변화의 필요성

기존의 네이버 메일 모바일 웹은 로딩 시간을 줄이기 위해 초기 페이지 렌더링은 서버에서 JSP로 진행하고 이후 동작은 AJAX 통신으로 동작하는 SPA(single page app)였다. 그렇기 때문에 페이지를 그리는 로직이 JSP 파일과 JavaScript 파일에 중복으로 존재하는 경우가 많았다. 결국 마크업이 변경되면 JSP 코드와 JavaScript 코드를 변경하는 이중 작업을 진행해야 했다.

더불어 JavaScript 코드는 DOM(document object model) 요소를 가져와 변경하는 작업이 대부분이었는데 뷰와 로직이 분리되지 못한 상황이었다. 그래서 마크업의 변경은 JavaScript 코드의 대부분을 수정해야 함을 의미했다.
결국 전체 마크업이 변경되는 상황에서는 프런트엔드를 새로 작성하는 편이 빠르겠다는 결론에 도달했다. 그리고 새로운 프레임워크와 라이브러리를 사용해 보고 싶다는 개발자로서의 욕구도 컸다.

## 후보군 모색
### 프레임워크와 라이브러리
당시(2015년 11월 초)에 JavaScript Weekly에서 많이 언급되는 프레임워크와 라이브러리 중에서 다음 4개를 후보로 골랐다.

	* Backbone.js
	* Angular JS
	* Ember
	* React

### Backbone.js
Backbone.js는 팀에서 사용해 본 경험도 있고 이름의 의미처럼 탄탄하게 만들어진 느낌을 주는 후보라 제일 처음으로 고려했다. 하지만 Google 트렌드와 여러 뉴스레터에서 언급되는 횟수가 감소하고 있었다. 그리고 다른 라이브러리에 의존성이 있다는 점도 부담으로 느껴졌다.
(구글 트렌드나 뉴스레터에서 많이 언급되는 언어나 라이브러리를 보는게 중요하겠꾼!)

* Backbone.js의 의존성 
Backbone.js의 공식 사이트에서는 Underscore만 꼭 필요하고 나머지는 선택 사항이라고 한다. 하지만 실제 서비스를 개발하다 보면 jQuery는 기본으로 포함하고 템플릿 엔진으로 handlebars도 추가해서 사용하는 것이 일반적이다.
	
* Angular JS
Angular JS를 후보로 고려하던 당시에는 Angular 2.0 개발이 진행 중이었고 서비스에 적용할 수 있는 버전은 Angular JS 1.x 버전이었다. Google 트렌드에서 보이는 점유율이 압도적으로 높았지만 뉴스레터에서는 좋지 않은 내용의 글(특히 성능 이슈)이 자주 보여 선택이 망설여졌다. 더불어 Angular 2.0은 Angular JS 1.x와 완전히 다른 프레임워크로 변경될 예정이었다. Angular JS 1.x를 적용하면 얼마 안 돼 낡은 방식의 코드가 될 수 있다는 불안감이 있었다.

* Ember
Ember는 해외에서는 인기가 있지만 국내에서는 전혀 관심을 받지 못하고 있었다. 미래를 내다봤을 때 대세로 확대되긴 어려울 것이라 판단해 제외했다.

* React
React는 2015년에 React Native가 나오면서 인기를 끌고 있는 후보였다. 뉴스레터에서 인기가 계속 높아지고 있었고 다음과 같이 라이브러리를 비교하는 글들에서도 좋은 점이 부각되고 있어 호감도가 제일 높은 후보였다.
* [Choosing a Front End Framework: Angular vs. Ember vs. React](https://smashingboxes.com/blog/choosing-a-front-end-framework-angular-ember-react)
* [Why We Moved From Angular to React](http://blog.belong.co/why-we-moved-from-angular-to-react)

## ECMAScript 2015와 React 선택
후보군 사이에서 한창 고민하고 있을 때 "[Front-end 개발의 괜찮은 선택 ES6 & ReactJS](http://readme.skplanet.com/?p=12183)"  발표를 들었다. 발표의 많은 부분에 공감했고 발표를 참고해 다음과 같은 선택 기준을 세웠다.

* 오랫동안 유지 보수가 가능하고 지속 가능한 코드가 되면 좋겠다.
* 외부 라이브러리 의존도가 없으면 좋겠다.
* 되도록 표준(HTML5, ECMAScript 2015)을 사용하자.

> HTML5와 ECMAScript 2015를 사용하면 jQuery와 Underscore 같은 라이브러리를 사용하지 않아도 된다. 다음 글은 jQuery와 Underscore를 HTML5와 ECMAScript 2015로 대체할 수 있는 다양한 방법과 예를 보여 준다. 
> [You might not need jQuery](http://youmightnotneedjquery.com/)
> [You Might Not Need Underscore](https://www.reindex.io/blog/you-might-not-need-underscore/)

결론은 표준인 ECMAScript 2015와 잘 어울리고 외부 라이브러리 의존이 없는 React였다.

잘 알려진 React의 다음 장점도 선택에 영향을 주었다.

* Virtual DOM을 통한 성능 이점
* 컴포넌트 단위의 재사용성 증대
* 서버와 클라이언트가 같은 코드로 렌더링하는 유니버설 렌더링(universal rendering) 사용 가능
* Facebook이 실제 서비스(Facebook과 Instagram)에 적용해 운영 중

그러나 ECMAScript 2015와 React를 적용하려고 보니 추가로 공부해야 하는 부분이 많았다.

* ECMAScript 2015
* React
* webpack
* Babel
* Flux, Redux

## ECMAScript 2015 학습
ECMAScript 2015는 많이 사용하게 될 것 같은 문법 위주로 주제를 맡아 하루 30분~1시간씩 2주일 동안 스터디를 진행해 익히는 방식으로 공부했다. 스터디 진행 시에는 추가된 문법이 무엇이 있는지 훑어보는 정도로만 학습하고 실제로 개발을 진행하면서 체득한 덕분에 ECMAScript 2015를 빠르게 익힐 수 있었다.

"[Exploring ES6](http://exploringjs.com/es6/index.html)" 를 기본 자료로 보며 스터디를 진행했다. 다음 장들을 중점적으로 봤으며, 이 장들에 있는 내용은 실제 개발 중에도 많이 사용했다.

* [Variables and scoping](http://exploringjs.com/es6/ch_variables.html)
* [Template literals](http://exploringjs.com/es6/ch_template-literals.html)
* [Destructuring](http://exploringjs.com/es6/ch_destructuring.html)
* [Arrow functions](http://exploringjs.com/es6/ch_arrow-functions.html)
* [Classes](http://exploringjs.com/es6/ch_classes.html)
* [Modules](http://exploringjs.com/es6/ch_modules.html)
* [Promises for asynchronous programming](http://exploringjs.com/es6/ch_promises.html)

## React 학습
React 학습은 개발을 시작하기 전에 1박 2일 동안 세미나를 하며 진행했다. 기존 개발 방식과는 패러다임이 다르기 때문에 세미나 진행을 통한 사고의 전환 과정이 이후 빠른 개발에 큰 도움이 됐다.

## webpack과 Babel 학습
webpack과 Babel은 개발 환경 설정에 가까운 내용이라 한 사람만 고생해서 설정을 마치면 다른 개발자는 편하게 그 환경에서 개발을 진행하면 된다. 팀원 중 비교적 시간이 많은 사람이 시간을 투자해 고생하며 학습한 덕분에 다른 개발자들은 편하게 개발할 수 있었다.
이런 설정은 프로젝트의 환경 설정을 표준화하는 보일러플레이트 프로젝트를 참고하면 도움이 많이 된다. React 프로젝트를 위한 보일러프레이트 프로젝트도 많아서 취향에 맞게 프로젝트를 선택할 수 있는 다음과 같은 사이트도 있다.

* [Find your perfect React starter project](http://andrewhfarmer.com/starter-project/)

## Flux와 Redux 학습



[출처] http://d2.naver.com/helloworld/4966453

