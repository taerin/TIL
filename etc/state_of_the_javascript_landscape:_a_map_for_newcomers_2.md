# JavaScript 생태계의 현상황 : 초심자를 위한 안내2

## Node.js 가 필요할까?

요점 : Node.js, npm, nvm

Node.js 는 서버측 JavaScript 를 위해 개발되었다. 잠깐, 우리는 지금 프론트엔드 JavaScript 를 이야기 하고 있지 않나?

JavaScript 모듈은 일반적으로 npm (node package manager) 으로 패킹되고 공유되기 때문에, 서버측 개발을 하지 않아도 Node.js 를 설치해야할 수도 있다. OS X 나 리눅스 기반의 시스템에서는 nvm (node version manager)을 사용하여 다른 버전의 Node.js 를 관리할 수 있다. 윈도우 사용자는 nvm-windows 를 참고하자.

## 내 코드를 어떻게 테스트할까?
요점 : Mocha, Jasmine, Chai, Tape, Karma, Selenium, phantomjs

다른 종류의 프로그래밍과 마찬가지로, 프론트엔드 JavaScript 도 테스트를 할 가치가 있다. 대부분의 JavaScript 개발자들은 최소한의 테스트는 작성한다고 한다.

 JavaScript 는 내장 테스트가 없기 때문에 개발자들은 외부 라이브러리를 이용한다. JavaScript 빌드툴과 비슷하게, 각각의 테스팅 툴들은 각각의 문제를 해결하는 데에 집중한다.

 Mocha 와 Jasmine 은 가장 유명한 라이브러리이며, 종종 테스팅 프레임워크로 언급되기도 한다. 둘의 API 들은 아주 유사하며 행동에 대해 기술하거나, assertion 을 사용하는 방식으로 테스트할 수 있다.

Mocha 는 실제로 내장된 assertion 라이브러리를 갖고 있지는 않으며, 많은 개발자들은 Chai 를 함께 사용한다. Chai 의 assertion 문법은 비슷하다.

테스트를 수행하기 위해, Mocha 는 명령형 유틸(command-line utility)을 제공하지만 Jasmine 은 제공하지 않는다. 많은 개발자들은 Jasmine 과 Mocha 스타일로 작성된 테스트를 수행하기 위해 Karma 를 사용한다.

이것만으로도 유닛 테스트는 잘 동작하지만, JavaScript 기반의 통합 테스트를 하기 위해서는 몇 개의 툴이 더 필요하다. 프론트엔드라는 관점에서 보면, 통합 테스트는 가끔 브라우저에서 어떻게 렌더링 되는지, 어떻게 페이지가 로드되는지, 사용자 반응을 어떻게 처리하는지, 결과는 잘 체크하는지 등을 수행해야 한다.

Selenium 은 이런 테스트에서 사용되는 웹 드라이버이다. 브라우저 드라이버로서 Selenium 을 사용할 수 있으며 Selenium 이 브라우저를 실행하게 할 수 있다. PhantomJS 는 일반적으로 이야기 하는 headless browser (GUI 없이 동작하기 때문에) 이며 테스팅에 종종 사용된다. GUI 를 필요로 하지 않기 때문에 자동화된 테스트를 수행하는 데에 효율적이다. 어쩌면 Sinon 이 도움이 될 수도 있다. Sinon 은 가짜 서버를 구성하며 테스트의 목적에 맞는 AJAX 응답을 돌려줄 수 있다.

지속적인 통합 테스트(CI) 를 위한 환경으로 Jenkins 나 Travis 를 구성할 수도 있다.

JavaScript 테스팅 툴은 수많은 종류가 있다. 새 프로젝트에서 나는 일반적으로 Karma 와 Jasmin, PhantomJS 를 선택하지만 Mocha + Chai 도 좋은 선택이다.

출처: http://han41858.tistory.com/5
