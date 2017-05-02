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

Model -> ViewModel 

https://medium.cobeisfresh.com/implementing-mvvm-in-ios-with-rxswift-458a2d47c33d
https://brunch.co.kr/@tilltue/2
