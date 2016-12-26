# 메모리 관리

## 주소 바인딩
* 프로세스에게 메모리 주소 공간을 할당.
* 프로그램의 실행 단계 별 주소 표현 방식 
	1) 소스 프로그램: 심벌 (symbol) 형태 (변수의 이름)
	2) 컴파일러 (compiler): 재배치 가능 (relocatable) 주소 ‒ 상대 주소 (relative address)
	3) 연결 편집기 (linkage editor, linker) 혹은 적재기 (loader) ‒ 프로세스 주소 공간의 절대 주소(absolute address) -> 실제 물리 주소를 말하는 것이 아니다. 32비트 기준으로 하나의 프로세스가 0번지부터 4GB의 주소를 갖게 되는데 이 공간 안에서의 주소를 뜻하는 것.

	- 주소 바인딩은 Runtime시에 동적으로 시행된다.

## 논리 (logical) vs 물리 (physical) 주소 공간
* 물리 주소 ‒ 메모리 하드웨어의 실제 주소
* 논리 주소 ‒ CPU/프로세스가 생성(요청)하는 주소, 각 프로세스에게 주어지는 전용의 메모리 공간, 가상 주소 (virtual address)
-> 논리 주소 변환이 필요하다. 그리고 매번 주소를 변환하여 접근해야하므로 빠른 변환 속도가 필요 -> 하드웨어적인 구현 필요(MMU)

## 동적 적재 (Dynamic Loading)
프로그램 내의 루틴(routine)이 호출되는 시점에 적재

### 동적 적재의 장점
* 사용되지 않는 루틴은 메모리에 적재되지 않는다. 
* 사용 빈도가 낮고 크기가 큰 루틴에 유용 (오류 처리 루틴 등)

## 동적 연결 (Dynamic Linking)
컴퓨터에서 프로그램을 실행하는 도중에 필요한 프로그램 모듈을 결합하여 실행을 속행하는 경우의 결합 방식을 말한다. 
* 공유 라이브러리 : 라이브러리 루틴을 여러 프로그램이 공유(메모리 사용량 감소)

## 스와핑 (Swapping)
CPU에서 실행 중이지 않은 프로세스의 메모리 이미지를 저 장장치로 이동시킴으로써 메모리 사용의 효율성 증가시키는 방법

### 스와핑과 문맥 교환 (Context Switch)
* 디스패처(dispatcher)는 Ready queue의 다음 프로세스가 메모리에 없다면, swap in을 시킨다. 만약, 메모리 공간이 부족하다면, 다른 프로세스를 swap out 후 swap in을 한다.

* 평범한 스왑 방식은 실제 시스템에 적용하기 어렵다. 왜냐하면 스왑의 속도는 하드디스크의 속도에 의존하게 되는데, 하드디스크는 너무 느리기 때문. 따라서 디스크 내에 별도의 스왑을 위한 공간을 마련해 사용한다.

## 메모리 할당 방법
* 연속 메모리 할당 방법 : 하나의 프로세스를 연속된 메모리 공간에 할당하는 방식. 구현이 쉬우나 공간을 효율적으로 사용하지 못한다.

* 동적 메모리 할당 방법 
- 최초 적합 (First-fit) : 요청한 크기를 만족하는 첫 번째 가용 공간을 할당한다. 검색의 시작점은 알고리즘에 따라 다르며, 검색 속도가 빠르다.

- 최적 적합 (Best-fit) : 요청한 크기를 만족하는 가용 공간 중에서 가장 작은 것을 할당한다. 분할되어 남는 가용 공간 크기를 최소화 한다. 

- 최악 적합 (Worst-fit) : 가장 큰 가용 공간을 할당한다. 분할되어 남는 가용 공간이 커서 활용 가능성이 높다. 검색 속도가 느리고 메모리 이용 효율이 좋지 않다.

## 단편화(Fragmentation)
* 외부 단편화(external fragmentation)
 메모리 할당이 반복됨으로써 사용할 수 없는 작은 크기의 가용 공간이 분산되어 생기는 현상.

* 내부 단편화(internal fragmentation)
요청의 크기가 메모리의 최소 할당 크기보다 작은 경우에 발생. 즉, 4MB단위로 할당 할 수 있는데 50MB를 할당 받아야한다면 52MB를 할당 받아야할 것인데, 여기서 남은 2MB가 내부 단편화이다. 내부단편화는 외부 단편화에 비해서 큰 성능 저하나 공간낭비를 유발하지는 않는다.

-> 외부 단편화 해결이 핵심.

* 메모리 압축 : 분산된 메모리의 빈 공간을 모아서 큰 블록을 생성하는 것. 프로세스 주소 공간이 동적으로 재배치 가능해야 한다. 운영체제의 비용이 많이 드는 작업이다.(조각모음을 생각하면 이해하기 쉽다) 따라서 현실적이지는 않다.

* 페이징(paging)과 세그멘테이션(segmentation) : 한 프로세스의 논리 주소 공간을 여러 개로 분할하여 비연속적인 물리 메모리 공간에 할당하는 방식