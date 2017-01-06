# Thread (쓰레드)

## Thread란 실행흐름이다.
Thread의 사전적 의미는 실타래로 새로운 실행흐름을 만들어 내는 것이다.
모든 프로그램은 function(method)를 호출하며 동작하게 되는데 함수를 호출할 때의 context가 무엇이냐가 중요하다. 

### sp, bp, pc(ip)
* sp : 함수의 호출은 스택을 이용 스택에 대한 포인터(sp)
* bp : 어떤함수에서 실행되고있느냐(bp) 
* pc/ip :  프로그램 카운터로 코드의 어느부분을 실행할 차례인지를 가리킴

이 세개의 정보가 가장 중요하고 이것이 CPU Context 즉,  CPU  레지스터정보이다.

이 정보를 OS내부에서 Kernel Object라고하는 구조체로 관리되고 이것은 리눅스에서 task_strunct 구조체로 관리된다.

프로세스가 생성되면 가상메모리를 사용한다.
스레드를 생성하면 프로세스와 동일한 task_struct가 생성되고 프로세스가 가리키고있는  mm(가상메모리)을 얕은 복사한다.
같은 페이지 테이블을 사용한다는 것은 같은 가상주소를 사용한다는 것으로, 같은 주소공간 내에서 실행되는 실행흐름이다.

## Thread의 장점
* 프로세스의 주소공간 내에서 동작하기 때문에 데이터 공유가 쉽다.
* OS가 실제로 스케쥴링하는 단위는 프로세스가 아니라 실제로 더 작은 Thread 단위이다. 프로세스에 대한 컨텍스트 스위칭은 주소공간에 대한 스위칭도 발생해야 하지만 Thread 스케쥴링은 CPU Context(Register에 쓰인)의 스위칭만 발생하면 되므로 가벼운 Context Switching이다.
(이것은 하나의 core내 기준)

## Thread의 단점
*  하나의 스레드가 잘못된 참조로 인해 비정상적인 종료를 수행한다면 프로세스가 종료된다. 반대로 이것은 멀티 프로세스의 장점이 된다. 
이때 하나의 프로세스가 비정상 종료가 되었더라도 주소 공간이 분리되어 있으므로 영향을 받지 않는다. 또한 주소공간이 분리되어 있기 때문에 데이터 공유를 위해서 IPC를 사용해야한다.

* 데이터가 가변상태일 때 연산이 원자적으로 일어나지 않는다면 Data Race Condition(경쟁상태)가 발생하고 이를 해결하기위해 동기화가 필요하다.

## Thread를 사용하는 이유
옛날에는 Thread를 문제를 동시에 해결하기위해서 푸는 것이 아니라 블락킹연산이 있을 때 블락킹 되는 동안 스레드를 생성하여 해결.
하지만 멀티코어 시대에는 실제로 문제를 동시에 해결 할 수 있게 되어 실질적인 성능 향상을 기대할 수 있게 되었다.

## Java에서 스레드 생성하기
* Main Thread : main 함수가 Thread Entry Point Method가 되어 생성된다. 메인함수가 리턴하거나 메인함수가 종료되었을 때 끝이난다. 
* 윈도우에서는 프로세스가 environment(환경)을 관리하면 스레드는 실행흐름을 관리하는 주체다. Thread는 어떠한 동작을 할 것인지를 사용자가 결정해주어야 한다.

## Thread를 만드는 방법
	1. Thread 상속 => Template Method Pattern => 공통의 기능은 공유하여 사용 가능  
	2. Thread에 Runnable 주입 => Stratagy Pattern => 정책의 재사용 가능


1. Thread 상속
``` java
// 이떄는 꼭 Samplae Thread is Thread 라는 is-a  관계가 성립될 때 사용해야 한다.
class SampleThread extends Thread{

	// Thread Entry Point Method
	@Override
	public void run () {
		System.out.println("Sample Thread - " + currentThread().getId());
	}
}

public class Sample {
	public static void main(String[] args){
		SampleThread thread = new SampleThread();
		thread.start();

		try {
			thread.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	
	}
}
```

2. Runnable 주입

``` java
class SamplePrinter implements Runnable{
	@Override
	public void run () {
		System.out.println("Sample Thread - " + currentThread().getId());
	}
}

public class Sample {
	public static void main (String[] args) {
		Runnable runnable = () -> System.out.println("xxx");
		new Thread(runnable).start();

		// Thread를 매번 생성
		new Thread(new SamplePrinter()).start();
		
		// Thread Pool
		ExecutorService executorService = Executors.newCachedThreadPool();
		service.excute(new SamplePrinter());
	}
}

```
