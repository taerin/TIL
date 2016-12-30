# Given – When – Then
Given-When-Then 공식은 User Story에 대한 수락 테스트의 작성을 안내하기위한 템플릿이다.

테스트코드를 작성하고 테스트로 검증된 코드를 가지고 실제코드를 작성하자는 TDD(Test Driven Development)는 선구자인 Kent beck 을 필두로 수 많은 발전을 해왔다. 
먼저 개발을 하고 테스트를 하는 기존 방식이 아닌 테스트 코드를 작성하고 검증된 코드를 실제 코드로 반영하자는 개념은 수 많은 개발자들에게 어떻게 보면 혁명적인 발상이였고 수 많은 개발자들의 호응을 거쳐 현재는 Agile의 대표적인 개발방법론이 되었다. 

전통적인 TDD 소프트웨어 개발 방법론에서 개발자들은 다음의 흐름을 따른다.

1. define a test set for the unit first
   첫번째로 유닛을 위한 테스트 셋을 정의한다.
2. the implement the unit
   유닛을 구현한다.
3. finally verify that the implementation of the unit makes the tests success
   마지막으로 유닛에 대한 구현이 테스트를 통과하는지 검증한다.

위의 정의는 높은 수준의 소트프웨어 요구사항이나 반대로 저 수준의 기술적 상세내역 심지어 어떠한 관점에서의 테스트에서도 각 유닛들에게 기대되는 행위들에 대해 명시적이지 않고 또 명세화 되어있지 않았다. 이에 반해 BDD는 소프트웨어 내의 각 유닛에 대해 기대되는 행위들을 명세화하면서 출발한다.

이에 Dan north와 그의 동료들은 하나의 템플릿을 만들어 채택했는데 그것은 다음과 같다.

1. 특정 값이 주어지고 (Given)
2. 어떤 이벤트가 발생했을 때 (When)
3. 그에 대한 결과를 보장해야한다 (Then)

* (Given) some context
어떤 상황이 주어지고
* (When) some action is carried out
어떤 행동이 수행되었을때
* (Then) a particular set of observable consequences should obtain
그러고나서 관찰가능한 결과의 특정 세트를 얻어야만한다.

## Given - When - Then의 예
* Given my bank account is in credit, and I made no withdrawals recently,
내 은행 계좌에 크레딧이 있고 최근에 인출을하지 않은 상황에서
* When I attempt to withdraw an amount less than my card's limit,
카드의 한도액보다 적은 금액을 인출하려고하면,
* Then the withdrawal should complete without errors or warnings
그런 다음 인출은 오류나 경고없이 완료되어야 합니다.
