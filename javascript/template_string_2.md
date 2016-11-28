# 템플릿 문자열 2

## 백틱의 미래
### 템플릿 문자열이 하지 못하는 일

* 템플릿 문자열은 특수 문자들을 자동으로 이스케이프시켜 표현해주지 않습니다. 크로스-사이트 스크립팅(cross-site scripting) 공격을 피하려면, 신뢰할 수 없는 데이터에 대한 처리를 직접해주어야 합니다. 처리 방식은 일반 문자열을 처리할 때와 같은 방식입니다.
* 템플릿 문자열과 다국어 처리 라이브러리(internationalization library) (당신의 코드가 다양한 사용자들을 위해 다양한 언어를 말할 수 있도록 도와주는 라이브러리) 사이의 상호작용에 대해서는 분명히 정의된 것이 없습니다. 템플릿 문자열은 언어권별 숫자 포맷과 날짜 포맷을 알아서 처리해주지 않습니다. 복수형 처리는 말할 것도 없구요.
* 템플릿 문자열은 Mustache나 Nunjucks 같은 템플릿 라이브러리의 대체품이 아닙니다.템플릿 문자열은 루프문은 물론 조건문을 위한 문법을 갖고 있지 않습니다. 루프문은 예를 들어 배열로 HTML 테이블을 만들 때 사용합니다.

ES6는 템플릿 문자열의 쓰임새를 높이는 방법을 하나 더 제공합니다. 이 방법을 이용하면 JS 개발자들과 라이브러리 설계자들이 템플릿 문자열의 한계를 극복할 수 있습니다. __ 태그된 템플릿(tagged template)__이라고 불리는 방법입니다.

태그된 템플릿의 문법은 간단합니다. 태그된 템플릿은 단지 시작하는 백틱 앞에 태그(tag)를 하나 더 붙인 템플릿 문자열입니다. 우선 처음 볼 예제의 태그 이름을 SaferHTML로 합시다. 우리는 이 태그를 이용해서 앞에서 나열한 템플릿 문자열의 한계들 중 첫번째 한계를 극복할 것입니다. 특수 문자들을 자동으로 이스케이프시켜 표현하는 것 말입니다.

한가지 일러둘 것은 SaferHTML 태그는 ES6 표준 라이브러리가 제공하는 특별한 키워드가 아닙니다. 우리는 이제부터 SaferHTML 태그 키워드를 직접 구현할 것입니다.

``` javascript
var message =
  SaferHTML`<p>${bonk.sender} has sent you a bonk.</p>`;
```

여기서 사용된 SaferHTML 태그는 단순한 형태의 식별자입니다. 하지만 SaferHTML.escape 같은 속성 형태도 태그로 사용할 수 있습니다. 그리고 SaferHTML.escape({unicodeControlCharacters: false}) 같은 메소드 호출 형태도 태그로 사용할 수 있습니다. (정확히 말하자면, 모든 ES6 MemberExpression 또는 CallExpression을 태그로 사용할 수 있습니다.)

앞서 우리는 태그 없이 사용된 템플릿 문자열이 문자열을 조합하는 작업에 대한 약식 표기임을 보았습니다. 태그된 템플릿(tagged template)은 완전히 다른 작업에 대한 약식 표기입니다. 바로 함수 호출입니다.

위의 코드는 다음 코드와 완전히 동일합니다.

