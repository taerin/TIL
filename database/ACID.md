# ACID
ACID(원자성, 일관성, 고립성, 지속성)는 데이터베이스 트랜잭션이 안전하게 수행된다는 것을 보장하기 위한 성질을 가리키는 약어이다. 

* A: Atomicity(원자성): 트랜잭션과 관련된 작업들이 부분적으로 실행되다가 중단되지 않는 것을 보장하는 능력이다. 중간 단계까지 실행되고 실패하는 일이 없도록 하는 것이다.
* C: Consistency(일관성): 트랜잭션이 실행을 성공적으로 완료하면 언제나 일관성 있는 데이터베이스 상태로 유지하는 것을 의미한다. 데이터베이스에 존재하는 데이터가 특정한 조건을 만족해야만 존재할 수 있다면, 데이터베이스에 트랜잭션 후에도 그 조건을 만족해야만 한다는 뜻이다.  무결성 제약이 모든 계좌는 잔고가 있어야한다는 이를 위반하는 트랜잭션은 중단된다.
* I: Isolation(고립성): 트랜잭션을 수행 시 다른 트랜잭션의 연산 작업이 끼어들지 못하도록 보장하는 것을 의미한다. 이것은 트랜잭션 밖에 있는 어떤 연산도 중간 단계의 데이터를 볼 수 없음을 의미한다. 트랜잭션 실행내역은 연속적이어야 함을 의미한다.
* D: Durability(지속성): 성공적으로 수행된 트랜잭션은 영원히 반영되어야 함을 의미한다. 

[참고- wiki ACID](https://ko.wikipedia.org/wiki/ACID)
