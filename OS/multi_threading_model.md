# 다중 스레드 모델(Multithreading Models)
-----

많은 시스템은 사용자스레드(User Threads)와 커널스레드(Kernel Threads)를 모두 지원한다.

## Many-to-One (다대일 모델) 
많은 사용자 수준의 스레드를 하나의 커널 스레드로 맵한다.
* 사용자 공간의 스레드 라이브러리가 스레드 관리.
* 한번에 하나의 스레드만이 커널에 접근하기 때문에  multi thread 가 multi processor 에서 병렬로 작동할 수 없음.
* 스레드관리는 사용자공간에서 행해진다. -> 효율적
* 스레드가 blocking system call을 할 경우 전체가 block됨.
* 커널스레드를 지원하지 않는 운영체제에서 사용된다.
* 커널은 스레드가 한 개인것 처럼 보임

- Solaris Green Threads, GNU Portable Thread 

## One-to-One (일대일 모델)
 사용자스레드를 각각 하나의 커널스레드에 맵한다.
* 하나의 스레드가 blocking system call을 하더라도 다른 스레드가 작업 할 수 있다.
* 다중 처리기에서 다중 스레드가 병렬로 수행되는 것을 허용함.
* 사용자스레드를 생성할 때 마다 커널스레드를 생성해야한다. ->성능저하 => 스레드 수 제한시킴

- Windows NT/XP/2000, Linux, Solaris 9 and later 


## Many-to-Many (다대다 모델)
여러 개의 사용자 수준 스레드를 그보다 작거나 같은 수의 커널 스레드로 다중화(multiplex)한다.
* 개발자는 플요한 만큼 많은 사용자스레드를 생성하면 상응하는 커널스레드가 다중 처리기에서 병렬로 수행.
* 스레드가 blocking system call을 해도 다른 스레드로 스케줄 함.

- Window NT/2000, Solaris, IRIX, Digital UNIX

## Two-Level 모델
Many-to-Many과 비슷하며 하나의 사용자 스레드가 하나의 커널 스레드에 종속되는 것을 허용한다. 
* 사용자스레드가 커널스레드에 바인드 되는 것을 허용한다.
바인드된 스레드 : 사용자수준 스레드와 커널 스레드가 붙어서 스케줄링 되지 않고 계속 연결되어 있는 것

