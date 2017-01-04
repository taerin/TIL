# 스위프트 시작하기

Cocoa의 IDE (Xcode 또는 AppCode)에서 새 프로젝트를 생성하면 IDE가 환경을 구성합니다. 앱 로직에 뛰어들어 즉시 흥미로운 것을 만들 수 있기 때문에 좋습니다.
그러나 많은 스타터는 앱의 시작 흐름에 대해 알지 못합니다. 앱이 어떻게 시작 되나요? AppDelegate는 실제로 무엇입니까?
xib 파일과 스토리보드는 어떻게 로드되고 화면에 표시됩니까?
IDE 개발자들의 큰 노력으로 이러한 것들을 스스로 설정할 필요가 거의 없습니다. 그러나 후드아래에서 일어난 일을 찾아내는 것은 언제나 가치가 있습니다.

이 섹션에서는 main 함수에 중점을 두어 설명하겠습니다. 모든 C 및 C 제품군은 main 함수로 시작합니다. Objective-C의 iOS 앱의 경우 Xcode 앱 템플릿으로 프로젝트를 만들 때 준비된 main.m 파일이 이미 프로젝트에 있습니다. 거기에 주요 기능이 있습니다.

``` swift
int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil,
                   NSStringFromClass([AppDelegate class]));
    }
}
```

이 함수에서 UIKit의 UIApplicationMain이 호출됩니다. UIApplication 객체 또는 세 번째 인자를 가진 서브 클래스를 초기화합니다 (이 예제에서는 기본 UIApplication이 사용됨을 의미합니다). 마지막 인자는 앱 델리게이트로 사용할 클래스를 지정합니다. 이 인스턴스는 UIApplicationMain에서 만들어지고 UIApplication 개체의 델리게이트 속성으로 설정됩니다. 
이 객체는 didFinishLaunching 및 didEnterBackground와 같은 일부 수명주기 메소드를 수신하는 데 사용됩니다. UIApplicationMain은 int를 반환하지만 시스템이나 사용자가 그것을 죽일 때까지 결코 반환되지 않고 메모리에 남아 있습니다.

Swift에서 상황이 조금 바뀌 었습니다. Swift에서 iOS 프로젝트를 만들면 프로젝트에 메인 파일이없고 주요 기능도 없습니다. 유일한 것은 주 AppDelegate 클래스 선언 위에있는 @UIApplicationMain의 속성 일 것입니다.

이 속성은 여기에 키를 보유합니다. 클래스를 @UIApplicationMain으로 표시하면 컴파일러는 어떤 type이 application delegate로 수행되어야 하는지를 알 수 있습니다. 

다른 것들은 보일러 플레이트 코드 일 가능성이 높기 때문에 자동으로 컴파일 타임에 삽입됩니다. 이를 확인하기 위해 @UIApplicationMain 특성을 제거하려고 시도 할 수 있습니다. 이렇게하면 컴파일 할 때 오류가 발생합니다.

	"main function을 찾을 수 없습니다."

일반적으로 말해서, 하나의 상황을 제외하고는 그것을 변경할 필요가 없습니다. UIApplication의 하위 클래스를 응용 프로그램 클래스로 사용하려면이 부분을 다시 작성하고 main 함수를 수동으로 추가해야합니다.

위에서 살펴본 것처럼 Swift 앱은 컴파일 할 때 주요 기능이 필요합니다. Objective-C의 main.c 또는 main.m과 마찬가지로 Swift에서 main.swift라는 특수 파일이있을 수 있습니다. 이 파일에서는 형식이나 범위를 정의하지 않고 명령문 코드를 작성할 수 있습니다. 이 statement는 전통적인 main function으로 수행됩니다. 예를 들어, @UIApplicationMain 특성을 제거한 후 프로젝트에서 main.swift 파일을 만들고 다음 내용을 채 웁니다.

``` swift
UIApplicationMain(Process.argc, Process.unsafeArgv, nil,
    NSStringFromClass(AppDelegate))
```

이렇게 하면 해당 에러는 사라질 것이고 모든 것은 잘 될것입니다. 이제 우리는 기본 UIApplication 하위 클래스 대신 UIApplication 하위 클래스를 사용하여 원하는 유용한 작업을 수행 할 수 있습니다. 다음과 같이하십시오.

```
import UIKit

class MyApplication: UIApplication {
    override func sendEvent(event: UIEvent!) {
        super.sendEvent(event)
        print("Event sent: \(event)");
    }
}

UIApplicationMain(Process.argc, Process.unsafeArgv,
    NSStringFromClass(MyApplication), NSStringFromClass(AppDelegate))

```

## swift 플로우
@UIApplicationMain로 표시하면 컴파일러는 main function 부르고 main 함수에서 UIApplicationMain()이 호출됩니다.
이곳에서 Info.plist를 참조하여 UIApplication 객체를 생성하고  그리고 앱 델리게이트 객체를 등록합니다. 델리게이트는 UIApplicationDelegate 프로토콜을 구현하고 있다.
이 앱 델리게이트 객체는 UIResponder를 상속받는데 이 이유는 Responder Chain에 공통의 타입을 체인에 묶기위해서 해준다.


출처: http://en.swifter.tips/uiapplicationmain/ 

