# Functional Programming
함수형 프로그래밍은 선언형 프로그래밍으로 함수를 조립해서 문제를 해결하는것에 중심을 둔 프로그래밍 방법입니다.
세부구현이나 알고리즘을 코드에 직접 구현해주어야 하는 명령형 프로그래밍과 대비되는 방법입니다. 
명령형 프로그래밍의 단점중 하나가 코드가 일반화 되지않고 그 상황에 강한 결합이 되어있어 재사용이 어렵다는 점인데, 함수형 프로그래밍은 조각조각의 함수를 조립해서 문제를 해결할 수 있다는 점에서 장점을 갖습니다.
이렇게 되었을 때 비로소 코드의 가독성이 좋아지고, 병렬성을 최대화 할 수 있습니다.

함수형 프로그래밍에서 이러한 장점을 가지고 가려면, 함수는 부수효과(side effect)가 없는 순수함수여야 하고, 함수자체가 변수나, 배열, 인자, 리턴될 수 있도록 일급함수(first class) 취급되어야 합니다. 
하나의 객체로 취급되어야 하는 일급취급의 함수, 부수효과가 없는 순수함수와 더불어 함수형 프로그래밍에서 중요한 또 하나는 불변객체입니다.
한번 정해진 값은 바뀌지 않는다는 것인데요. Java에서 보면 primitive type 뿐만 아니라 Collection에 해당하는 자료 구조들에도 똑같이 적용됩니다. List를 하나 만들어서 추가/삭제하는 대신 추가가 필요하면 추가된 새로운 List를 만들고, 삭제가 필요하면 삭제된 새로운 List를 만드는 식입니다. 이러한 자료 구조를 Persistent Data Structure 라고 부릅니다.
한 객체의 상태를 계속해서 변경하는 것이아니라 변경되었다면 새로운 객체를 새로이 생성하는 방법입니다. 
불변객체로 함수를 조립하여 원하는 형태의 데이터를 생성하는 것이 가능하고, 프로그램의 병렬성에도 기여를 할 수 있습니다.

-----
swift의 struct는 밸류 타입의 객체인데,  선언된 struct의 프로퍼티 값을 변경하고자 한다면 mutating 이라는 키워드를 사용해야만 프로퍼티가 변경됩니다. 이는 struct가 불변객체의 형태로 사용되기를 원한 설계방법이 아닐까 생각해봅니다.