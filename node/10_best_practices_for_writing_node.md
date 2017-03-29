# 10 Best Practices for Writing Node.js REST APIs
## 1 ) Use HTTP Methods & API Routes
당신이 사용자를 생성하고, 업데이트하고 데이터를 가져오고 유저데이터를 삭제한다고 해보자. 이러한 경우 http는 이미 적절한 도구를 가지고있다. 
__POST__ ,__PUT__, __GET__, __PATCH__ or __DELETE__

가장 좋은 방법은 API 경로가 항상 명사를 리소스 식별자로 사용해야한다는 것 입니다.

routes | 설명
-------|-------
POST /user or PUT /user:/id | 유저 생성
GET /user | 유저들의 데이터 가져오기
GET /user/:id |  특정유저 데이터 가져오기
PATCH /user/:id | 유저의 데이터 수정
DELETE /user/:id | 유저 삭제

##2)  Use HTTP Status Codes Correctly
요청을 처리하는 중에 문제가 발생하면 응답의 올바른 상태 코드를 설정해야합니다.

status code | 설명
------------|-----
2xx | 성공시
3xx | 자원이 이동 된 경우
4xx | 존재하지 않는 자원을 요청하는 것처럼 클라이언트 오류로 인해 요청을 수행 할 수 없는 경우
5xx | API 측 에서 문제가 발생시

##3) Use HTTP headers to Send Metadata
보내려는 페이로드에 대한 메타 데이터를 첨부하려면 HTTP 헤더를 사용하십시오. 예를 들면
* pagination
* rate limiting
* authentication
이와 같은 정보들이외에 HTTP headers의 표준을 찾아보고 싶다면, [here](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields) 확인해보세요.

헤더에 사용자 지정 메타 데이터를 설정해야하는 경우 X라는 접두사를 붙이는 것이 좋습니다. 예를 들어, CSRF 토큰을 사용하는 경우 CSRF 토큰을 명명하는 일반적인 (그러나 비표준적인) 방법이었습니다 X-Csrf-Token. 그러나 RFC 6648에서는 더 이상 사용되지 않습니다. 
새로운 API는 다른 응용 프로그램과 충돌 할 수있는 헤더 이름을 사용하지 않도록 최선을 다해야합니다. 예를 들어, OpenStack은 헤더에 OpenStack다음 접두어를 붙입니다 .

``` shell
OpenStack-Identity-Account-ID 
OpenStack-Networking-Host-Name 
OpenStack-Object-Storage-Policy
```

HTTP 표준은 헤더의 크기 제한을 정의하지 않습니다. 그러나 Node.js (이 글을 쓰는 시점에서)는 실질적인 이유로 헤더 객체에 80KB 크기 제한을 부과합니다.

"HTTP 헤더 (상태 표시 줄 포함)의 전체 크기가 초과되지 않게 HTTP_MAX_HEADER_SIZE하십시오. 이 검사는 embedder가 버퍼링을 계속하는 끝이없는 헤더를 공격자가 제공하는 서비스 거부 공격으로부터 embedder를 보호하기위한 것입니다. "

##4 ) Pick the right framework for your Node.js REST API
### 익스프레스, 코아 또는 하피
Express , Koa 및 Hapi 는 브라우저 응용 프로그램을 만드는 데 사용할 수 있으므로 템플릿 기능과 렌더링 기능을 지원합니다. 응용 프로그램이 사용자 측면을 제공해야하는 경우에는 응용 프로그램을 사용하는 것이 좋습니다.

