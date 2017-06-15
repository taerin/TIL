# ios
------

### 1. 버전
xcode | ios 버전
----- | --------
8.x | ios 10.x
7.x | ios 9.x

### 2. 앱 생명주기
앱 생명주기는 홈버튼을 눌렀을때, 전화가 왔을때와 같이 앱이 화면상에서 보이지 않는 background 상태, 화면에 올라와 있는 상태인 foreground 등과 같은 상태들을 정의한 것 입니다.
Swift에서 앱 아이콘을 눌러 앱을 실행시키면 아래와 같은 일들이 일어납니다.

	* UIApplication 객체를 생성
	* @UIApplicationMain 어노테이션이 있는 클래스를 찾아 AppDelegate 객체를 생성
	* Main Event Loop를 실행(touch, text input등 유저의 액션을 받는 루프) 및 기타 설정

각각에 대해서 설명을 하자면 UIApplication 객체는 싱글톤 객체(앱 전체에 하나만 존재)이며 Event Loop에서 발생하는 여러 이벤트들을 감지하고 Delegate에 전달하는 역할을 합니다.
예를 들면 앱이 백그라운드로 갈때, 메모리 부족 경고를 할 때와 같은 상황들을 감지하여 Delegate에 전달합니다. 

AppDelegate 객체는 UIApplication 객체로 부터 메시지를 받았을 때, 해당 상황에서 실행 될 함수들을 정의합니다. 
Xcode로 Swift 프로젝트를 만들면 자동으로 생성되는 AppDelegate.swift 파일이 있는데 이 파일이 AppDelegate 객체가 됩니다.
왜냐하면 AppDelegate.swift 파일을 열어보면 클래스 선언부에 @UIApplicationMain 어노테이션이 붙어 있는걸 볼 수 있습니다. 
즉 앱이 구동되면 AppDelegate.swift의 AppDelegate 클래스를 델리게이트 객체로 지정합니다. 

AppDelegate.swift 파일에는 앱의 상태에 따라 실행되는 함수들이 정의되어 있습니다. 정의된 함수들을 보기에 앞서 앱의 실행 상태는 5개 상태로 구분 될 수 있고 아래와 같습니다.

state | 설명
------|------
Not Running | 앱이 실행되지 않은 상태 (Inactive와 Active 상태를 합쳐서 Foreground 라고 함)
Inactive | 앱이 실행중인 상태 그러나 아무런 이벤트를 받지 않는 상태
Active | 앱이 실행중이며 이벤트가 발생한 상태
Background | 앱이 백그라운드에 있는 상태 그러나 실행되는 코드가 있는 상태
Suspened | 앱이 백그라운드에 있고 실행되는 코드가 없는 상태

AppDelegate.swift에는 아래와 같이 앱의 상태에 따라 실행되는 delegate 함수들이 정의되어 있기때문에 함수안에 코드를 작성 함으로써 앱의 특정 상태에서 동작하는 로직을 구현 할 수 있습니다.

function | 설명
---------|------
application(_:didFinishLaunching) | 앱이 처음 시작될 때 실행
applicationWillResignActive: | 앱이 active 에서 inactive로 이동될 때 실행 
applicationDidEnterBackground: | 앱이 background 상태일 때 실행 
applicationWillEnterForeground: | 앱이 background에서 foreground로 이동 될때 실행 (아직 foreground에서중이진 않음)
applicationDidBecomeActive: | 앱이 active상태가 되어 실행 중일 때
applicationWillTerminate: | 앱이 종료될 때 실행

AppDelegate는 UIApplicationDelegate 라는 프로토콜(인터페이스)을 구현하고 있는데 swift에서 프로토콜에서 optional(필요시 구현) 옵션과 함께 기능 명세 작성 시에는 반드시 구현을 하지 않아도 된다. 
6가지 중 전통적으로 application(_:didFinishLaunching:) / applicationWillTerminate 두가지는 남겨둔다.


