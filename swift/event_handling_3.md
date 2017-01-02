# Cocoa Framework 에서 이벤트를 처리하는 방법 3가지

## 1. Target-Action: Selector를 이용하는 방법
	* Handler 기반의 이벤트 처리방식
	* UIButton 에서 사용
	* NotificationCenter 에서 사용
	* 범용 Selector를 사용해야함
	* 문제점 : ARC(Auto Referencing Counting) 과 사용할 경우 레퍼런스 카운팅을 제대로 적용할 수 없는 경우가 발생할 수 있다.
	* 사라질 가능성도 있다. 왜냐하면 ARC에 위배되기 때문이다.	

``` swift
class Button: NSObject {
	var target: AnyObject?
	var action: Selector?

	func click() {
        _ = target?.perform(action) // ARC에 도움이 되지않는 Unmanaged 타입을 리턴하기때문에 _로 받아줘야 한다.
	}
    
    func add(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
    
}

class Dialog: NSObject {
	func close() {
		print("Dialog close")
	}
}

let dialog = Dialog()
let button = Button()

var a = #selector(Dialog.close)

button.add(dialog, action: a)
button.click()
```

## 2. Delegate
	* 인터페이스 기반의 이벤트 처리방식
	* 어디로부터 이벤트가 발생하였는지 정보가 반드시 필요
	* 문제점 : 프로토콜을 준수해야한다. -> 꼭 구현할 필요없는 func에는 optional을 이용하여 해결 가능

``` swift
protocol ButtonDelegate: class {
    func onClick(_ sender: AnyObject) // sender를 꼭 지정해야한다.
}

class Button: NSObject {
    weak var delegate: ButtonDelegate?
    
    func click() {
        delegate?.onClick(self)
    }
}

class Dialog: NSObject, ButtonDelegate {
    func onClick(_ sender: AnyObject) {
        close()
    } // 프로토콜 준수
    
    func close() {
        print("close")
    }
}

let button = Button()
let dialog = Dialog()

button.delegate = dialog
button.click()
```

## 3. Closure
	* UIAlertController가 사용
	* 함수형언어의 특징

``` swift
class Button: NSObject {
    var handler: (()->Void)?

    func click() {
        self.handler?()
    }
    
    func setHandler(handler: @escaping (()->Void)) {
        self.handler = handler
    }
}

class Dialog: NSObject {
    func close() {
        print("close")
    }
}

let dialog = Dialog()
let button = Button()

button.setHandler {
    dialog.close()
}

button.click()
``` 
