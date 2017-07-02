# Environment

리액트 개발환경을 셋팅하는 데는 두가지 방법이있습니다.
: [create-react-app](https://github.com/facebookincubator/create-react-app) 과 [webpack](https://webpack.js.org/) 입니다.
두 옵션 다 node.js의 패키지 매니저인 npm을 기반으로 합니다. 만약 익숙하지 않다면 npm을 별도로 다루겠습니다.
만약 당신이 지금 환경 셋팅을 스킵하고 싶다면 자유롭게 [Modern JavaScript](http://www.react.express/modern_javascript) 이나 [React API](http://www.react.express/react_api) 으로 넘어가세요. 이 부분들은 embedded React editor를 사용하기 때문에 예제 실행에 있어 로컬 환경설정이 필요하지 않습니다.

# Create React App
페이스북은 create-react-app이라는 커멘드라인 유틸리티를 제공했습니다. 이것은 자동적으로 프로젝트를 알맞은 디폴트 프로젝트 구조와 특징으로 리액트 프로젝트를 설정해 줍니다. 
당신이 스택을 더 잘 이해하면 이 옵션보다 훨씬 빨리 성장할 수 있습니다. 운이좋게도 create-react-app은 당신의 앱을 export 할 수 있는 eject 옵션을 제공합니다. 그러니 당신은 여기에 갇혀있지 않아도 됩니다.
다음 섹션으로 넘어가봅시다. [Quick Start](http://www.react.express/quick_start)

# Webpack
Webpack은 당신의 client-side 코드(JavaScript, css, etc)를 하나의 JavaScript file로 묶어줍니다. Webpack은 당신이 개발하거나 프로덕션하는 동안 리액트 앱을 bundle하는 가장 흔한 방식이 될겁니다.
만약 create-react-app 보다 당신이 좀더 유연하거나 강력함을 원한다면 당신은 Webpack이나 Babel 플러그인을 배워야만 합니다. (브라우저 호환을 위한 ES2015/JSX 코드를 컴파일 하기위해서 말입니다.)
다음 섹션에서는 create-react-app를 사용하여 React 앱을 작성하거나 Webpack을 사용하여 처음부터 React 앱을 빌드하는 데 필요한 도구에 대해 설명합니다.
