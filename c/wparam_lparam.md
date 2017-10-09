# wParam, lParam
PARAM은 파라미터(Parameter)의 줄임말이다.(이것은 대충 감으로 잡았으리라 본다)

그렇다면 앞에 붙은 W, L은 무엇이란 말인가??
먼저 W는 WORD의 약자이다. 즉 WPARAM이란 WORD PARAMETER라는 결과를 얻을수 있다...

다음으로 L은 LONG의 약자이다.  즉 LPARAM이란 LONG PARAMETER라는 결과도 얻을수 있을 것이다.
일반적으로 사용을 할때는 WPARAM으로는 핸들 or 정수를 받아들일때 사용한다.
필자는 DWORD형을 받아들이는 것을 보고 이 글을 쓰게되었다.(저놈은 먼데 값을 마음대로 받아들이나 라는 허접한 생각에...)
LPARAM은 포인터 값을 받아들일때 사용한다.
즉 실제 데이터를 받아들일때는 WPARAM을 포인터로 넘겨받을때는 LPARAM을 사용하면된다!
[출처 WPARAM, LPARAM이란?|작성자 SniperAaron](http://blog.naver.com/sniper209/70093975051)
