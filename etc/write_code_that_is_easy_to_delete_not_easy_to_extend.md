# 확장하기 쉬운 코드가 아니라 삭제하기 쉬운 코드를 작성하자
-----

> “모든 코드는 이유 없이 작성되어, 나약함 때문에 유지보수 되다가, 우연히 삭제된다.”
> - 장폴 사르트르의 ANSI C 프로그래밍.

우리가 작성한 모든 코드에는 유지보수라는 형태의 대가가 따른다. 그래서 우리는 대가를 치뤄야 하는 코드가 너무 많아지는 것을 방지하기 위해서 재사용할 수 있는 소프트웨어를 만들려고 노력한다. 하지만 코드를 재사용하면 다른 문제가 발생한다. 나중에 코드를 바꾸려 할 때 재사용된 코드가 방해를 한다는 점이다.
어떤 API를 사용하는 코드가 더 많아질수록 그 API를 변경하는 과정에서 다시 작성해야만 하는 코드도 더 많아진다. 마찬가지로 어떤 서드 파티 API에 더 많이 의존할수록 그 API가 바뀌었을 때 고생도 더 많이 하게 된다. 대규모 시스템에서 코드가 어떻게 서로 맞물려 동작하는지, 그리고 어떤 부분이 다른 부분에 어떻게 의존하는지를 관리하는 것은 중요한 문제다. 게다가 프로젝트가 오래될수록 이 문제는 점점 더 어려워지기만 한다.

> 오늘 내가 하고자 하는 말은, 코드 줄 수를 셀 거라면 “작성된 코드 줄 수”가 아니라 “투입된 코드 줄 수”라고 봐야한다는 것이다.
> - 에츠허르 데이크스트라. 1988. EWD 1036

‘코드 줄 수’를 ‘투입된 코드 줄 수’라고 본다면, 코드를 삭제하는 것은 유지보수 비용을 줄이는 것이 된다. 우리는 재사용할 수 있는 소프트웨어가 아니라 쉽게 버릴 수 있는 소프트웨어를 만들려고 노력해야 한다.

게다가 코드를 작성하는 것보다는 삭제하는 것이 더 즐겁다는 것은 굳이 언급할 필요도 없을 것이다.

삭제하기 쉬운 코드를 작성하는 방법은 다음과 같다.

* 의존성이 만들어지는 것을 피하기 위해 중복되는 코드를 작성하되, 그렇다고 의존성을 관리하는 코드를 중복해서 작성하지는 말라.
* 코드를 여러 개의 레이어로 구성하라. 구현하기는 쉽지만 사용하기는 귀찮은 부분을 활용해서 사용하기 편한 API를 만들라.
* 코드를 분리하라. 작성하기 어려운 부분과 바뀔 가능성이 높은 부분은 나머지 코드로부터 분리하고, 서로로부터도 분리하라.
* 모든 의사결정을 하드 코딩하지 말고, 일부는 런타임 중에 바꿀 수 있도록 허용하는 것도 고려하라.
* 지금 말한 것들을 모두 한 번에 적용하려고 하지 말고, 무엇보다도 애초에 코드를 많이 작성하지 않는 것을 고려하라.


## 0단계: 코드를 작성하지 말자
코드 줄 수 그 자체에는 별다른 정보가 담겨있지 않지만 50, 500, 5000, 10,000, 25,000 등의 숫자 단위에는 의미가 있다. 1,000,000줄짜리 모노리스 프로그램은 10,000줄짜리 프로그램보다 작업하기 더 짜증날 뿐 아니라 교체하는 과정에도 더 많은 시간과 돈과 노력이 들 것이다.
코드가 많아질 수록 코드를 삭제하기가 더 어려워지지만 그렇다고 코드를 한 줄 줄인다고 그것만으로 뭔가 크게 달라지는 것도 아니다.
그럼에도 불구하고 역시 코드를 삭제하는 가장 쉬운 방법은 그냥 처음부터 그 코드를 아예 작성하지 않는 것이다.