### Restify
반면 Restify는 REST 서비스를구축하도록 도와주는 것에 초점을 맞춥니다. 유지 보수가 가능하고 관찰 가능한 "엄격한"API 서비스를 구축 할 수 있도록 지원합니다. Restify는 모든 핸들러에 대한 자동 [DTrace](http://dtrace.org/blogs/about/)도 해줍니다.
Restify는 npm 또는 Netflix 와 같은 주요 응용 프로그램에서 프로덕션에 사용됩니다 .

##5) Black-Box Test your Node.js REST APIs
REST API를 테스트하는 가장 좋은 방법 중 하나는 블랙 박스로 취급하는 것입니다. 블랙 박스 테스트는 내부 구조 나 작동에 대한 지식없이 애플리케이션의 기능을 검사하는 방법을 테스트하는 방법입니다. 

블랙 박스 테스트 Node.js를 REST API를 사용하여 당신을 도울 수있는 모듈 중 하나는 [supertest](https://www.npmjs.com/package/supertest) 입니다.
테스트 러너 모카 를 사용하여 사용자를 반환했는지 확인하는 간단한 테스트 케이스 는 다음과 같이 구현할 수 있습니다.

``` javascript
const request = require('supertest')

describe('GET /user/:id', function() {
		it('returns a user', function() {
				// newer mocha versions accepts promises as well
				return request(app) 
				.get('/user') 
				.set('Accept', 'application/json') 
				.expect(200, {
id: '1', 
name: 'John Math' 
}, done);
				}); 
		});
```

다음과 같은 질문을 할 수 있습니다. REST API를 제공하는 데이터베이스에 데이터가 어떻게 채워지나요?

일반적으로 가능한 한 시스템 상태에 대한 가정이 거의없는 방식으로 테스트를 작성하는 것이 좋습니다. 그럼에도 불구하고 어떤 시나리오에서는 시스템 상태가 정확히 무엇인지 파악해야 할 때 현장에서 자신을 찾을 수 있으므로 assertion을 만들어 더 높은 테스트 커버리지를 얻을 수 있습니다.
필요에 따라 다음 방법 중 하나로 데이터베이스에 테스트 데이터를 채울 수 있습니다.

	1) 알려진 프로덕션 데이터의 하위 집합에 대해 블랙 박스 테스트 시나리오를 실행하고,
	2) 테스트 케이스가 실행되기 전에 조작 된 데이터로 데이터베이스를 채우십시오.

물론 블랙 박스 테스트가 단위 테스트를 할 필요가 없다는 것을 의미하는 것은 아니며, 여전히 API 용 [단위 테스트](https://blog.risingstack.com/node-hero-node-js-unit-testing-tutorial/) 를 작성 해야합니다.

##6 ) Do JWT-Based, Stateless Authentication
REST API의 상태가 유지되어야하므로 인증 계층도 상태가 유지됩니다. 이를 위해 JWT (JSON Web Token) 가 이상적입니다.
JWT는 세 부분으로 구성됩니다.
	1) 헤더 토큰 유형 및 해시 알고리즘을 포함
	2) 소유권 주장을 포함하는 페이로드
	3) 서명 (JWT는 페이로드를 암호화하지 않고 서명 만합니다 !)

JWT 기반 인증을 애플리케이션에 추가하는 것은 매우 간단합니다

``` javascript
const koa = require('koa') 
	const jwt = require('koa-jwt') 
const app = koa() 
	app.use(jwt({ 
secret: 'very-secret' 
})); 
// Protected middleware 
app.use(function *(){ 
		// content of the token will be available on this.state.user          
		this.body = {
secret: '42' 
} 
});
```
그 후에 API 엔드 포인트는 JWT로 보호됩니다. 보호 된 엔드 포인트에 액세스하려면 Authorization헤더 필드에 토큰을 제공해야 합니다.

JWT 모듈은 어떤 데이터베이스 계층에도 의존하지 않는다는 것을 눈치 채면됩니다. 이는 모든 JWT 토큰이 독자적으로 검증 될 수 있고 수명 값을 포함 할 수 있기 때문에 그렇습니다.
또한 HTTPS를 사용하는 보안 연결을 통해서만 모든 API 끝점에 액세스 할 수 있도록해야합니다.

##7 ) Use Conditional Requests
조건부 요청은 특정 HTTP 헤더에 따라 다르게 실행되는 HTTP 요청입니다. 헤더 조건을 충족한다면 다른 방식으로 실행되도록 하는 헤더를 전제 조건으로 생각할 수 있습니다. 
이 헤더는 서버에 저장된 리소스 버전이 동일한 리소스의 특정 버전과 일치하는지 확인하려고 시도합니다. 이러한 이유 때문에 다음 헤더가 될 수 있습니다.

* 마지막 수정의 타임 스탬프,
* 또는 각 버전마다 다른 엔티티 태그가 있습니다.

헤더 종류는 다음과 같습니다.

header | 설명
-------|------
Last-Modified | 자원이 마지막으로 수정 된시기를 나타 내기 위해
Etag | 엔터티 태그를 나타 내기 위해
If-Modified-Since | Last-Modified헤더 와 함께 사용
If-None-Match | Etag헤더 와 함께 사용

예를 들어 한 클라이언트가 이전 버전의 doc리소스를 가지고 있지 않다면 If-Modified-Since 나 If-None-Match header 는 리소스가 보내졌을 때 적용되지 않습니다. 
그런 다음 서버는 헤더 Etag와 Last-Modified헤더가 올바르게 설정되어 응답 합니다.

만약 클라이언트가 If-Modified-Since과 If-None-Match header를 설정할 수 있



