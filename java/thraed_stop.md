# My question is if theres no way to stop a thread in Java then how to stop a thread?
Why is Thread.stop deprecated? 
왜 Thread.stop이 deprecated 됐을까요?

Because it is inherently unsafe. 
왜냐하면 그것은 선천적으로 위험하기 때문이죠.

Stopping a thread causes it to unlock all the monitors that it has locked. (The monitors are unlocked as the ThreadDeath exception propagates up the stack.)
스레드를 stop한다는 것은 lock됐던 모든 모니터들을 unlock 하도록 합니다. (모니터들은 ThreadDeath Exception이 스택에 전파됐을 때 unlock 됩니다. 
	
If any of the objects previously protected by these monitors were in an inconsistent state, other threads may now view these objects in an inconsistent state. 
만약 어떠한 객체가 이전에 이러한 불안전한 상태에 있는 모니터에의해서 보호되고있는 상태라면, 다른 스레드들은 이러한 객체가 불안전한 상태라는 것을 알지못합니다. 

Such objects are said to be damaged. When threads operate on damaged objects, arbitrary behavior can result. 
그러한 객체는 피해를 입을 수 있습니다. 스레드가 위험한 상태에 있는 객체에 연산을 하려고하면 제멋대로의 결과를 냅니다.

This behavior may be subtle and difficult to detect, or it may be pronounced.
이 행동은 미묘하기 때문에 감지하기 어려울 수 있는데 이것은 확고한 사실입니다.

Unlike other unchecked exceptions, ThreadDeath kills threads silently; thus, the user has no warning that his program may be corrupted. 
다른 unchecked exceptions와 달리, ThreadDeath 스레드를 조용히 kill 합니다. 즉 사용자는 그의 프로그램이 위험하다는 사실을 경고받지도 못하게 됩니다.

The corruption can manifest itself at any time after the actual damage occurs, even hours or days in the future.
이러한 부패는 발생한 직후에 나타날 수도 있고, 심지어 몇시간 혹은 미래의 몇일 이후에 발생할 수도 있습니다.


## The Answer: In Java there's no clean, quick or reliable way to stop a thread.
> 자바에는 스레드를 stop할만한 분명하고 빠르고 믿을만한 방법이 없습니다.

Thread termination is not so straight forward.
스레드를 멈추는 것은 쉽지 않습니다.  

A running thread, often called by many writers as a light-weight process, has its own stack and is the master of its own destiny (well daemons are). 
종종 많은 사람들이 가벼운 프로세스라고 부르기도 하는 동작하고 있는 스레드는 그 자신만의 스택을 갖고, 스스로의 운명의 키를 쥐고있기도 합니다. (물론 데몬스레드도 그렇습니다.)

It may own files and sockets. It may hold locks. 
이 스레드는 파일들과 소켓들을 가질 수도 있습니다. 스레드가 lock을 홀드할 수 도 있죠.

Abrupt Termination is not always easy: Unpredictable consequences may arise if the thread is in the middle of writing to a file and is killed before it can finish writing. 
갑작스러운 종료는 항상 쉽지않습니다: 만약 스레드가 파일을 쓰는 도중 그리고 이것이 쓰기를 완료하기전에 종료된다면 예상할 수 없는 결과가 발생할 수 있습니다. 

Or what about the monitor locks held by the thread when it is shot in the head?
스레드가 머리에 총을 맞았을때(급작스럽게 종료됐을 때) 스레드가 보유한 모니터 lock은 어떻게 될까요?

Instead, Threads rely on a cooperative mechanism called Interruption. This means that Threads could only signal other threads to stop, not force them to stop.
대신에, 스레드는 Interruption 이라고 불리는 협력하는 메커니즘에 의존합니다. 이 Interruption이라는 것은 스레드를 강제적으로 종료하는 것이아니라 오직 종료하고자 하는 스레드에게 signal을 주는 것을 의미합니다.

The concept is very simple. To stop a thread, all we can do is deliver it a signal, aka interrupt it, requesting that the thread stops itself at the next available opportunity. 
이 개념은 매우 간단합니다. 스레드를 멈추기위해서 우리가 할 수있는 것은 시그널을 전달하는 것입니다. (interrupt 라고도 불립니다.) 스레드에게 기회가 있다면 스레드를 멈추라고 요청을 보내는 것입니다.

That’s all. There is no telling what the receiver thread might do with the signal: it may not even bother to check the signal; or even worse ignore it.
그것이 다입니다. 수신자 스레드가 신호와 어떤 역할을하는지 알 수는 없으며 신호를 확인하는 데 별 어려움이 없을 수 있습니다. 또는 심지어 그것을 무시합니다.