## 1단계: 코드를 복붙하자
재사용할 수 있는 코드를 작성하려 할 때, 미래에 어떤 사용 케이스가 있을지 예측해서 작성하는 것보다는 이미 코드 베이스에 사용 사례가 몇 개 있을 때 그것을 보고 뒤늦게 작성하는 쪽이 훨씬 쉽다. 그래도 긍정적으로 보자면 파일 시스템을 활용하는 것만으로도 이미 많은 코드를 재사용하고 있는 셈이니, 재사용에 대해 그렇게까지 걱정할 필요는 없지 않을까? 게다가 어느 정도 코드가 중복되는 것은 코드 건강에도 좋다.
바로 라이브러리 함수를 만들려 하기보다는 코드가 실제로 어떻게 사용되는지 살펴볼 수 있도록 몇 번 복붙해보는 것이 좋다. 왜냐면 어떤 코드를 공용 API로 만들어버리는 순간 그 코드는 변경하기 더 어려워지기 때문이다.
당신이 구현한 함수가 동작하는 방식에는 당신이 의도한 부분도 의도하지 않은 부분도 같이 있을 것이다. 그리고 그 함수를 호출하는 코드는 당신이 의도한 부분과 의도하지 않은 부분 모두에 의존할 것이고, 당신의 함수를 사용하는 프로그래머도 당신이 작성한 문서가 아니라, 함수가 어떻게 동작하는지 스스로 관찰한 결과를 신뢰할 것이다.
이런 현실에서는 함수 자체를 삭제하는 것보다는 함수 내부의 코드를 삭제하는 것이 훨씬 간단하다.

## 2단계: 코드를 복붙하지 말자
어떤 코드를 이미 여러번 복붙했다면 그 코드를 함수로 바꿔야 할 시점이 온 것일 수도 있다. “이제 거의 표준 라이브러리처럼 자주 사용하고 있는 내 코드를 그만 좀 호출하고 싶다” 라는 시점인데, 예를 들면 “설정 파일을 열어서 해시 테이블을 반환해라”나 “이 디렉토리를 삭제해라” 등이 있을 것이다. 상태가 하나도 없는 함수나, 환경 변수 같은 전역 정보를 조금 알고 있는 함수도 이 범주에 들어간다. 즉, 일반적으로 util이라는 이름의 파일에 자리잡게 되는 것들 말이다.

첨언: util 디렉토리를 만들고 서로 다른 종류의 유틸리티를 각각 별도의 파일에 넣어라. 단 하나의 util 파일만 사용하면 그 파일은 반드시 너무 크지만 분리하기는 너무 어려운 수준까지 부풀어오른다. 단 하나의 util 파일만 사용하는 것은 비위생적이다.

코드는 특정 어플리케이션이나 프로젝트에 구체적으로 맞추어져 있지 않을수록 재사용하기도 더 쉽고 변경되거나 삭제될 가능성도 더 낮다. 로깅, 서드 파티 API, 파일 조작이나 처리 등의 라이브리리 코드가 여기 포함된다. 삭제하지 않을 가능성이 높은 코드의 또다른 예시로는 리스트나 해시 테이블 등의 컬렉션이 있다. 이는 그런 코드의 인터페이스가 보통 매우 간단하기 때문이 아니라, 시간이 지나도 코드의 스코프가 더 넓어지지 않기 때문이다.
코드를 삭제하기 쉽도록 만들기보다는 삭제하기 어려운 부분을 삭제하기 쉬운 부분으로부터 최대한 멀리 분리해놓으려 노력해야 한다.

## 3단계: 보일러플레이트 코드를 더 많이 작성하자
코드 복붙을 피하기 위해 라이브러리를 만들어도 보통 그 라이브러리를 사용하는 코드를 오히려 더 많이 복붙하게 되는데, 그런 코드는 “보일러플레이트 코드”라는 조금 다른 이름으로 불린다. 보일러플레이트는 복붙과 거의 동일하지만 똑같은 코드를 계속 반복하는 것이 아니라, 그 코드를 사용할 때마다 매번 다르게 코드를 조금씩 수정한다는 점에서 다르다.

