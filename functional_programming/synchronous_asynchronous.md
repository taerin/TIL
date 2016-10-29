#동기(synchronous)와 비동기(asynchronous)
	동기와 비동기는 blocking 과 nonblocking 과는 다릅니다.
	blocking / nonblocking 은 요청이 실행되고 완료될 때 까지 모든일을 중단한 상태로 대기해야 하는 것입니다.
	동기/ 비동기는 요청과 그 결과가 동시에 잉러나지 않을 것이라는 약속입니다.
	즉 비동기는 결과가 언제 도착할 지 모른다는 데서 차이가 있습니다.


### 동기와 비동기/  blocking 과 nonblocking
1) 비동기(Asynchronous: 동시에 일어나지 않는, 非同期: 같은 시기가 아닌)
	비동기란 말 그대로 동시에 일어나지 않는다는 의미입니다.
	요청과 그 결과가 동시에 일어나지 않을 것이라는 약속입니다.
	즉, 요청한 그 결과가 그 자리에서 바로 주어지는 것이 아니라 이따가 준다는 약속이다.

2) 동기 (synchronous: 동시에 일어나는, 同期: 같은 시기)
	동기란 ㄷ동시에 일어난다는 말입니다.
	즉 요청한 결과가 요청과 동시에 돌려준다는 약속입니다.
	시간이 얼마나 걸리든지 상관없으며, 그 자리에서 결과를 주겠다는 약속입니다.

3) 블로킹 (blocking)
	말 그대로 작업이 중단된다는 의미로 요청이 발생하고 완료될 때 까지 모든 일을 중단한 상태로 대기해야 하는 것이 블로킹 방식이라고 합니다.

4) 논블로킹 (nonblocking)
	말 그대로 작업이 중단되지 않는다는 의미입니다.
	논 블로킹 방식은 아무래도 통신이 완료될 때 까지 기다리지 않고 다른 작업을 수행할 수 있으므로 경우에 따라 효율이나 반응속도가 더 뛰어나지만
	설계가 좀더 복잡해지는 단점이 있습니다.

### 결과 반환과 에러처리
	동기 함수에서는 결과는 return value 로서 처리하고
	에러는 return value / argument / 예외를 던짐 이 세가지 방법으로서 처리합니다.
	하지만 비동기에서는 바로 결과를 반환하지 않으니

``` javascript
err = foo();
if (err){
	// 에러처리
}
```

	위와 같이 return value를 사용해서 에러를 처리할 수 없습니다.
	그래서 비동기는 보통

``` javascript
foo(arg,function(err){

if (err){
// 에러처리
}
});
```
	위와 같은 코드형식으로 에러를 처리합니다.
	하지만 연산이 많을 경우 callback hell에 쉽게 인도될 수 있습니다. 이는 Flow control이 어려운 문제점이 있습니다.

	Promise나 Future(c++)는 결과를 객체로 반환해줍니다.
	그래서 promise나 future가 에러를 리턴한다면 이는 catch로 가서 적절한 에러처리를 하고
	만약 연산이 성공했다면 then으로 처리 할 수 있습니다. 이는 에러처리 로직과 연산성공의 로직을 분리 할 수 있다는 점에서 
	큰 이점이 있습니다.