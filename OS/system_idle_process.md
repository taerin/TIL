# System Idle Process
system idle process는 시스템 유후 프로세스라고도 부른다.
윈도우 운영체제에서 더 잘 확인할 수 있는데, 이 프로세스는 다른 실행가능한 스레드들이 CPU에 스케줄 되지 않을때 실행되는 하나이상의 커널스레드로 이루어진다.
멀티프로세서 시스템에서는 각 CPU 코어에 관련된 하나의 유휴 스레드가 존재한다.
하이퍼 스레딩이 활성화된 시스템에서는 각 논리 프로세서를 위한 유휴 스레드가 존재한다

그럼 여기서 하이퍼 스레딩이란 무엇일까?

## 하이퍼 스레딩(Hyper-Threading Technology, HTT)
인텔이 동시 멀티스레딩을 구현한 기술로, 물리상 실행 장치 한개에 가상 실행장치 두 개를 할당해 성능을 높이려는 기술이다.
운영체제는 코어 한 개당 스레드가 두개씩 추가되어 싱글코어(1개)는 듀얼 코어(2개), 듀얼 코어(2개)는 쿼드코어(4개), 쿼드코어(4개)는 옥타코어(8개), 옥타코어(8개)는 헥사 데시멀 코어(16개) 가 장착 되어있다고 인식한다.

그럼 다시 idle process로 넘어가보자.

## System idle process의 목적
유휴 프로세스와 이것의 스레드의 주요한 목적은 스케줄러에서 특별한 경우를 제거하는 것이다.
유휴 스레드가 없다면 실행 가능한 스레드가 존재하지 않는 경우가 있을 수 있다. 유휴 스레드들이 항상 Ready상태에 있기 때문에 이런 상황을 방지할 수 있다.
그러므로 유휴 프로세스의 CPU 시간 속성은 시스템의 다른 스레드들에 의해 필요하지 않거나 원하지 않는 CPU 시간의 양을 나타낸다. 간단하게 말하면, CPU가 놀고있을 때 점유하는 프로세스인 것이다.
그렇기 때문에 언제나 우선순위가 가장 낮다.

이러한 유휴 프로세스의 기능 때문에 사용자가 보기에는 이 프로세스가 CPU를 독점하고 있다고 볼 수도 있다. 그러나 유휴 프로세스는 컴퓨터 자원을 사용하지 않는다. 그냥 단순히 유휴 프로세스가 점유하고 있는 시간은 CPU가 사용되고있지 않는 시간을 가르킨다. 
만약 Windows 작업관리자에서 System Idle Process항목이 CPU를 98% 차지하고 있다고했을때, 실제 유휴 프로세스가 98%를 사용하고 있는것이 아닌 실제로 사용하고 있지 않은 여유 CPU 자원을 나타낸다.

또한 윈도우 2000 이후로 시스템 유휴 프로세스의 스레드들은 또한 CPU 절전을 목적으로도 구현했다. 