목표는 복붙을 할 때와 동일하다. 코드의 일부를 중복해서 사용함으로써 의존성을 만드는 것을 피하고 코드를 유연하게 하는 것이다. 다만 그 대가로 코드가 장황해진다.
보일러플레이트가 필요한 라이브러리에는 네트워크 프로토콜, 와이어 포맷, 파싱 도구 등이 있다. 이런 분야에서는 프로그램의 유연성을 유지하는 동시에 정책(프로그램이 무엇을 해야 하는가)과 프로토콜(프로그램이 무엇을 할 수 있는가)을 결합시키기가 어렵다. 그리고 이런 코드는 다른 컴퓨터와 통신하거나 다른 파일을 조작하는데 필수적인 경우가 많기 때문에 삭제하기도 힘들다. 그러니 여기에다가 비지니스 로직을 섞어 쓰는 일은 절대로 없어야 한다.

이건 그냥 별 이유 없이 코드를 재사용하는 것이 아니라, 자주 변하는 부분을 더 정적인 부분으로부터 분리하고 라이브러리 코드의 의존성과 책임을 최소화하기 위한 과정이다. 그 대가로 라이브러리를 사용하기 위해서 보일러플레이트 코드를 사용해야 할지라도 말이다.
지금 단계에서 더 많은 양의 코드를 작성하고 있는 것은 사실이다. 하지만 그 코드는 모두 나중에 삭제하기 쉬운 부분에다가 작성하고 있다는 점이 중요하다.

## 4단계: 보일러플레이트 코드를 작성하지 말자
보일러플레이트 코드는 라이브러리가 다양한 사람의 입맛을 충족시켜야 할 때는 최선의 선택이긴 하지만, 반복되는 코드가 정말 많아도 너무 많아지는 시점이 있다. 유연한 라이브러리를 정책, 워크플로우, 상태에 대해 자체적인 의견을 가진 래퍼 라이브러리로 감쌀 때가 온 것이다. 사용하기 간단한 API를 만드는 것의 핵심은 보일러플레이트 코드를 라이브러리로 전환시키는 것이다.
당신이 생각하는 것만큼 희귀한 일은 아니다. 많은 사람들이 사용하고 사랑하는 파이썬 http 클라이언트인 requests는 사용하기 더 번잡한 라이브러리인 urllib3를 바탕으로 더 간단한 인터페이스를 성공적으로 제공한 예다. requests는 일반적인 http 사용 워크플로우에 맞추어져 있으며 구체적인 구현 사항을 사용자로부터 감춘다. 동시에 urllib3는 파이프라인과 연결 관리를 담당하는데 사용자로부터 아무 것도 감추지 않는다.
한 라이브러리를 다른 라이브러리로 감싸는 것은 세부사항을 감추는 것보다는 관심사(concern)를 분리하는 것이 목적이다. requests의 관심사는 http로 하는 일반적인 패키지 여행 상품을 제공하는 것이고, urllib3의 관심사는 원하는 대로 여행을 계획할 수 있도록 도구를 제공하는 것이다.
/protocol/과 /policy/ 디렉토리를 만들라고까지 권하는 것은 아니지만, util 디렉토리에 비지니스 로직이 섞이지 않도록 하고, 구현하기 쉬운 라이브러리를 바탕으로 그 위에 사용하기 쉬운 라이브러리를 만드는 것이 좋을 것이다. 그리고 바탕이 되는 라이브러리를 완성하기 전에 그 라이브러리를 사용하는 다른 라이브러리를 만들기 시작해도 괜찮다.
꼭 프로토콜같은 종류의 라이브러리가 아니더라도 서드 파티 라이브러리는 래퍼로 감싸주는 것이 좋을 때가 많다. 그러면 프로젝트 전체에 걸쳐서 특정 서드 파티 라이브러리에 락인되는 대신, 자신의 코드에 적합한 라이브러리를 직접 만들 수 있다. 사용하기 편한 API를 만드는 것과 확장이 쉬운 API를 만드는 것은 상충할 때가 많다.
이렇게 관심사를 분리해주면 일부 사용자를 만족시켜주는 동시에 다른 사용자들도 원하는 대로 코드를 사용할 수 있도록 해줄 수 있다. 처음부터 좋은 API를 가지고 시작하면 레이어를 나누기 쉽지만 안 좋은 API를 바탕으로 좋은 API를 작성하는 것은 불쾌할 정도로 어렵다. 좋은 API는 그 API를 사용할 프로그래머에 대한 배려를 내재하도록 디자인된다. 그리고 레이어를 나눈다는 것은 모든 사람을 한 번에 만족시키는 것은 불가능하다는 사실을 인정하는 것을 의미한다.
레이어를 나누는 것의 목적은 나중에 삭제할 수 있는 코드를 작성하는 것보다는, 삭제하기 어려운 코드가 비지니스 로직에 오염되지 않도록 하면서도 이를 사용하기 편하도록 만드는 것이다.

