https://news.realm.io/kr/news/doios-natasha-murashev-protocol-oriented-mvvm
# Introduces protocol-oriented MVVM
Swift에서 레퍼런스 타입 대신 밸류 타입을 사용하는 것은 Objective-C 보다 쉬우며, 이해하기 쉽고 에러가 적은 코드로 개선하는데 도움이 됩니다. 그러나 공유해서 사용해야 하는 상황에서는 이런 장점을 살리지 못하고 subclassing을 하는 실수를 하기 쉽습니다. do{iOS} 2015에서 MVVM에 대해 소개한 이 강연에서, 프로토콜을 사용하는 방법과 subclass에서 벗어나는 방법을 알아 보세요. 프로토콜 지향 프로그래밍에 대해 익히고 적용하는 등, Swift 2.0의 장점을 살리고 코드를 개선하기 위해 Natasha가 학습한 과정을 차근차근 설명해 줍니다.

## Swift에서는 왜 코드를 단순화할까요?
objective-C를 사용하는 개발자로써, 처음 Swift가 나왔을 땐 Swift 내부에 Objective-C 코드를 쓰는 방식으로 시작했고 레퍼런스 타입을 사용했습니다. 객체 지향 프로그래밍이 익숙했으므로 모든 것을 클래스로 만드는 것부터 시작하곤 했습니다. 마치 Objective-C의 태생처럼요.

