# await 

### Thou Shalt Be Async (비동기 하지 말라) callback hell에 빠질테니!

``` javascript
function handler(request, response) {
	User.get(request.user, function(err, user) {
			if (err) {
			response.send(err);
			} else {
			Notebook.get(user.notebook, function(err, notebook) {
				if (err) {
				return response.send(err);
				} else  {
				doSomethingAsync(user, notebook, function(err, result) {
					if (err) {
					response.send(err)
					} else {
					response.send(result);
					}
					});
				}
				});
			}
			})
}
```

위 코드와 같은 콜백지옥에 빠지는것에 대처하기위한 많은 의견들이 있지만 이 논쟁에서 명백한 승자는 __Promise__다.
당신은 콜백을 then function으로 전달하기 때문에 그들은 때때로 thennables라고 불린다.

``` javascript
require("request")
	.get("http://www.google.com", function(err, response) {
		console.log(response.body)
	})
```

``` javascript
require("request-promise")
    .get("http://www.google.com")
    .then(function(response) {
       console.log(response);
    })
```
아래코드는 Promise버전이다. 위아래 코드는 비슷해보이지만 주된 차이점은 callback을 then으로 전달한다는 것이다.

``` javascript
require("request")
.get("http://www.google.com", function(err, response) {
		if (err) {
		console.error(err);
		} else {
		require("fs")
		.writeFile("google.html", response.body, function(err) {
			if (err) {
				console.error(err);
			} else {
				console.log("wrote file");
			}
			});
		}
		});
```

이는 더 복잡한 callback 코드이다. 당신은 에러핸들링의 오버헤드와 nestingproblem의 문제를 겪을것이다.

``` javascript
require("request-promise").get("http://www.google.com")
	.then(function(response) {
		return require("fs-promise").writeFile("google.html", response);
		})
	.then(function() {
		console.log("wrote file");
		})
	.catch(function(err) {
		console.log(err);
		})
```
이는 다시 Promise 코드이다. nesting problem 대신 직관적인 linear하게 진행되는 이벤트들을 볼 수 있따. 데이터를 요청하여 얻고 파일에 쓰고 로그한다 (코드를 읽기도 쉽다). 
그리고 에러를 기본적인 자바스크립트의 동기함수들처럼 처리할 수 있다.

``` javascript
function(request, response) {
	var user, notebook;

	User.get(request.user)
		.then(function(aUser) {
				user = aUser;
				return Notebook.get(user.notebook);
				})
		.then(function(aNotebook) {
			notebook = aNotebook;
			return doSomethingAsync(user, notebook);
			})
		.then(function(result) {
			response.send(result)
			})
		.catch(function(err) {
			response.send(err)
			})
}
```
위 코드는 프로미스 버전의 콜백헬이다. 이것은 꽤 명확해보이지만 여전히 필요없는 syntax이 필요하고 불편한 제 2의 해결책일뿐이다. 

``` javascript
async function(request, response) {
	try {
		var user = await User.get(request.user);
		var notebook = await Notebook.get(user.notebook);
		response.send(await doSomethingAsync(user, notebook));
	} catch(err) {
		response.send(err);
	}
}
```
드디어!! await 베이스의 코드다. 위 코드는 불필요한 함수가 없고 명확한 linear 스타일의 코드와 명백한 비동기의 포인트들! 그리고 원시적인 try/catch까지 사용하고 있다.
어떻게 이것이 동작하는지에 대한 가장 간단한 설명은 await는 Promise를 취하고 이용가능한 밸류를 기다리고 그 밸류를 리턴한다는 것이다.

``` javascript
require("request-promise").get("http://www.google.com");
```
위 코드는 promise를 리턴하겠지만
``` javascript
await require("request-promise").get("http://www.google.com");
```
위 코드는 promise 의 value값을 리턴할것이다. 

``` javascript
await "Hello!"
```
물론 await를 promise없이 사용할 수도 있다.

```javascript
function x(aPromise) {
	    await aPromise
}
```
위 코드는 syntax 에러를 낼 텐데 왜냐하면 당신은 오직 __await__를 특별한 방법으로 선언된 함수내부에서만 사용할 수 있다.

``` javascript
async function x(aPromise) {
	    await aPromise
}
``` 
여기 정확한 버전의 심플한 함수가 있다. 함수 선언앞에 단지 async키워드를 붙였다. 당신은 top 레벨 await를 사용할수 없다.
async는 무엇을 할까? async는 프로미스에서 리턴되는 value를 wrap하게된다.모든것은 이 간단한 syntax안에 숨겨져 있다.

### "await" is not threads
쓰레드를 가진 언어들에서 동시실행성은 너의 컨트롤 밖의 영역이다.
당신의 쓰레드는 언제든 interrupt될 수 있고 그래서 동기화 전략과 lock 기능이 필요하다.
하지만 자바스크립트 모델은 변하지 않았다. 이것은 여전히 싱글스레드이다.
코드는 오직 당신의 명백한 명령인 await에 의해서만 interrupt된다.

``` javascript
var RP = require("request-promise");
var sites = await Promise.all([
    RP("http://www.google.com"),
    RP("http://www.apple.com"),
    RP("http://www.yahoo.com") 
    ])
```

await는 명백한 컨트롤을 할 수 있게한다. 당신은 이것을 Promise와 같은 강력한 promise 유틸리티와 함께 결합할 수 도 있다. 
위 코드는 모든 프로미스가 끝나길 기다리고, 그자체가 끝나기를 기다리는 코드다 강력한 코드다. 하지만 여전히 비동기코드를 이해하기는 쉽다!!


await 훌륭하네요...
출처: http://rossboucher.com/await/#/