## 5단계: 큰 덩어리 코드를 작성하자
복붙도 했고, 리팩토링도 했고, 레이어도 분리했고, 컴포지션도 했다. 하지만 결국 코드에 있어 가장 중요한 것은 뭔가 하는 일이 있어야 한다는 것이다. 가끔은 그냥 전부 포기하고 상당한 양의 쓰레기 코드를 작성해서 나머지 코드가 동작할 수 있도록 해주는 것이 최선의 선택일 때도 있다.
비지니스 로직이 담긴 코드의 특징은 무한히 계속되는 엣지 케이스와 임시변통 편법으로 가득하다는 것이다. 그래도 괜찮다. 상관 없다. “게임 코드”나 “창업자 코드” 등의 다른 스타일도 결국 본질은 같다. 시간을 상당히 많이 단축하기 위해 빠르게 대충 만드는 것이다.
그렇게 하는 이유가 뭘까? 커다란 실수 하나를 삭제하는 것이 18개의 겹쌓아진 작은 실수들을 삭제하는 것보다 쉬울 때가 있기 때문이다. 프로그래밍은 탐험과 같을 때가 많아서 몇 번 실수하면서 반복 개발하는 것이 처음부터 제대로 만들려고 고민하는 것보다 더 빠르다.
이건 재밌거나 창조적인 일일수록 특히 더 그렇다. 첫 게임을 만들고 있다면 엔진을 만들려고 하지 말자. 마찬가지로 어플리케이션을 만들기 전에 웹 프레임워크를 만들려고 하지 말자. 처음엔 그냥 엉망진창 코드를 만들자. 초능력자가 아닌 이상 코드를 어떻게 나눠야 할지 미리 알 수는 없다.
모노레포의 장단점도 이와 비슷하다. 코드를 어떻게 분리해야 할지 미리 알 수는 없고, 솔직히 긴밀히 결합된 20개의 실수를 디플로이하는 것보다는 거대한 실수 덩어리 하나를 디플로이하는 것이 더 쉽다.
어떤 코드가 곧 버려지거나 삭제될지, 또는 수월하게 교체될 수 있는지 알면 더욱 빠르고 요령 있게 개발할 수 있다. 특히 일회성 클라이언트 사이트나 이벤트 웹페이지 등을 만드는 것이라면 더더욱 그렇다. 템플릿을 가지고 복제본을 찍어내거나, 프레임워크에 없는 부분만 채워넣으면 되는 경우도 이에 해당된다.
그렇다고 똑같은 진흙 덩어리 코드를 수차례 반복해서 작성해서 실수의 완성도를 높이라는 말은 아니다. 앨런 펄리스를 인용하자면 “모든 것은 탑다운 방식으로 만들어야 한다. 처음 만들 때를 제외하면.” 소프트웨어는 매 번 새로운 실수를 하고, 새로운 위험을 감수하고, 반복하면서 점진적으로 만들어나가야 한다.
프로 소프트웨어 개발자가 되는 것은 과거의 실수와 후회의 목록을 계속해서 쌓아나가는 것과 같다. 성공에서는 아무것도 배울 수 없다. 좋은 코드가 무엇인지 알게 되는 것이 아니라, 안 좋은 코드가 남긴 흉터가 마음 속에 생생하게 남는 것이다.
어차피 모든 프로젝트는 실패하거나 레거시 코드가 될 뿐이다. 게다가 성공보다는 실패가 더 잦다. 그렇다면 똥 한 개를 잘 빚으려고 노력하는 것보다는 거대한 진흙 덩어리 코드를 여러번 작성해보고 어떤 길이 열리나를 살펴보는 것이 더 빠르다.
그리고 그럴 때는 코드를 조금씩 지우는 것보다는 한 번에 전부 지우는 편이 더 쉽다.


