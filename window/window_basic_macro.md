# Macro
기본 매크로 함수들을 알아보기 전 WORD에 대해 알아보자.
워드(word)는 하나의 기계어 명령어나 연산을 통해 저장된 장치로부터 레지스터에 옮겨 놓을 수 있는 데이터 단위이다. 메모리에서 레지스터로 데이터를 옮기거나, ALU을 통해 데이터를 조작하거나 할 때, 하나의 명령어로 실행될 수 있는 데이터 처리 단위이다. 흔히 사용하는 32비트 CPU(ARM 등)라면 워드는 32비트가 된다.

WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE 와 같은 마우스 관련 메시지들은 lParam 변수에 마우스 좌표가 전달된다. 
즉, x 좌표(하위 16비트)와 y 좌표(상위 16비트)가 32비트 lParam 변수에 합쳐진 형태로 전달되기 때문에 좌표를 사용하기 위해서는 아래와 같이 분리해서 사용해야 한다.

``` c
int x_pos = LOWORD(lParam);
int y_pos = HIWORD(lParam);
```

하지만, 프로그램을 하다보면 x 좌표가 하위 16 비트에 존재하는지 또는 상위 16비트에 존재하는지 혼동하는 경우가 많은데, 이 문제를 해겨하기 위해서 아래와 같은 매크로 함수가 제공된다.

``` c
int x_pos = GET_X_LPARAM(lParam);
int y_pos = GET_Y_LPARAM(lParam);
```

GET_X_LPARAM 와 GET_Y_LPARAM 매크로 함수의 정의는 아래와 같다.

``` c
#define GET_X_LPARAM(lp)  ((int)(short)LOWORD(lp))
#define GET_Y_LPARAM(lp)  ((int)(short)HIWORD(lp))
```