### 3. 역할

용어 | 역할
----|-----
plist | 실행 파일의 필수 구성 정보가 들어있는 구조화 된 텍스트 파일로 안드로이드에서의 메니페스트 파일역할을 한다.
AppDelegate | AppDelegate.swift 소스파일은 두개의 주요 기능을 갖습니다.
AppDelegate.swift 소스코드 |  앱의 시작점(entry point)를 생성하고, 앱으로 들어오는 이벤트를 처리하기 위한 run roop를 만드는 역할을 합니다. 소스코드 상에서 실제로 이 작업을 수행하는 것은 맨위에 선언되어 있는 @UIApplicationMain attribute입니다.
@UIApplicationMain attribute와 application객체  | app delegate객체를 생성하여 위와 같은 작업을 합니다.
application | 앱의 객체로서, app delegate와의 통신을 통해 앱의 상태변화를 감지하여 앱의 생애주기(life cycle)을 관리합니다.
AppDelegate | 앱의 객체로서, 구체적으로는 AppDelegate클래스의 인스턴스입니다. app delegate는 window 객체를 생성하여 컨텐츠를 그리고, 앱의 상태 변화에 반응하게 합니다. 실제로 우리가 앱을 컨트롤 하기 위한 작업을 코딩하는 영역이기도 합니다. 

(*역자 : 앱의 상태 변화가 발생하면 application객체가 이를 감지하여, app delegate에 선언되어 있는 생애주기 메서드를 호출하여 실행합니다. 이러한 application객체 및 app delegate객체를 생성하는 역할을 @UIApplicationMain속성이 수행합니다.)

(*run loop : 작업을 할당하고 앱에 들어오는 이벤트를 반복해서 처리하는 루프(event processing loop))

## AppDelegate Class
AppDelgate클래스는 단 하나의 프로퍼티를 갖고 있는데, 바로 UIWindow 객체인 window입니다. 이 window프로퍼티를 통해 app delegate는 컨텐츠를 그릴 수 있게 되고, 각종 변화에 대해서도 반응할 수 있게 됩니다. 참고로 window프로퍼티는 optional로 선언되어 있기 때문에 때에 따라 값이 없을 수도 있습니다.(nil) 

AppDelegate클래스에는 아주 중요한 (템플릿)메서드들이 선언되어 있습니다. 바로 이 메서드들을 통해 application객체가 app delegate객체와 통신을 하여 앱의 상태 변화에 반응할 수 있게 됩니다.
앱을 켜거나, 홈버튼을 눌러 끄거나, 완전히 종료시켜버리는 등 앱의 상태(state) 변화가 발생할 때, application 객체는 상황에 맞는 app delegate의 메서드를 호출하여 적절한 처리를 하게 됩니다. 물론 앱의 상태 변화 시, application객체가 자동으로 해당 메서드를 호출하므로 우리가 직접 메서드를 호출하는 코드를 작성할 필요는 없습니다. 
이 메서드들에는 디폴트 작동방식(default behavior)이 정의되어 있습니다. 즉, AppDelegate 클래스에서 이 메서들을 삭제하거나 구현부를 비워두어도, 앱의 상태변화에 따라 이 메서드들이 자동으로 호출되어 디폴트 작동방식 내용이 실행됩니다. 앱의 상태변화가 있을 때 해야할 작업들이 있다면 이 메서드들에 코드를 작성하면 됩니다.

## The View Controller Source File
Single View Application 템플릿은 또하나의 소스코드 파일을 생성하는데, 바로 ViewController.swift입니다.
ViewController는 UIViewController 를 상속받은 커스텀 클래스이기 때문에, UIViewController 클래스의 정의된 모든 것을 상속받습니다. 상속받은 내용을 커스터마이징 하기 위해서는 오버라이드를 해주시면 됩니다. 즉, viewDidLoad()와 didReceiveMemoryWarning()메서드를 오버라이드하여 사용하면 됩니다. 