## 6단계: 코드를 작은 조각으로 쪼개자
거대한 진흙 덩어리 코드는 만들기는 가장 쉽지만 유지보수 비용은 가장 비싸다. 간단하게 생각되었던 수정도 거의 코드 베이스 전체를 임시변통적인 방식으로 건드리고 만다. 코드를 통째로 삭제하기는 쉬웠는데, 조금씩 삭제하는 것은 불가능하다.
앞서 플랫폼 관련 책임을 가지는 코드와 도메인 관련 책임을 가지는 코드를 레이어로 분리했던 것과 마찬가지로, 이제 그 위에 구현된 로직을 쪼갤 방법이 필요하다.

> 어려운 디자인 결정이나 바뀔 가능성이 높은 디자인 결정의 목록을 작성하라. 그리고 나서 각 결정을 서로로부터 감출 수 있도록 각 모듈을 디자인하라. 
> - 데이빗 파르나스. 1972. On the Criteria To Be Used in Decomposing Systems into Modules.

공통 기능을 가진 부분을 기준으로 코드를 쪼개는 것이 아니라 나머지 코드와 공유하지 않는 부분을 기준으로 코드를 쪼개자. 작성하고, 유지보수하고, 삭제하기 가장 어려운 부분을 나머지 부분으로부터 격리시키는 것이다.
달리 말해 재사용 여부를 중심으로 모듈을 만드는 것이 아니라, 바꿀 수 있는지 여부를 중심으로 모듈을 만드는 것이다.

안타깝게도 어떤 문제들은 서로 깊이 엮여 있어서 다른 문제들보다 분리하기가 더 어렵다. 단일 책임 원칙에 따르면 ‘하나의 모듈은 하나의 어려운 문제만 다뤄야 한다’고 하지만, 이 경우에는 ‘하나의 어려운 문제는 하나의 모듈에서만 다뤄져야 한다’는 쪽이 더 중요하다.

어떤 모듈이 두 가지 일을 하고 있다면 그건 보통 한 부분을 바꾸려면 나머지 부분도 바꿔야만 하기 때문이다. 구성요소 두 개의 상호작용을 주의 깊게 조정하는 것보다는, 차라리 간단한 인터페이스를 가진 형편없는 구성요소 한 개를 다루는 것이 더 쉬울 때가 많다.

> 내 관점에서 어떤 종류의 내용이 그 [“느슨한 결합”이라는] 약칭에 포함되는지 정의하려는 노력을 오늘은 더 이상 하지 않겠습니다. 어쩌면 그에 대한 알기 쉬운 정의를 평생 내리지 못 할 수도 있습니다. 하지만 그게 뭔지는 보면 알 수 있고, 이번 사건에 연관된 코드 베이스는 그게 아닙니다. 
> - 미 연방대법원 판사 포터 스튜어트

