# for-of

처음 javascript는 아래와 같은 방법으로 배열을 루프로 순환했습니다.
``` javascript
for (var index = 0; index < myArray.length; index++) {
	  console.log(myArray[index]);
}
```

ES5 발표 이후에는 forEach 메소드를 사용할 수 있게 되었습니다.

```  javascript
myArray.forEach(function (value) {
	  console.log(value);
});
```

좀 더 간단한 방법이기는 하지만, 여기에는 사소한 단점이 있습니다. break 구문을 이용해서 루프를 중단하거나 return 구문을 이용해서 함수를 벗어날 수 없다는 점입니다.

### for-in 루프
``` javascript
for (var index in myArray) {    // 실제 상황에서는 사용하지 마세요
	  console.log(myArray[index]);
}
```
	* for-in 루프가 나쁜 이유

		1) 이 코드에서 index에 할당되는 값들은 "0", "1", "2"과 같은 문자열입니다. 숫자가 아닙니다. 분명 당신이 바라는 것은 문자열 연산 ("2" + 1 == "21")이 아닐 것이기 때문에, 이것은 아무리 봐도 불편한 방법입니다.
		2) 루프 구문이 배열 요소들만을 순회하지 않습니다. 대신 누군가에 의해 추가된 확장속성(expando)들도 순회합니다. 예를 들어, 당신이 다루는 배열이 myArray.name이라는 속성을 가지고 있다면, 이 루프는 배열 요소들 말고도 index == "name" 속성을 대상으로 한번 더 실행될 것입니다. 뿐만 아니라 배열의 프로토타입 체인(prototype chain)도 순회할 것입니다.
		3) 가장 당혹스러운 것은, 어떤 환경에서는 이 루프의 순회 순서가 무작위라는 점입니다.

for–in 구문은 일반 Object의 문자열 키(key)를 순회하기 위해 만들어진 문법입니다. Array를 다루는데는 그다지 유용하지 않습니다.

### 강력한 for-of 루프
현존하는 수백만개의 웹 사이트들이 for–in 구문을 사용하고 있기 때문에 for-in 이 갖는 여러가지 문제점에도 쉽게 for-in 구문을 고칠 수 없었을 것입니다.
그래서 ES6가 문제를 개선하기 위해 선택할 수 있던 유일한 방법은 새로운 종류의 문법을 추가하는 것 뿐이었습니다.

이것이 그 노력의 결과입니다.
``` javascript
for (var value of myArray) {
	  console.log(value);
}
```

	* for-of 루프가 훌륭한 이유
		1) 이 구문은 지금까지 있었던 배열 순회 방법들 중에서 문법적으로 가장 간결하고, 직접적입니다.
		2) 이 구문은 for–in 구문의 모든 단점들을 배제합니다.
		3) forEach() 구문과 달리, break, continue, 그리고 return 구문과 함께 사용할 수 있습니다.

for–in 루프 구문은 객체의 속성들을 순회하기 위한 구문입니다.
__for–of 루프 구문은 배열의 요소들, 즉 data를 순회하기 위한 구문입니다.__

### for-of 구문이 훌륭한 이유 두번째
for-of 구문을 지원하는 또다른 컬렉션(collection)들!

	* for–of 구문은 배열만을 위한 것이 아닙니다.
	for–of 구문은 배열과 비슷한 대부분의 객체들을 대상으로 사용할 수 있습니다. DOM NodeList 같은 객체들 말이죠.

	* for–of 구문은 문자열도 다룰 수 있습니다. 문자열을 유니코드 문자들로 이루어진 배열로 취급합니다.
``` javascript
	for (var chr of "") {
		  alert(chr);
	}
```

	* for–of 구문은 Map과 Set 객체도 대상으로 다룰 수 있습니다.
	(Map과 Set 객체는 ES6에 새로 추가된 객체들 입니다.)
	Set 객체는 중복을 제거하는데 좋습니다.
#### Set
``` javascript
// 단어들의 배열을 이용해서 set 객체를 생성합니다
var uniqueWords = new Set(words);
```
아래 코드는 Set 객체의 내용을 순회하는 코드입니다.
``` javascript
for (var word of uniqueWords) {
	  console.log(word);
}
```
#### Map
Map 객체는 약간 다릅니다. Map 객체 안의 데이터는 key-value 쌍으로 이루어집니다. 아마도 당신은 key와 value를 별도의 변수로 분해(destructuring) 하고 싶을 것입니다.

``` javascript
for (var [key, value] of phoneBookMap) {
	  console.log(key + "'s phone number is: " + value);
}
```
분해(destructuring) 역시 ES6에 새로 도입된 멋진 기능입니다!!

### 정리
for–of 구문은 일반 Object를 대상으로는 동작하지 않습니다. 만약 어떤 객체의 속성을 순회하고 싶다면 for–in 구문을 이용하거나 (for–in 구문이 존재하는 이유입니다), 내장된(built-in) Object.keys() 메소드를 사용합니다.

``` javascript
// 객체의 모든 속성을 콘솔에 출력합니다
for (var key of Object.keys(someObject)) {
	  console.log(key + ": " + someObject[key]);
}
```

