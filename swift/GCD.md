# GCD(Grand Central Dispatch) API

## GDC 란?
GCD(Grand Central Dispatch)는 iOS 4 이후 버전에서 멀티스레드 프로그래밍을 쉽게 사용할 수 있도록 도와주기 위해 새롭게 소개된 기능이다
디스패치 큐(Dispatch Queue)는 실행할 작업을 저장하는 큐이다. 위의 dispatch_async 함수를 사용하여 할 작업들을 디스패치 큐에 추가할 수 있다. 
큐에 등록시 다음 실행방식 하나를 지정할 수 있다.

### 1) 동기화
	* 큐에 처리를 등록한 스레드가 등록한 처리가 완료될때까지 대기
	* GCD 메소드는 sync~

### 2) 비동기
	* 큐에 처리를 등록한 스레득 등록한 처리가 완료될 때 까지 기다리지 않음
	* GCD 메소드는 async~

## 큐 종류
### Serial
처리를 직렬로 실행한다. 큐의 이전작업이 완료된 후, 다음작업을 시작한다. 한번에 수행할 작업은 하나뿐이다.
### Concurrent
처리를 병렬로 실행한다. 처리가 대기열에서 제거되는 순서는 FIFO이지만 한번에 여러작업을 실행하고 처리가 완료되는 차례도 제멋대로이다.

## 메인큐(Main queue)
큐 중에서도 앱 시작시 시스템에 의해 자동으로 만들어지는 메인큐라는 별도의 큐가 있다. 이는 대기열에서 등록된 작업은 메인스레드에서 직렬로 실행된다. 이는 별도의 Serial queue라고 말할 수 있다.

## 하위스레드에 무거운 처리를 하고나면 메인스레드로 되돌리기
iOS앱은 부하가 높은 작업과 언제 종료될지 모르는 통신등의 처리는 기본적으로 메인스레드로 하지 않는다.(예: 사진 다운로드 등)  메인스레드에서 이를 처리하면 앱이 무거워져 사용자의 작업을 방해하게 된다. 그래서 보통은 하위스레드에서 무거운 처리를 하고 끝나면 메인스레드로 되돌리는 패턴이다.

## 직접 큐 생성

``` swift
DispatchQueue(label: "kr.swifter.app.queue").async {
	self.doSomething()

	DispatchQueue.main.async {
		self.doSomething()
	}
}
```

위 예제는 직접 큐를 생성하고 임의의 처리를 하위스레드에서 실행이 끝나면 메인스레드로 돌리는 예로 레이블명을 지정하여 큐를  생성하고 이때 생성되는 것은 Serial queue인데 Concurrent queue를 생성하려면 아래와 같이 옵션을 지정한다.

``` swift
DispatchQueue(label: "kr.swifter.app.queue", attributes: .concurrent)
```

## 시스템에서 준비된 큐 사용

``` swift
DispatchQueue.global(qos: .default).async {
	self.doSomething()
}
```

DispatchQueue.global에서 얻을 수 있는 큐는 시스템에서 준비된 Concurrent queue이다. 인수로 지정한 qos(Quality of service)는 우선순위를 결정해준다. 여기서는 default로 지정했지만 우선순위가 높은 것부터 순서대로 아래와 같이 제공되고 있다.

* userInteractive
* userInitiated
* default
* utility
* background
* unspecified

## 지정한 시간후 처리 실행
아래는 10초후 어떤 작업을 실행하는 예로 DispatchTime.now()에서 얻은 현재 시간에서 .seconds(10)을 통해 10초를 추가했다. 
seconds는 DispatchTimeInterval이라는 enum이며 다른 값으로는 miliseconds(밀리초), microseconds(마이크로초), nanoseconds(나노초)등으로 지정할 수 있다.

``` swift
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(10)) {
	   self.doSomething()
}
```

## 모든 큐 처리가 끝나면 특정작업을 실행
우선 그룹과 큐를 생성하고 큐에 처리를 등록할 때 그룹을 지정해서 큐와 그룹을 묶는다. 모든 큐 처리가 완료되면 메인스레드에서 처리된다.

``` swift 
let g = DispatchGroup()
	let q1 = DispatchQueue(label: "kr.swifter.app.queue1")
	let q2 = DispatchQueue(label: "kr.swifter.app.queue2")
	let q3 = DispatchQueue(label: "kr.swifter.app.queue3")
	 
	q1.async(group: g) {
		   print("queue1 완료")
	}
q2.async(group: g) {
	   print("queue2 완료")
}
q3.async(group: g) {
	   print("queue3 완료")
}
 
g.notify(queue: DispatchQueue.main) {
	   print("전체 작업완료")
}
```

## DispatchWorkItem을 사용하여 작업실행
DispatchWorkItem은 작업을 캡슐화하는 클래스로 다음과 같이 큐 지정이 필수가 아니다. 이 경우 현재 컨텍스트(스레드)에서 처리된다.

``` swift 
let wi = DispatchWorkItem {
	self.doSomething()
}

wi.perform()
```

아래와 같이 큐를 지정할 수도 있다.

``` swift
q1.async(execute: wi)
```

이 DispatchWorkItem을 사용하면 처리 실행 perform()외에도 대기 wait() 및 취소 cancel()등 작업에 대한 제어를 세밀하게 할 수 있다. 그외 DisapatchWorkItemFlags 옵션도 있어 QoS에 대한 상세한 실행도 가능하다.
중요한 것은 Objective-C언어에서 싱글톤 패턴을 구현하는데 사용하던 dispatch_once는 Swift 3.0에서는 사용할 수 없게 되었다. 또한 dispatch_once_t도 사용할 수 없게 되었다는 것을 기억하자.

## Swift 3.0기반 싱글톤 패턴 구현
dispatch_once를 사용못하게 됨에 따라 Swift 3.0부터는 static let속성에서 제공된다. 이 말은 final에서 상속을 금지하고 이니셜라이저를 private하게 되어 자유롭게 인스턴스 생성을 금지하고 static let을 공개한 속성을 통해서만 유일한 인스턴스에 접근할 수 있다.

``` swift
final class ClassSample {
	static let sharedInstance = ClassSample()

	private init() {  
		// 초기화 작업
	}

}
```

[출처](https://swifter.kr/2016/10/22/swift-3-0%EA%B8%B0%EB%B0%98-gcd-%EA%B8%B0%EC%B4%88/)