시스템 코드의 일부를 삭제할 때 다른 부분을 다시 작성하지 않아도 되는 것을 보통 느슨히 결합되었다고 표현하는데, 느슨히 결합된 시스템를 만드는 것보다는 그게 어떻게 생겼는지 설명하는 것이 훨씬 쉽다.
변수를 하드코딩하는 것도 느슨한 결합일 수 있고, 변수에 대해 커맨드 라인 플래그를 사용하는 것도 느슨한 결합일 수 있다. 느슨한 결합이란 무엇보다도 코드를 너무 많이 바꾸지 않고도 코드를 수정할 수 있는 것을 의미한다.
예를 들어 마이크로소프트 윈도우즈는 바로 이를 위해 내부 API와 외부 API를 구분해 놓았다. 외부 API는 데스크탑 프로그램의 라이프사이클과 연관되어 있고, 내부 API는 그 기반이 되는 커널과 연관되어 있다. 이 API를 숨겨놓은 덕분에 마이크로소프트는 소프트웨어를 너무 많이 망가뜨리지 않으면서도 유연성을 유지할 수 있다.
HTTP에도 느슨한 결합의 예시가 있다. HTTP 서버 전면부에 캐시를 두는 것이나, 그림 파일을 CDN으로 옮겨놓고 그 주소를 담은 링크만 변경하는 것이다. 두 방식 다 브라우저를 망가뜨리지 않는다.
HTTP 에러 코드도 느슨한 결합의 또다른 예다. 웹 서버에서 자주 발생하는 문제에는 고유의 코드가 주어진다. 400 에러를 받았다면 같은 요청을 보내도 똑같은 결과를 받을 것이다. 500 에러의 경우 다른 결과를 받을 수도 있다. 덕분에 HTTP 클라이언트는 프로그래머를 대신해서 다수의 에러를 스스로 처리할 수 있다.
소프트웨어를 더 작은 부분들로 분해할 때, 소프트웨어가 실패를 처리하는 방식도 고려해서 디컴포즈(decompose)해야 한다. 물론 이것도 말은 쉽지만 실제로 하기는 어렵다.

