# JSX
React를 사용하기 위해서 꼭 JSX를 사용해야하는 건 아니지만, JSX를 사용하게 되면, 속성을 가진 트리 구조로 정의를 할 수 있어, 개발을 보다 편하게 할 수 있습니다. 그리고 React의 많은 예제에서도 JSX를 사용하고 있습니다.
JSX라는 단어는 Javascript와 XML을 합침으로써 탄생하였으며, 기존 XML을 허용하기 위한 Javascript의 확장 문법입니다. React는 JSX를 지원함으로서, 개발자가 Javascript 내부에 마크업 코드를 직접 작성할 수 있게 하는데, JSX는 단순히 XML을 허용만 하는게 아니라, Javascript의 변수나 프로퍼티의 값의 바인딩에 대한 추가적인 기능도 제공합니다. 

사용 예는 아래와 같습니다.

``` javascript
//jsx가 없을 때
React.createElement('a', {href: 'https://facebook.github.io/react/'}, '안녕하세요!')
//jsx를 사용했을 때:
<a href="https://facebook.github.io/react/">안녕하세요!</a>
```

React는 컴포넌트가 관심을 분리하는데 있어서 디스플레이 로직(Display Logic)이나 템플릿보다 올바른 방법이라고 강하게 믿고 있습니다.
마크업과 마크업을 만들어내는 코드는 친밀하게 결합되어있고, 디스플레이 로직은 빈번하게 매우 복잡해지기 마련이고, 템플릿언어를 이용해 이것들을 통해 표현하는것은 매우 성가신 일이기 때문입니다.

이 문제를 해결하기 위해 사용자 인터페이스를 만드는 Javascript 코드로부터 HTML과 컴포넌트 트리들을 직접적으로 생성하는 것이 최고의 해결책이라는 것을 발견했고, 개발자로 하여금 HTML 문법을 이용해 아래와 같이 Javascript 객체를 만들게 합니다.

[출처](http://webframeworks.kr/getstarted/reactjs/)
