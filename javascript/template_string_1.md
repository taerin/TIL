# Template String (템플릿 문자열)

템플릿 문자열(template string)은 일반 문자열과 비슷해보이지만, ' 나 " 같은 따옴표가 아닌 백틱(backtick)문자 ` 를 사용한다.
간단하게 사용할 경우 템플릿 문자열은 일반 문자열과 같다.

템플릿 문자열은 JavaScript에 간단한 문자열 채워넣기(string interpolation)기능이 가능해졌다. 템플릿 문자열은 JavaScript 값(value)을 문자열에 끼워방법이다.

``` javascript
function foo(user, action){
	if(!user.hasPrivilege(action)){
		throw new Error(`User ${user.name} is authorized todo ${action}.`);
	}
}
```

이 예제에서 ${user.name} 과 ${action}을 템플릿 대입문(template substitution) 이라고 한다
user.name 값과 action값을 결과 문자열에 대입한다.
여기까지는 + 연산자 보다 약간 더 좋은 문법처럼 보인다.

* 템플릿 대입문에는 어떤 JavaScript 표현도 올 수 있다. 함수 호출 구문, 수식 구문 등 모든 구문이 허용된다.
	-> 템플릿 문자열을 다른 템플릿 문자열 안에 포함시키는 것도 가능하다. 이것을 __템플릿 인셉션__이라고 부른다.

* 만약 템플릿 대입문에 오는 값이 문자열이 아니라면 그 값은 통상적인 규칙에 따라 문자열로 변환 될 것이다. 위 예제 코드에서 만약 action이 객체라면 해당 객체의 .toString() 메소드가 호풀 될것이다.

* 템플릿 문자열 안에서 백틱 문자는 백슬래쉬(\) 문자를 이용한 이스케이프(escape) 표현을 사용한다. `\``라고 표현하는것은 "`"라고 표현하는 것과 동일하다.

* 템플릿 문자열 안에서 ${ 2개 문자를 사용해야 한다면 2개 중 한 문자를 백슬래쉬 문자로 이스케이프시켜 표현한다. `write \${ or ${`.

* 일반적인 문자열과 달리 템플릿 문자열은 여러 줄에 걸쳐 표현할 수 있다.
``` javascript
$("#warning").html(`
  <h1>Watch out!</h1>
  <p>Unauthorized hockeying can result in penalties
  of up to ${maxPenalty} minutes.</p>
`);
```

줄바꿈과 들여쓰기 등 템플릿 문자열 속의 모든 화이트 스페이스들은 그대로 포함된다.