Erlang/OTP가 실패를 다루는 방식은 상당히 독특한데, 슈퍼비전 트리라고 불린다. 대강 말하자면 슈퍼바이저가 Erlang 시스템 내의 각 프로세스를 시작시키고 주시한다. 문제가 발생하면 프로세스는 종료된다. 그리고 프로세스가 종료되면 슈퍼바이저가 프로세스를 재시작시킨다.
(슈퍼바이저는 부트스트랩 프로세스가 시작시키고, 슈퍼바이저에 문제가 발생하면 부트스트랩 프로세스가 슈퍼바이저를 재시작시킨다.)
여기서 핵심은 빨리 실패하고 재시작하는 것이 에러 핸들링보다 더 빠르다는 것이다. 이런 방식의 에러 핸들링, 즉 에러가 발생하면 프로세스를 포기함으로써 신뢰성을 확보하는 것이 직관과는 반대될 수도 있다. 하지만 프로세스를 껐다 켜는 방식은 일시적으로만 발생하는 장애를 무시할 수 있도록 해준다.
에러 핸들링과 회복은 코드 베이스의 외곽에서 하는 것이 최선이다. 이는 엔드-투-엔드 원칙이라고도 알려져 있다. 이 원칙에 따르면 연결의 각 끝단에서 실패를 처리하는 것이 그 사이의 어떤 중간지점에서 실패를 처리하는 것보다 더 쉽다. 내부에서 에러 핸들링을 한다고 해도, 결국 최종적으로는 최상위 수준에서 확인을 다시 해야 한다. 어차피 상위에 위치한 매 레이어마다 에러 핸들링을 해야 한다면 내부에서 핸들링하는 것에는 아무 의미도 없다.
오류 처리는 시스템이 긴밀하게 결합되게 만드는 여러 원인 중 하나다. 긴밀하게 결합된 시스템의 예시는 여럿 있지만 그 중 하나만 콕 집어서 잘못 디자인되었다고 비판하는 것은 조금 부당할 것이다. IMAP만 빼고.
IMAP 내의 거의 모든 연산은 각자 고유한 옵션과 처리 방식을 가진다. 에러 핸들링은 매우 성가시다. 다른 연산의 결과값 한 가운데에 에러가 있을 수도 있다.
IMAP은 각 메시지를 식별하기 위해서 UUID를 사용하는 대신 고유한 토큰을 생성하는데, 그 토큰도 연산 결과가 나오는 중간에 바뀔 수 있다. 아토믹 연산(atomic operation)이 아닌 연산도 많다. 이메일을 한 폴더에서 다른 폴더로 신뢰성 있게 옮기는 방법을 찾아내는데도 25년 넘게 걸렸다. 그리고 독자적인 형태의 UTF-7 인코딩과 base64 인코딩도 사용하고 있다.
여기서 내가 지어낸 부분은 하나도 없다. 진짜로 저렇다.
그에 비하면 파일 시스템과 데이터베이스는 원격저장 시스템의 훨씬 좋은 예시다. 파일 시스템에서 사용하는 연산의 종류는 고정되어 있지만 연산을 할 수 있는 대상은 엄청나게 많다.
파일시스템에 비하면 SQL은 훨씬 더 광범위한 인터페이스인 것 같지만 동일한 방식으로 작동한다. 다양한 종류의 연산이 있고, 연산의 대상이 되는 행이 엄청나게 많다. 그리고 데이터베이스를 다른 데이터베이스로 항상 교체할 수 있는 것은 아니지만, 자체적으로 만든 쿼리 언어에 비하면 SQL과 호환되는 것을 찾기가 훨씬 쉽다.
느슨한 결합의 다른 예로는 미들웨어나 필터, 파이프라인 등이 있는 시스템이 있다. 예를 들어 트위터의 Finagle은 서비스에 공용 API를 사용한다. 덕분에 별다른 어려움 없이 타임아웃 핸들링, 재시도 메커니즘, 인증 확인 기능 등을 클라이언트와 서버 코드에 추가할 수 있다.
(내가 여기서 UNIX 파이프라인을 언급하지 않았으면 분명 누가 불평했을 것이다)
앞서 코드 레이어를 나누었는데, 이제 그 레이어 중 일부는 구현 방법은 달라도 공통적인 동작과 연산을 하는 인터페이스를 공유하게 되었다. 그리고 통일된 인터페이스를 구현한 시스템은 느슨한 결합을 잘 구현한 시스템일 경우가 많다.
건강한 코드 베이스는 완벽하게 모듈식으로 구성될 필요는 없다. 하지만 모듈 형식으로 된 부분에는 훨씬 즐겁게 코드를 작성할 수 있는데, 이는 코드끼리 서로 잘 맞아떨어지기 때문이다. 레고 부품을 가지고 노는 것이 재밌는 이유와 똑같다. 건강한 코드 베이스는 조금 장황하고 조금 반복적이지만 덕분에 동작하는 코드 사이에 충분한 공간을 남겨두어서 코드를 다루다가 손이 끼어버리는 사고가 발생할 일이 없다.
코드가 느슨하게 결합되었다고 해도 항상 삭제하기 쉬운 것은 아니지만 그런 코드는 훨씬 쉽게 교체하거나 변경할 수 있다.


