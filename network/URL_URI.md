# URL 과 URI
“Uniform Resource Locator 의 약자인데 말 그대로 정형화 된 리소스 위치표시 라는 뜻이지.”


“그리고 면접관이 실무자가 아니었나본데 요즘은 URL이라는 용어를 잘 안쓰고 URI라고 써”

 

외국 사이트들의 트랜드를 봤을 때

요즘은 URL보다는 URI라는 용어를 사용하는 것을 알 수 있다.

 

우선

URL은 Uniform Resource Locator

URI는 Uniform Resource Identifier

이다.

 

그냥 단어의 뜻대로 해석하자면 예전에는 URL이 가리키는게 파일리소스 였는데

요즘은 Rewrite 등의 Apache , IIS, Tomcat 핸들러 때문에 자원 이라고 부른다.

 

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