``` javascript
var message =  SaferHTML(templateData, bonk.sender);
```
여기서 templateData는 템플릿의 문자열 파트로 이루어진, 값을 변경할 수 없는 배열입니다. templateData 배열은 JS 엔진에 의해 만들어집니다. 이 예제에서 templateData 배열은 2개의 요소를 갖습니다. 태그된 템플릿(tagged template)이 대입문(substitution)에 의해 분리된 2개의 문자열 파트로 구성되기 때문입니다. 그래서 templateData 배열을 다르게 표현하면 
Object.freeze(["<p>", " has sent you a bonk.</p>"]와 같습니다.

(실제로는 templateData에 속성이 하나 더 존재합니다. 이번 글에서는 해당 속성을 사용하지 않지만 정보를 빠짐 없이 제공하기 위해 일러둡니다. 바로 templateData.raw 속성입니다. 이 속성도 태그된 템플릿의 모든 문자열 파트를 요소로 갖는 배열입니다. 하지만 이 배열 속의 문자열들은 우리가 소스 코드에서 보는 것처럼 이스케이프되어 있습니다. 즉 실제 줄바꿈 문자 대신 \n로 표현된 문자열을 담고 있습니다. 표준 태그인 String.raw가 이 raw 문자열을 이용합니다.)

SaferHTML 태그는 함수를 통해 문자열과 대입문을 무한히 다양하게 해석하는 수단으로 활용할 수 있습니다.

``` javascript
function SaferHTML(templateData) {
var s = templateData[0];
for (var i = 1; i < arguments.length; i++) {
	var arg = String(arguments[i]);

// 대입문의 특수 문자들을 이스케이프시켜 표현합니다.
	s += arg.replace(/&/g, "&amp;")
			.replace(/</g, "&lt;")
			.replace(/>/g, "&gt;");

// 템플릿의 특수 문자들은 이스케이프시키지 않습니다.
	s += templateData[i];
	}	
	return s;
}
```

이렇게 태그된 템플릿을 정의하면 SaferHTML`<p>${bonk.sender} has sent you a bonk.</p>`은 "<p>ES6&lt;3er has sent you a bonk.</p>" 처럼 전개될 것입니다. 이제 당신의 코드는 Hacker Steve <script>alert('xss');</script>처럼 위험한 이름을 갖는 사용자도 안전하게 처리할 수 있습니다.

``` javascript
i18n`Hello ${name}, you have ${amount}:c(CAD) in your bank account.`
// => Hallo Bob, Sie haben 1.234,56 $CA auf Ihrem Bankkonto.
```
이 예에서 name과 amount는 JavaScript 코드입니다. 하지만 코드 중에 이상하고 낯선 표현이 보입니다. :c(CAD) 입니다. 이것은 Jack이 템플릿의 문자열 파트에 끼워넣은 것입니다. JavaScript 코드는 당연히 JavaScript 엔진에 의해 처리됩니다. 문자열 파트는 Jack의 i18n 태그에 의해 처리됩니다. i18n 문서를 보면 :c(CAD) 표시가 캐나다 달러를 나타낸다는 것을 알 수 있습니다. 이 코드는 결과적으로 amount를 캐나다 달러로 표시합니다.

이것이 태그된 템플릿(tagged template)입니다.

템플릿 문자열은 Mustache나 Nunjucks의 대체품이 아닙니다. 템플릿 문자열에는 루프문이나 조건문을 위한 문법이 없습니다. 이제 우리는 이 제약을 어떻게 극복할지 알아볼 것입니다. 만약 JS가 이 기능을 제공하지 않는다면 이 기능을 제공하는 태그를 작성하면 됩니다.

``` javascript
// ES6 태그된 템플릿(tagged templates)을 기반으로 만든
// 순전히 샘플로 만들어본 템플릿 언어
var libraryHtml = hashTemplate`
  <ul>
	#for book in ${myBooks}
  <li><i>#{book.title}</i> by #{book.author}</li>
	#end
  </ul>
`;
```

유연성은 거기서 그치지 않습니다. 한가지 이러둘 것이 있습니다. 태그 함수의 인자는 문자열로 자동 변환되지 않습니다. 태그 함수의 인자로는 어떤 것이 와도 좋습니다. 리턴 값도 마찬가지입니다. 태그된 템플릿(tagged template) 자체가 문자열일 필요도 없습니다! 당신은 정규식(regular expression), DOM 트리, 이미지, 비동기 작업 전체를 대표하는 프라미스(promise), JS 데이터 구조체, GL 쉐이더(shader)… 등 어떤 것을 만들 때도 태그를 이용할 수 있습니다.

태그된 템플릿(tagged template)은 특정 분야를 위한 강력한 랭귀지를 만드는 일에 라이브러리 설계자들을 초대합니다. 이렇게 만든 랭귀지들은 전혀 JS처럼 보이지 않을 것입니다. 하지만 여전히 JS를 매끈하게 내장하고 있으며 JS의 다른 기능들과 지능적으로 연동됩니다. 거칠게 말해서, 저는 이런 개념을 다른 어떤 랭귀지에서도 본 적이 없습니다. 태그된 템플릿(tagged template)이 우리를 어디까지 데려갈지 모르겠습니다. 아주 흥미로운 가능성입니다.

## 언제부터 쓸 수 있나요?
서버에서는 io.js에서 ES6 템플릿 문자열을 지금 당장 쓸 수 있습니다.

브라우저에서는 Firefox 34+ 버전이 템플릿 문자열을 지원합니다. Firefox의 템플릿 문자열 기능은 지난 여름 Guptha Rajagopal이 인턴 프로젝트를 하면서 구현했습니다. Chrome 41+ 버전도 템플릿 문자열을 지원합니다. 하지만 IE와 Safari는 지원하지 않습니다. 만약 웹 상에서 템플릿 문자열을 쓰고 싶다면 현재로서는 Babel이나 Traceur를 사용하는 것이 좋을 것 같습니다. TypeScript에서도 템플릿 문자열을 지금 당장 사용할 수 있습니다!