그때까지만 해도 가끔 normal enum보다 복잡한 enum을 사용하기도 했기 때문에 나름 만족하고 있었습니다. 하지만 여러 행사와 강연을 다니고, 특히 Swift 복잡성 제어와 밸류 타입에 대한 [Andy Matuschak의 강연](https://news.realm.io/news/andy-matuschak-controlling-complexity/) 을 듣고 나자 생각이 확 달라졌습니다. 그때까지는 Swift의 struct를 알고는 있었지만 Swift로 넘어간 Objective-C 개발자로써 클래스가 훨씬 더 자연스러웠죠.
그 인상적인 강연을 들은 후에는, 이제 모든 것에 밸류 타입을 사용해야겠다고 생각했습니다. 강연에서 밸류 타입을 사용하는 Swift 표준 라이브러리를 보여줬고, 언어 창시자들도 밸류 타입을 사용하니까요. 제 작업을 열어서 새 파일을 만들고 밸류 타입으로부터 시작해 봤습니다.

처음에는 “와, 나는 Swift 개발자야, struct를 사용하지!” 하는 마음에 즐거웠지만 subclass를 만들어야 하는 시점에서 괴로워졌고, 어떻게 이 장벽을 넘어서야 할지 모르겠더군요. 그러다가…

## 프로토콜 지향 프로그래밍
2015년 WWDC의 한 멋진 강연에서 Swift의 프로토콜 지향 프로그래밍을 만났습니다! subclass 대신 프로토콜을 사용하는 방법을 알 수 있있죠. Swift에 적응해가는 분이라면 작년 WWDC 중 이 강연이 가장 유용할 겁니다.

이 강연에서 Apple의 Swift 표준 라이브러리 tech lead인 Dave Abrahams는 이렇게 말했습니다.

> “Swift는 프로토콜 지향 프로그래밍 언어입니다.”

강연에서 그는 저를 포함한 모든 관중을 완전히 사로잡았습니다.

table view처럼 Apple이 사용하는 다양한 프로토콜을 보아 왔으므로 이것이 완전히 새로운 개념은 아닐 겁니다. 특히 사용할 때마다 UITableViewController를 subclassing하지 않아도 된다는 점에서 멋진 디자인 패턴이죠. Apple에 table view cell을 몇 개 만들지 알려주는 프로토콜을 사용하면 그만입니다. 자, 이제 이런 디자인 패턴의 위대함을 알았으니 더 나아가 볼까요?

프로토콜 지향 프로그래밍에 큰 감명을 받은 저는 프로토콜 지향 프로그래머가 되고 싶었습니다. 제 작업을 돌아보니 이미 정립된 패턴을 사용한 코드베이스가 보이더군요. 새로운 것을 적용하는 것 이전에 무엇을 사용해야 할지 아는 것부터가 어려웠습니다. 이미 존재하는 프로젝트에 갇힌 느낌이 들었고 이미 알고 있는 것에서 어떻게 개선해가야 할지 몰랐습니다.


## 심사숙고 후 깨달은 사용예 - MVVM
저는 프로토콜을 제 코드에 통합할 방법을 몇 날 며칠 내내 생각했습니다. 그러다 잠에서 깨어난 어느날 모든 것이 하나로 연결된 기분이 들었습니다. 제 코드에 적용할 수 있는 최소 하나의 사용예를 찾아낸 것이죠. 바로 MVVM이었습니다.

우선 간단한 예제를 보여드리겠습니다.

계좌 잔고를 보여주는 원본 데이터를 가진 모델이 있다고 가정해 보죠. 모델 레이어에서 원본 NSDecimalNumber로 값을 저장합니다.

``` swift
let amount = 6729383.99
```

같은 숫자이지만 사용자에게는 “계좌 잔고는 이렇습니다.” 하고 안내하듯 잘 가공해서 보여줘야겠죠. 통화 단위도 붙이고요.

``` swift
Your balance is $6,729,383.99
```

흔히 이 코드를 뷰 컨트롤러에 붙이는데, 그러면 뷰 컨트롤러가 무거워지고 테스트가 어려워집니다. 대신 이를 모델에 붙인다면 이번엔 모델이 복잡해지겠죠.

한편 모델을 명료하게 유지하고 원본 데이터를 반영할 수 있는 뷰 모델을 한번 볼까요?

``` swift
struct AccountViewModel {
	let displayBalance: String

		init(mode: BankAccount) {
			let formattedBalance = model.balance.currencyValue
			displayBalance = "Your balance is \(formattedBalance)"
		}
}
```

모델을 포함하는 이 뷰 모델을 통해 정보를 뷰에 보여지기 원하는 형식으로 구성할 수 있습니다. 게다가 테스트도 쉽죠. 이 방법 대신 계좌 정보를 모델에 넣을 수도 있겠지만 출력값이 명료하지 않기 때문에 뷰 컨트롤러나 뷰를 테스트하기 어렵습니다.

## 조에트로프 모델
보여드린 뷰 모델은 밸류 타입입니다. Swift에서 어떻게 작동할까요?

뷰 컨트롤러가 최신 뷰 모델을 가져야 합니다. 밸류 타입데이터 타입이므로 단순히 데이터의 복사본일뿐 이 시점에서는 직접 반응해서는 안됩니다. 뷰 컨트롤러가 데이터의 복사본을 추적해서 어떤 정보가 사용자에게 보여질지 결정하죠. 가장 최신 버전의 복사본이 될 겁니다.

Andy Matuschak는 zoetrope에 빗대어 생각해보라고 합니다. 일본 지브리 박물관에 있는 멋진 기구죠.
핵심은 zoetrope의 각각의 프레임이 정적 값이라는 점입니다. 캐릭터의 손이 얼마나 높게 들렸는지, 혹은 머리가 얼마나 기울어졌는지에 따라 캐릭터를 인코딩할 수 있습니다. 각 버전은 정적이지만 모든 프레임을 모아서 가운데를 바라보면 항상 새로운 데이터 값이 보이게 되죠. 따라서 멋지게 움직이는 이미지를 만들 수 있습니다.

밸류 타입도 이 같은 방식으로 접근할 수 있습니다. 뷰 컨트롤러는 zoetrope의 가장 최근 프레임을 추적합니다. 즉, 활성화된 가장 최근 데이터를 사용자에게 보여주는 것이죠. 모델이 업데이트되자마자 새 데이터가 생기므로, 새 뷰 모델을 계산할 수 있습니다. 이제 뷰를 최신 정보로 업데이트할 수 있습니다.

``` swift
var viewModel = ViewModel(model: Account)
```

## 최악의 프로토콜
자, 이제 가장 재밌는 부분을 간단한 예제와 함께 살펴볼까요? 대부분의 앱에 있는 설정 화면과 같은 테이블 뷰에 전체 앱을 노란색으로 칠하는 슬라이더 설정 하나만 있다고 가정해 봅시다.

정말 간단한 상황이지만 꽤 복잡해질 수 있습니다. 테이블 뷰 셀 내부의 모든 컴퍼넌트가 어떤 식으로든 형식이 맞춰져야 하죠. label이 있다면 폰트 종류, 폰트 색, 폰트 크기 등을 선언해야 합니다. switch가 있다면 그 switch가 켜질때도 생각해야겠죠. 단지 두 개의 element만을 포함한 아주 간단한 테이블 뷰 셀이지만 벌써 환경을 설정해야 할 6가지 케이스가 생겼습니다.

``` swift
class SwitchWithTextTableViewCell: UITableViewCell {
	func configure(
			title: String,
			titleFont: UIFont,
			titleColor: UIColor,
			switchOn: Bool,
			switchColor: UIColor = .purpleColor(),
			onSwitchToggleHandler: onSwitchTogglerHandlerType? = nil) {	
		// Configure views here
	}
}
```

아마 이보다 훨씬 더 복잡한 테이블 셀을 사용하는 것이 일반적일 겁니다. 그 경우 제 코드의 configure 메서드가 너무 커져버릴 수도 있습니다. subtitle을 붙인다면 3개의 새 프로퍼티를 더 설정해야 하죠. Swift에서는 이 때 기본 밸류를 사용할 수 있도록 지원하지만, configure 메서드 크기까지 해결해주진 못합니다.

실제로 이 메서드를 호출하는 뷰 컨트롤러에는 자기가 다뤄야할 정보를 담는 스택이 있습니다. 그다지 예쁘지 않아 맘에 들지는 않지만 프로토콜 이전에 사용할 수 있는 최선이었습니다.


## 뷰 모델과 프로토콜

방대한 configure 메서드를 버리고 셀을 위한 SwitchWithTextCellProtocol에 각 부분을 넣는 방법도 있습니다. 해당 프로토콜을 따르고, 해당 프로퍼티들을 알맞게 설정하는 뷰 모델을 만들 수 있죠. 이제 무식한 configure 메서드에서는 벗어났지만, 아직은 모든 프로퍼티가 실제로 설정되었는지 확인할 방법이 없습니다.

``` swift
protocol SwitchWithTextCellProtocol {
	var title: String { get }
	var titleFont: UIFont { get }
	var titleColor: UIColor { get }

	var switchOn: Bool { get }
	var switchColor: UIColor { get }

	func onSwitchToggleOn(on: Bool)
}
```

Swift 2.0의 프로토콜 익스텐션을 사용하면 기본 밸류를 통해 같은 작업을 할 수 있습니다. 대부분의 셀과 관련된 특정색이 있다면 프로토콜 익스텐션을 extend해서 그 색을 설정하면 됩니다. 이제 이를 구현하는 모든 뷰 모델은 색을 다시 설정할 필요가 없어서 정말 편리합니다.

``` swift
extension SwitchWithTextCellProtocol {
	var switchColor: UIColor {
		return .purpleColor()
	}
}
```

configure 메서드는 이 프로토콜을 따르는 기능을 다음처럼 포함할 수 있습니다.

``` swift
class SwitchWithTextTableViewCell: UITableViewCell {
	func configure(withDelegate delegate: SwitchWithTextCellProtocol) {
		// Configure views here
	}
}
```

이전에는 6개 이상의 인자가 필요했지만, 이제 하나의 인자만 있으면 충분합니다. 이제 뷰 모델은 다음과 같은 모습입니다.

``` swift
struct MinionModeViewModel: SwitchWithTextCellProtocol {
	var title = "Minion Mode!!!"
		var switchOn = true

		var switchColor: UIColor {
			return .yellowColor()
		}

	func onSwitchToggleOn(on: Bool) {
		if on {
			print("The Minions are here to stay!")
		} else {
			print("The Minions went out to play!")
		}
	}
}
```

위 예제는 프로토콜을 따르고 필요한 모든 것을 설정합니다. 이전 예제에서 봤듯 모델 객체와 함께 뷰 모델을 초기화할 수 있습니다. 이제 뷰에 보여줄 형식을 파악하기 위해 잔고 정보가 필요한 상황처럼 특정 정보가 필요할때라면, 뷰 모델을 통해 정보를 실제로 사용할 수 있습니다.

간단명료하죠? 이제 cellForRowAtIndexPath()도 아주 간결하게 만들 수 있습니다.

``` swift
// YourViewController.swift
let cell = tableView.dequeueReusableCellWithIdentifier("SwitchWithTextTableViewCell", forIndexPath: indexPath) as! SwitchWithTextTableViewCell

// This is where the magic happens!
cell.configure(withDelegate: MinionModeViewModel())

return cell
```

셀을 dequeue하고 뷰 모델과 함께 configure 메서드를 호출했습니다. 이 경우, 해당 프레이밍, 모델 레이어를 가지지 않아도 모델을 뷰 컨트롤러 레벨에서 추적할 수 있습니다. 뷰 모델에 넘기면 셀이 생성되죠. 리팩토링 이후 코드에는 오직 세 줄만이 남습니다!

# 더 많이 추상화 하기
이제까지 6개의 인자가 있는 방대한 configure 메서드를 프로토콜로 변환하는 프로토콜 사용예를 보여드렸습니다. 압축적인 로직으로 코드를 멋지게 개선하는 사용예를 찾아내서 만족스러운 마음으로 이에 관한 블로그를 썼습니다. 그런데 “프로토콜을 두 개 만들어서 하나는 실제 인코딩된 정보의 데이터 소스 프로토콜로 사용하면 어떨까요?” 라는 댓글이 달렸습니다. 형식을 만드는 것과 실제 정보가 분리돼야 하듯 색과 폰트처럼 대립되는 정보는 분리돼야 하겠죠. 실제로 Apple이 UITableViewCells나 컬렉션 뷰에서 사용하는 패턴입니다.

정말 멋진 아이디어라고 생각해서 제 로직도 분리해서 아래처럼 셀 데이터 저장소와 셀 델리게이트를 만들었습니다.

``` swift
protocol SwitchWithTextCellDataSource {
    var title: String { get }
    var switchOn: Bool { get }
}

protocol SwitchWithTextCellDelegate {
	func onSwitchToggleOn(on: Bool)

	var switchColor: UIColor { get }
	var textColor: UIColor { get }
	var font: UIFont { get }
}
```

그 다음, configure 메서드와 데이터 스토리지로 델리게이트를 만들었습니다. 폰트 종류나 색처럼 기본 밸류의 경우 프로토콜 익스텐션에서 델리게이트를 모두 설정할 수 있으므로, 인자를 넘길 필요도 없이 필요할 때 만들기만 하면 됩니다.

``` swift
// SwitchWithTextTableViewCell
func configure(withDataSource dataSource: SwitchWithTextCellDataSource, delegate: SwitchWithTextCellDelegate?)
{
	// Configure views here
}
```

익스텐션으로 뷰 모델을 개선했습니다. 데이터 소스를 따르고, 원본 정보를 변환해서 뷰로 넘기는 셀 블록 하나가 생기죠.

``` swift
struct MinionModeViewModel: SwitchWithTextCellDataSource {
	    var title = "Minion Mode!!!"
	    var switchOn = true
}
```

다음으로 독립적인 뷰 모델에 폰트나 색을 보유하고 내부적으로 처리하는 델리게이트를 만듭니다.

``` swift
extension MinionModeViewModel: SwitchWithTextCellDelegate {
	var switchColor: UIColor {
		return .yellowColor()
	}

	func onSwitchToggleOn(on: Bool) {
		if on {
			print("The Minions are here to stay!")
		} else {
			print("The Minions went out to play!")
		}
	}
}
```

마침내 테이블 뷰 셀이 정말 간결해졌습니다.

``` swift
// SettingsViewController

let viewModel = MinionModeViewModel()
	cell.configure(withDataSource: viewModel, delegate: viewModel)
	return cell

```

뷰 모델을 만들고 configure 메서드에 넘겨서 셀을 반환받았습니다.

## Swift 2.0의 Mixins과 Traits


