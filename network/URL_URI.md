# URL 과 URI
서버 리소스 이름은 통합 자원 식별자(Uniform Resource Identifier) 혹은 URI 로 불린다.
URI는 인터넷의 우편물 주소 같은 것으로, 정보 리소스를 고유하게 식별하고 위치를 지정할 수 있다.

URI에는 두가지가 있는데, URL 과 URN이다.

## 1) URL (Uniform Resource Location)
통합 자원 지시자는 리소스 식별자의 가장 흔한 형태로, 특정 서버의 한 리소스에 대한 구체적인 위치를 서술한다.
URL은 리소스가 정확히 어디에 있고 어떻게 접근할 수 있는지 분명히 알려준다.

### 1-1) URL의 표준 포맷
* URL의 첫 번째 부분은 스킴(scheme)이라고 불리는데, 리소스에 접근하기 위해 사용되는 프로토콜을 서술한다. 보통 HTTP 프로토콜(http://)이다.
* 두 번째 부분은 서버의 인터넷 주소를 제공한다.  (예: www.google.com).
* 마지막은 웹 서버의 리소스를 가리킨다. (예: /images/flight.png).

오늘날 대부분의 URI는 URL이다.

## 2) URN (Uniform Resouce Name)
URN은 콘텐츠를 이루는 한 리소스에 대해, 그 리스소의 위치에 영향 받지 않는 유일무이한 이름 역할을 한다.
리소스의 위치와 독립적으로 리소스를 여기저기로 옮기더라도 문제없이 동작한다. 아이디와 같은 느낌으로 이해하면 될 것 같다. 

URN 은 여전히 실험 중인 상태고, 아직 널리 채택되지 않았다.



---------
### 수정 전
“Uniform Resource Locator 의 약자인데 말 그대로 정형화 된 리소스 위치표시 라는 뜻이지.”

외국 사이트들의 트랜드를 봤을 때
요즘은 URL보다는 URI라는 용어를 사용하는 것을 알 수 있다.

우선
URL은 Uniform Resource Locator
URI는 Uniform Resource Identifier
이다.

그냥 단어의 뜻대로 해석하자면 예전에는 URL이 가리키는게 파일리소스 였는데
요즘은 Rewrite 등의 Apache, IIS, Tomcat 핸들러 때문에 자원 이라고 부른다.

즉 웹사이트 주소가 (http://test.com/adultdisease/diabetes) 라고 했을 때
요청하는 주소가 파일이라기 보다는 구분자로 보는 것이다.
실제로 해당 웹사이트의 adultdisease/diabetes 라는 파일은 없다.

요약하자면 URL 은 다음과 같다.

http://test.com/work/sample.pdf

test.com 서버에서 work 폴더안의 sample.pdf 를 요청하는 URL.

URI(통합 자원 식별자) 의 예는 다음과 같다.

1) rewrite 기술을 사용하여 만든 의미있는 식별자
http://test.com/company/location

[출처](https://blog.lael.be/post/61)
