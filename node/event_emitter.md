# EventEmitter 
EventEmitter 클래스를 사용하여 특정 유형의 이벤트가 발생되면 호출될 하나 이상의 함수를 Listener를 등록할 수 있다.


``` javascript
const EventEmitter = require("events").EventEmitter;
const eeInstance = new EventEmitter();
```


EvnetEmitter의 필수 메소드는 아래와 같다.

method | desc
-------|------
on(event, listener) |  주어진 이벤트 유형(문자열)에 대해 새로운 listener 를 등록할 수 있다.
once(event, listener) | 첫 이벤트가 전달된 후 제거되는 새로운 listner를 등록할 수 있다.
emit(event, [arg1], [...]) | 새 이벤트를 생성하고 listener에게 전달할 추가적인 인자들을 지원한다.
removeListener(event, listener) | 지정된 이벤트 유형에 대한 listener를 제거한다.


위의 모든 메소드들은 체이닝을 지원한다.