## 7단계: 계속 코드를 작성하자
과거에 작성한 코드와 씨름할 필요 없이 새 코드를 작성할 수 있게 되면 새로운 아이디어를 가지고 실험하기 훨씬 쉬워진다. 모노리스 대신 마이크로서비스를 만들라는 말이 아니다. 그보다는 당신이 무엇을 어떻게 해야할지 답을 찾아내는 과정에서 시스템 상에서 이런저런 실험을 해볼 수 있도록 시스템 차원에서 지원을 해줄 수 있어야 한다는 것이다.
피처 플래그(feature flag)도 나중에 코드를 수정할 수 있게 해주는 방법 중 하나다. 보통 피처 플래그를 피처를 가지고 이것저것 실험해 볼 수 있는 방법이라고만 생각하지만, 소프트웨어를 통째로 다시 디플로이하지 않고도 변경사항을 디플로이할 수 있도록 해주는 효과도 가지고 있다.
피처 플래그의 장점을 가장 잘 활용하는 예로 구글 크롬이 있다. 구글 크롬 개발자들은 주기적인 릴리즈 사이클을 유지하려 할 때 가장 문제가 되는 부분은 오랜 기간 동안 작업을 해온 피처 브랜치를 머지하는 부분이라는 것을 알아차렸다.
피처 플래그 덕분에 새로운 코드를 작동시킬지 여부를 다시 컴파일링하지 않고도 제어할 수 있게 되었고, 기존 코드에 영향을 끼치지 않으면서도 대규모 변경사항을 작게 쪼개서 조금씩 머지할 수 있게 되었다. 그리고 여러 개의 새로운 피처들이 동일한 코드 베이스에 더 빨리 나타나게 되면서, 장기간 개발되고 있는 피처가 언제 어떻게 다른 코드에 영향을 미칠지 더 명확히 알 수 있게 되었다.
피처 플래그는 단순한 커맨드 라인 스위치가 아니라, 피처 릴리즈를 브랜치 머지나 코드 디플로이 작업과 분리시키는 방법이다. 새 소프트웨어를 출시하는데 수 시간, 수 일, 혹은 수 주가 걸릴 수도 있는 상황에서 런타임에 코드를 수정할 수 있는지 여부는 점점 더 중요해지고 있다. 사이트 신뢰성 엔지니어(site reliability engineer)에게 물어보라. 어떤 시스템 때문에 밤 중에 일어나서 일하게 될 가능성이 있다면 그 시스템을 런타임에 제어할 수 있는 능력을 가지는 것은 충분히 가치가 있는 일이다.
반복 개발하는 것 자체가 중요하다기보다는 피드백 루프가 있어야 한다는 말이다. 재사용할 수 있도록 모듈을 만드는 것보다는 구성 요소를 격리시켜서 변화에 대비해야 한다는 말이다. 그리고 변화에는 새 피처를 개발하는 것뿐 아니라 낡은 기능을 없애는 것도 포함된다. 확장 가능한 코드를 작성하는 것은 3개월 후에 돌이켜 봤을 때 내가 모든 것을 제대로 디자인했기를 바라면서 작업하는 것이다. 반면 삭제할 수 있는 코드를 작성하는 것은 이와 정반대의 가정을 가지고 작업하는 것이다.
레이어 나누기, 격리, 공용 인터페이스, 컴포지션 등 내가 이 글에서 논의한 전략들의 목표는 좋은 소프트웨어를 만드는 것이 아니라 시간이 지나도 변화할 수 있는 소프트웨어를 만드는 것이다.

> 따라서 관리자가 결정해야 할 문제는 견본 시스템을 만들고 버릴지 여부가 아니다. 어차피 그렇게 할 것이다. […] 그러니 견본 시스템을 버릴 계획을 세워라. 어차피 버리게 될테니.
> - Frederick P. Brooks Jr. 1995. The Mythical Man-Month: Essays on Software Engineering

작성한 코드를 통째로 버릴 필요는 없지만 그 중 일부는 삭제해야 할 것이다. 좋은 코드는 한 번에 제대로 만든 코드가 아니다. 좋은 코드는 나중에 방해가 되지 않는 레거시 코드다.
좋은 코드는 삭제하기 쉽다.

출처: https://harfangk.github.io/2016/10/30/write-code-that-is-easy-to-delete-not-easy-to-extend-ko.html
