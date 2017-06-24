# HTTP 접근 제어 (CORS) 
처음 전송되는 리소스의 도메인과 다른 도메인으로부터 리소스가 요청될 경우 해당 리소스는 cross-origin HTTP 요청에 의해 요청됩니다. 예를 들어, http://domain-a.com으로부터 전송되는 HTML 페이지가 <img> src 속성을 통해 http://domain-b.com/image.jpg를 요청하는 경우가 있습니다. 오늘날 많은 웹 페이지들은 CSS 스타일시트, 이미지, 그리고 스크립트와 같은 리소스들을 각각의 출처로부터 읽어옵니다.

보안 상의 이유로, 브라우저들은 스크립트 내에서 초기화되는 cross-origin HTTP 요청을 제한합니다. 예를 들면, XMLHttpRequest는 same-origin 정책을 따르기에, XMLHttpRequest을 사용하는 웹 애플리케이션은 자신과 동일한 도메인으로 HTTP 요청을 보내는 것만 가능했습니다. 웹 애플리케이션을 개선시키기 위해, 개발자들은 브라우저 벤더사들에게 XMLHttpRequest가 cross-domain 요청을 할 수 있도록 요청했습니다

