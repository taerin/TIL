# lvalue와 rvalue
모든 C++ 식은 lvalue 또는 rvalue입니다.
lvalue는 단일 식을 넘어 지속되는 개체를 참조합니다.
lvalue를 이름이 있는 개체로 생각할 수 있습니다.
수정할 수 없는(const) 변수를 비롯한 모든 변수가 lvalue입니다. 
rvalue는 rvalue를 사용하는 식 외에서는 유지되지 않는 임시 값입니다.

	
	var a = 1;
	a = lvalue
	1 = rvalue

위와 같은 식에서 보듯 마치 lvalue 는 = 연산의 왼쪽값/ rvalue는 = 연산자의 오른쪽에 오는 것으로 구분하면 되는것 같습니다.
하지만 다음 식을 보시죠!

``` cpp
int i = 1;
int j = 2;
i = j; // lvalue = i, rvalue = j ???
```
위 코드의 첫번째, 두번째 라인까지는 별 문제없이 lvalue, rvalue를 찾을 수 있었겠지만
세번째 라인에서의 lvalue, rvalue는 어떤것이 되는 걸까요?

위 경우에는 rvalue 는 없습니다!
i,j는 모두 lvalue 이며, 컴파일러에 의해 lvalue-to-rvalue conversion 이 발생하면서
j 가 마치 rvalue 처럼 작동할 뿐 입니다.

정리하자면
	* lvalue : lvalue 는 객체를 참조하는 표현식입니다. 즉 lvalue는 메모리 위치를 가지고 있습니다.
	* rvalue : C++ 표준은 rvalue 정의할때, 제외 개념으로 정의합니다. 즉, "모든 표현식은 Lvalue 거나 Rvalue이다"
			   고로, Rvalue 는 Lvalue 가 아닌 모든것입니다. 
			   정확하게 말하자면, 메모리 공간을 가지지 않는 임시적인 값입니다.

### Points on Lvalues and Rvalues
1) Numeric literals, 3 과 3.14159, 이것들은 Rvalues 이다. character literals, 예를 들면 'a' 도 마찬가지이다.
2) enumeration 상수 구분자는 Rvalue 이다. 예를 들면:
``` cpp
    enum Color { red, green, blue };
    Color enumColor;
    enumColor = green;    // Fine
    blue = green;         // Error. blue is an Rvalue
```


3)  binary + 연산자의 결과는 항상 Rvalue 이다.
``` cpp
m + 1 = n  // Error. 왜냐하면 (m+1) 는 Rvalue.
```

4) 단항 & (address-of) 연산자는 그것의 피연산자로 Lvalue 를 필요로 한다.
	즉, &n는 n이 Lvalue 인 경우에만 유효한 표현식이다. 그러므로, &3 같은 표현식은 에러이다.
	다시한번 말하자면, 3 은 객체를 참조하고 있지 않다. 그러므로 그것은 주소를 이용해서 불러낼수 없다.
	비록 단항 & 연산자가 피연산자로 Lvalue 를 필요로 하지만, 그 결과는 Rvalue 이다.
``` cpp
int n, *p;
p = &n;     // Fine
&n = p;     // Error: &n is an Rvalue
```



5) unary & 과는 대조적으로, unary * 는 그 결과로 lvalue 를 만들어 준다.
	non-null(유효한) 포인터 p 는 항상 객체를 가르킨다. 그러므로 *p 는 lvalue 이다. 예를 들면:
``` cpp
int a[N];
int *p = a;
*p = 3;  // Fine.

// 그 결과가 Lvalue 이긴 하지만, 피 연산자는 Rvalue 가 될수도 있다.
*(p + 1) = 4; // Fine. (p+1) 는 Rvalue
```

6) Pre-increment 연산자 표현식의 결과는 LValues
``` cpp
int nCount = 0;   // nCount 는 영속 객체를 나타내며 그러므로 Lvalue 이다.
++nCount;          // 이 표현식은 Lvalue 이다.왜냐하면
// 이것은 변경이후 nCount 객체를 가르키기 때문이다.

// 이것이 Lvalue인 것을 증명하기 위해, 다음 연산을 할수 있다
++nCount = 5;    // Fine. nCount 는 5 이다.
```

