iOS의 MVVM에는 수많은 기사가 있지만 실제로 MVVM이 실제로 어떻게 보이는지, 실제로 어떻게 수행하는지에 대해서는 거의 집중하지 않습니다. RxSwift를 사용하여 MVVM에 대한 기사입니다.
ReactiveX는 관찰 가능한 시퀀스를 사용하여 비동기 및 이벤트 기반 프로그램을 작성하기위한 라이브러리입니다. [reactivex.io](http://reactivex.io)

## How do iOS components communicate?
RxSwift의 가장 큰 장점은 앱의 여러 구성 요소 간 통신을 단순화한다는 것입니다. 예를 들어, 모델과 ViewController. MVC 프레임 워크에서 이들을 연결하는 것은 거의 해킹과 같습니다.
모델이 변경 될 가능성이 있다고 생각할 때 일종의 updateUI () 함수를 호출하여 ViewController의 모든 outlet들을 재설정합니다.
이로 인해 모델과 ViewController, 불필요한 업데이트 및 이상한 버그 사이의 불일치가 발생할 수 있습니다.
우리가 필요로하는 것은 항상 모델의 실제 상태를 보여줄 ViewController입니다. 본질적으로, 우리는 ViewController가 모델이 현재 무엇이든에 따라 데이터를 표시 할 간단한 프록시(대리자)가 필요합니다.
물론 대부분의 앱들은 만약 모델들을 나타내기만 한다면 쓸모가 없습니다. 모델에서 데이터를 추출하여 디스플레이에 표시 할 수 있어야합니다. 
 이것이 ViewModel 클래스를 도입 한 이유입니다. ViewModel은 디스플레이에 나타내야하는 모든 데이터를 준비합니다.
그러나 재미있는 부분은 다음과 같습니다. ViewModel은 ViewController에 대해 아무것도 모릅니다. 내부의 속성을 직접 참조하거나 설정하지 않습니다. 대신, ViewController는 ViewModel에서 변경 사항을 지속적으로 관찰하며, 변경된 사항이 있으면 바로 표시합니다.
명심하세요. 이것은 각 프로퍼티에 기초합니다. 이는 ViewController가 ViewModel 내부에 각 속성을 개별적으로 표시한다는 것을 의미합니다.문자열과 이미지를 로드하려면 로드 된대로 제시 할 수 있습니다. 둘 다로드 될 때까지 기다릴 필요없이 한 번에 모두 표시 할 수 있습니다. 
그러나 ViewController는 데이터를 표시 할뿐만 아니라 사용자 입력을받습니다. 우리의 ViewController는 단지 대리자 일뿐 그 input에는 아무런 쓸모가 없습니다. 그래서 input을 ViewModel에 전달하면 ViewModel이 나머지를 처리하게됩니다.

![MVVM](../images/MVVM.png)

위 그림은 ViewController와 ViewModel 간의 단방향 통신을 나타냅니다. ViewController는 ViewModel을 볼 수 있지만, ViewModel은 ViewController가 누구인지 알지 못합니다. 즉, 앱에서 ViewController를 완전히 제거 할 수 있으며 모든 로직이 의도 한대로 작동합니다!
이거 참 멋지게 들리는데요, 그럼 우리는 코드작성을 어떻게 해야할까요?

## MVVM with RxSwift
사용자가 입력 한 도시의 예측을 표시하는 간단한 날씨 앱을 만들어 보겠습니다.

도시 이름 입력을위한 UITextField와 현재 온도를 표시하는 UILabel이 있습니다.
참고 :이 예제 앱의 경우 OpenWeatherMap에서 날씨 데이터를 가져옵니다.
우리 모델은 도시 이름과 온도를 가진 Weather 구조체가 될 것이고, JSON 객체로 초기화되어 속성을 파싱하고 설정합니다.

``` swift
struct Weather {
	let cityName: String
	let degrees: Double

	init?(json: JSON) {
		//parsing...
	}
}
```

이제 public searchText 속성이 변경 될 때 ViewModel이 새 모델을 요청하도록해야합니다. ViewController는 나중에 사용자 입력을 보내기 위해 이 프로퍼티에 접근 할 수 있습니다.

``` swift 
final class ViewModel {
	private struct Constants {
		static let URLPrefix = "http://api.openweathermap.org"
		static let APPID = /* my openweathermap APPID */
	}

	private let disposeBag = DisposeBag()

	let searchText = Variable<String>("")
} 
```
위 코드의 searchText는 변수입니다. 변수는 본질적으로 Observable과 Observer 모두를 만족하는 BehaviorSubject를 둘러싼 래퍼입니다. 즉, 다시 보낼 수있는 항목을 보낼 수 있습니다.
BehaviorSubjects는 일단 subscribe 되면 자신이 받은 마지막 항목을 방출하기 때문에 고유합니다. 이러한 방법이 필요한 이유는 MVVM에서는 앱 수명주기에 따라 다른 클래스의 Observables이 subscribe 하기 전에 요소를받을 수 있기 때문에 필요합니다.
ViewController가 ViewModel의 프로퍼티에 subscribe하면, 그것을 display하기 위해 마지막 아이템이 무엇인지를 볼 필요가 있고 그 반대도 마찬가지입니다.
이제 프로그래밍을 통해 변경하려는 UI 대해 ViewModel에 속성을 선언해야합니다.

``` swift
let cityName: Observable<String>
let degrees: Observable<String>
```

ViewModel의 작업은 모델을 표현할 수있는 데이터로 변환하는 것입니다. 이 경우, 우리 모델은 다른 Weather 인스턴스의 관찰 가능한 시퀀스입니다. 위의 속성 (cityName, degrees)은 Weather observable의 다른 매핑이 될 것 입니다.

``` swift
private let weather: Observable<Weather>
```

주의하세요. 이 프로퍼티는 private 합니다. ViewController는 사실상 우리앱의 실제 로직에 대해 어떠한 것도 가지고있지 않기 때문이죠. ViewController가 알아야하는 것은 단지 보여주기위해 필요한 데이터일 뿐입니다.

## Searching
이제 우리 모델을 위에서 선언 한 searchText 속성에 연결해 보겠습니다. searchText가 변경 될 때마다 네트워크 요청을 작성한 다음 모델을 해당 요청에 등록하여이 작업을 수행합니다.

``` swift
init() {
	let jsonResponse = searchText.asObservable()
		.map(requestURLForQuery)
		.map(NSURLSession.sharedSession().rx_JSON)
		.observeOn(MainScheduler.instance)
		.catchError { error in
			print("An error occurred! \(error)")
				return Observable.empty()
		}
	.switchLatest()

		weather = jsonResponse
		.map(Weather.init)
		.addDisposableTo(disposeBag)
		.shareReplay(1)
		cityName = weather
		.map { weather in return weather.cityName }

	temp = weather
		.map { weather in return “\(weather.degrees)” }
}
```

이렇게하면 searchText가 변경 될 때마다 jsonRequest가 해당 NSURLRequest로 변경됩니다. 변경 될 때마다 모델은 NSURLRequest에서 얻은 값으로 설정됩니다.
JSON 요청 중에 오류가 발생하면이를 print 하고 빈 값을 반환합니다.
참고 : rx_JSON () 메서드는 실제로 관찰 할 수있는 시퀀스 자체입니다. 그래서 jsonRequest는 Observable of Observable입니다. 따라서 jsonRequest가 가장 최근 시퀀스 만 반환하도록하는 .switchLatest ()를 사용합니다. 또한 요청을 subscribe 할 때까지 요청을 받아오기를 시작하지 않습니다.

shareReplay (1)는 날씨에 가입 한 모든 사람들이 똑같은 정확한 구독을 얻도록합니다. 그렇지 않으면 각 구독은 날씨의 개별 인스턴스를 호출하고 요청은 여러 번 이루어집니다.
이제 남은 것은 ViewController를 ViewModel에 연결하는 것입니다. ViewModel의 Observables를 컨트롤러의 outlet에 바인딩하여 이 작업을 수행합니다.

``` swift
class ViewController: UIViewController {

	let viewModel = ViewModel()
		let disposeBag = DisposeBag()

		@IBOutlet weak var nameTextField: UITextField!

		@IBOutlet weak var degreesLabel: UILabel!
		@IBOutlet weak var cityNameLabel: UILabel!
		override func viewDidLoad() {
		super.viewDidLoad()

			//Binding the UI
			viewModel.cityName.bindTo(cityNameLabel.rx_text)
					.addDisposableTo(disposeBag)

			viewModel.degrees.bindTo(degreesLabel.rx_text)
					.addDisposableTo(disposeBag)
		}
}
```

ViewModel이 사용자가 텍스트 필드에 입력 한 내용을 알고 있는지도 확인해야한다는 것을 잊지 마십시오! ViewController의 textField 값을 ViewModel의 searchText 속성에 바인딩하여이 작업을 수행 할 수 있습니다. 그래서, 우리는 이것을 viewDidLoad ()에 단순히 추가 할 것입니다.

``` swift
nameTextField.rx_text
		.bindTo(viewModel.searchText)
		.addDisposableTo(disposeBag)
```

우리의 앱은 사용자가 타이핑하는 동안 Weather 데이터를 가져오고 있으며, 사용자가 보는 것은 무엇이든지 배후에있는 앱의 진정한 상태를 타나냅니다.

https://medium.cobeisfresh.com/implementing-mvvm-in-ios-with-rxswift-updated-for-swift-2-51cc3ef7edb3
https://brunch.co.kr/@tilltue/2
