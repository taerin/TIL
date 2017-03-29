# Dangling pointer
댕글링 포인터는 컴퓨터 프로그래밍에서 적절한 타입의 유효한 객체를 가리키고 있지 않는 포인터를 말한다.
일반적으로 댕글링 포인터는 인터넷의 죽은 링크(link rot) 형상들 처럼 유효한 목적지 주소에 대한 참조이다.
댕글링 포인터는 객체 파괴시에 발생하는데, 즉 객체에 대한 참조가 포인터 값에 대한 수정없이 삭제되거나 할당 해제돼서 포인터가 계속 할당 해제 된 메모리를 가리킬 때이다. 
시스템은 할당 해제된 메모리를 다른 프로세스에게 재할당하겠지만, 기존 프로그램이 허상 포인터를 역참조하면 메모리는 현재 전혀 다른 데이터를 갖고있을 것이므로 예측할 수없는 행동이 발생한다. 특히 프로그램이 허상 포인터가 가리키는 메모리에 쓰기를 하면, 관련되지 않은 데이터의 오염이 발생하게 되고, 이것은 찾기가 매우 힘든 오류가 된다.
참고로 리눅스, 유닉스의 경우에는 세그멘테이션 폴트가, 윈도우의 경우에는 general protection fault가 발생한다. 

객체 지향 프로그래밍의 경우 쓰레기 수집으로 허상 참조들은 참조되지 않는 객체를 파괴함으로써 예방된다. 이것은 추적이나 참조 횟수 계산 방식에 의해 보증된다. 그러나 파이널라이저(finalizer)는 허상 잠조를 예방하기 위하여 객체 재생을 요구하면서, 객체에 대한 새로운 참조를 생성할 수 있다.

## Dangling pointer의 원인
많은 언어들에서 메모리의 객체를 명시적으로 지우는 것이나 반환 시의 스택 프레임 파괴는 적절한 포인터로의 변경을 수행하지 않는다. 이 포인터는 참조가 삭제되고, 다른 목적에 쓰이고 있더라도 계속 같은 위치를 가리킨다.

``` c 
{
	char *dp = NULL;
	/* ... */
	{
		char c;
		dp = &c;
	}
	/* c falls out of scope */
	/* dp is now a dangling pointer */
}
```

만약 운영체제가 널 포인터에 대한 런타임 참조를 탐지할 수 있다면, 해결책은 내부 블록이 종료되기 직전에 dp에게 0 (null)값을 주는 것이다.
다른 해결책으로는 추후의 초기화 없이 dp가 다시는 사용되지 못하게 하는 것이 있다.
다른 흔한 경우는 malloc()과 free() 라이브러리 호출의 무질서한 호출이다. 포인터는 가리키는 메모리 블록이 할당 해제가 되면 허상 포인터가 된다. 아래에서 한 것처럼 이것을 피하기 위한 방법으로는 이것이 참조하는 것이 할당 해제가 될 경우에 포인터를 null로 리셋하는 것이 있다. 아래의 코드를 보자.

``` c
#include <stdlib.h>

void func()
{
	char *dp = malloc(A_CONST);
	/* ... */
	free(dp);         /* dp now becomes a dangling pointer */
	dp = NULL;        /* dp is no longer dangling */
	/* ... */
}
```
너무 흔한 실수로는 스택 할당된 지역 변수의 주소들을 리턴하는 것이 있다. 호출된 함수가 리턴되면, 이 변수들을 위한 공간은 할당 해제되고, 이것들은 "쓰레기 값"을 갖게 된다.

``` c
int *func(void)
{
	int num = 1234;
	/* ... */
	return &num;
}
```

함수 호출 이후에 포인터로 읽는 것은 아직 정확한 값(1234)을 반환하지만, 이후에 호출된 다른 함수가 스택 저장소를 겹쳐쓸 수 있으므로 이후에는 더 이상 정확한 값을 갖지 못한다. num에 대한 포인터가 반환되어야 한다면, num은 반드시 이 함수 이상의 유효 범위를 가져야 한다. 이것은 static으로 정의함으로써 가능해질 수 있다.