7) 리턴타입이 오직 참조인 경우에만 함수 호출은 Lvalue 이다
``` cpp 
int& GetBig(int& a, int& b)    // 함수 호출을 Lvalue 로 만들기 위해 참조를 반환
{
	return ( a > b ? a : b );
}

int main()
{
	int i = 10, j = 50;
	GetBig( i, j ) *= 5;
	// 여기서, j = 250. GetBig() 은 j의 참조를 리턴한다.
	// 그리고 그것에 5가 곱해진것으로 저장된다.
}

```



8) 참조는 그냥 이름이다. 그래서 Rvalue 에 묶인 참조 그 자체는 Lvalue 이다.
``` cpp
int GetBig(int& a, int& b)    // 함수 호출을 Rvalue 로 만들기 위해 int를 리턴
{
	return ( a > b ? a : b );
}

void main()
{
	int i = 10, j = 50;
	const int& big = GetBig( i, j );
	// 'big'를 GetBig()의 리턴값(Rvalue)에 대해 Lvalue로 바인딩한다.

	int& big2 = GetBig(i, j); // Error. big2 가 const가 아니므로
	// temporary 는 non-const reference 에 바인드 불가.
}
```



9) Rvalues 는 temporaries 이고 메모리 영역을 가르킬 필요가 없다. 그러나 어떤 경우에는 메모리를 가르킬수 있다. 하지만 이런 임시값에 대해서 작업하는것은 권장되지 않는다.

``` cpp
char* fun() { return "Hellow"; }

int main()
{
	char* q = fun();
	q[0]='h';    // 예외발생, fun() 이 임시 메모리를 리턴하는데 거기 접근하려 한다.
}
```


10) 후위 증가(Post-increment) 연산자 표현식의 결과는 RValue 이다.
``` cpp
int nCount = 0;  // nCount 는 영속 객체를 나타내므로 Lvalue
nCount++          // 이 표현식은 Rvalue이다. 객체의 값을 복사하고,
// 변경한후 임시 복사를 리턴하기 때문이다.

// 이것이 Rvalue라는것을 증명하기 위해, 다음 연산을 할수 있다.
nCount++ = 5; //Error
```

* 정리
만약 우리가 표현식의 주소를 안전하게 얻을수 있다면, 그것은 lvalue 표현식이다. 그렇지 않다면 그것은 rvalue 표현식이다.

* 주의
Lvalues 와 Rvalues 모두 변경가능 혹은 변경 불가일수 있다. 여기 예제가 있다 :
``` cpp
string strName("Hello");                           // modifiable lvalue
const string strConstName("Hello");                // const lvalue
string JunkFunction() { return "Hellow World"; /*catch this properly*/}//modifiable rvalue
const string Fun() { return "Hellow World"; }      // const rvalue
```


### Conversion between Lvalues and Rvalues
Rvalue를 필요로 하는곳에 Lvalue인 것이 사용될 수 있을까요?  그렇습니다!  가능합니다.
예를 들면,

```  cpp
	int a, b;
	a = 8;
	b = 5;
	a = b;
```

	이 = 표현식은 Lvalue 인 b를 Rvalue 로 사용합니다.
	이 경우 컴파일러는 b에 저장된 값을 얻기 위해 lvalue-to-rvalue conversion 라고 불리는 것을 수행합니다.

``` cpp
3 = a    // Error. Lvalue 가 필요한곳에 3이라는 RValue가 사용됨
```

그럼 Lvalue 가 필요한곳에 Rvalue 가 사용될수 있을까요? 아니요! 그것은 불가능합니다.


추가) 자바스크립트의 경우 rvalue가 리턴되는 형태의 연산을합니다.
``` javasript
var a = 1;
// 1 출력
```
출처:http://jeremyko.blogspot.kr/2012/08/lvalue-rvalue.html
