https://news.realm.io/kr/news/doios-natasha-murashev-protocol-oriented-mvvm
# Introduces protocol-oriented MVVM
Swift에서 레퍼런스 타입 대신 밸류 타입을 사용하는 것은 Objective-C 보다 쉬우며, 이해하기 쉽고 에러가 적은 코드로 개선하는데 도움이 됩니다. 그러나 공유해서 사용해야 하는 상황에서는 이런 장점을 살리지 못하고 subclassing을 하는 실수를 하기 쉽습니다. do{iOS} 2015에서 MVVM에 대해 소개한 이 강연에서, 프로토콜을 사용하는 방법과 subclass에서 벗어나는 방법을 알아 보세요. 프로토콜 지향 프로그래밍에 대해 익히고 적용하는 등, Swift 2.0의 장점을 살리고 코드를 개선하기 위해 Natasha가 학습한 과정을 차근차근 설명해 줍니다.

## Swift에서는 왜 코드를 단순화할까요?
objective-C를 사용하는 개발자로써, 처음 Swift가 나왔을 땐 Swift 내부에 Objective-C 코드를 쓰는 방식으로 시작했고 레퍼런스 타입을 사용했습니다. 객체 지향 프로그래밍이 익숙했으므로 모든 것을 클래스로 만드는 것부터 시작하곤 했습니다. 마치 Objective-C의 태생처럼요.

그때까지만 해도 가끔 normal enum보다 복잡한 enum을 사용하기도 했기 때문에 나름 만족하고 있었습니다. 하지만 여러 행사와 강연을 다니고, 특히 Swift 복잡성 제어와 밸류 타입에 대한 [Andy Matuschak의 강연](https://news.realm.io/news/andy-matuschak-controlling-complexity/) 을 듣고 나자 생각이 확 달라졌습니다. 그때까지는 Swift의 struct를 알고는 있었지만 Swift로 넘어간 Objective-C 개발자로써 클래스가 훨씬 더 자연스러웠죠.
그 인상적인 강연을 들은 후에는, 이제 모든 것에 밸류 타입을 사용해야겠다고 생각했습니다. 강연에서 밸류 타입을 사용하는 Swift 표준 라이브러리를 보여줬고, 언어 창시자들도 밸류 타입을 사용하니까요. 제 작업을 열어서 새 파일을 만들고 밸류 타입으로부터 시작해 봤습니다.

처음에는 “와, 나는 Swift 개발자야, struct를 사용하지!” 하는 마음에 즐거웠지만 subclass를 만들어야 하는 시점에서 괴로워졌고, 어떻게 이 장벽을 넘어서야 할지 모르겠더군요. 그러다가…


