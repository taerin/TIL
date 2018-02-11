# C언어에서 주의해야 할 문법
C언어는 참 가깝고도 먼 언어에요...
그래서 저는 이 문서에 제가 헷깔렸던 C언어 문법들을 차차 정리해 나갈 예정입니다.

## 1. if 연산
C언어는 boolean 변수가 없어요. 그래서!

값 | 결과
---|------
non zero | 참
zero (0) | 거짓

위와 같이 조건을 판단하게 됩니다.

그럼 여기서 하나더 질문!
C언어에서의 0은 총 3가지로 표현될 수 있어요.

값 | 타입
---|------
0 | int
'\0' | char
NULL | void *

이렇게요! 그러니까 조건문에서 문자열의 마지막 '\0' 을 만나면 탈출해라 라는 조건도 작성할 수 있어요. '\0'도 char로 표현한 0이니까 __거짓__ 으로 판단합니다.

## 2. string 과 배열

``` c
int main () 
{
	char str[10] = "hello";
	
	int str_count = strlen(str);
	int str_arr_size = sizeof(str);

// --------
	char str2[] = "hello";
	
	int str2_count = strlen(str2);
	int str2_arr_size = sizeof(str2);
}

``` 
위와 같은 코드에서 str_count의 값은 얼마일까요? 
답은 5 입니다!

str_arr_size의 값은요?

답은 10입니다.
strlen() 함수는 문자열 마지막에 포함된 널 문자열을 제외한 실제 string 카운트만을 계산해주고,
sizeof() 연산 함수는 실제 배열의 크기를 계산해요.

그렇다면 배열의 크기를 명시적으로 지정하지 않은 경우는 어떨까요?
sizeof() 함수는 null 문자를 포함하여 배열의 크기를 계산하기 때문에 6개가 나오게 됩니다.


## 애매모호한 조건들

``` c
if (a = 3) // 3으로 판단되어 non-zero 이므로 true로 판단!
{
	console.log("true");
}
``` 

= 를 하나 누락해서 코드를 작성하는 위와 같은 실수가 잦으니까 아예 아래와 같이 쓰는 경우도 있어요!

```c
if (3 = a) // 컴파일 에러!
{
	console.log("true");
}
``` 

=를 하나 누락해서 써도 컴파일타임에서 에러가 발생하니 차라리 안전하다고 판단됩니다.

## 변수 선언시 타입의 애매모호성
C언어에서 포인터변수를 사용할때는, 

``` c
int *p;
```

처럼 띄어쓰기를 해서 쓰는것을 권장해요. 애매모호성을 방지하기 위함이에요!
그럼 어떤경우가 헷깔리는지를 알아볼께요!

``` c
int a, b, c;
```

위 코드에서 a, b, c의 타입은 각각 무엇일까요?
a, b, c  모두 int형이에요!

그러면 아래 코드는 어떤가요? 

``` c
int *a, b, c;
```

a만 int형 포인터 변수이고, b와 c는 int 타입인것을 확인할 수 있어요.
하지만 제가 아래와 같이 쓴다면요?

``` c
int* a, b, c;
```

a, b, c가 int* 타입이라고 착각하기 쉽지만, 이 결과는 위와 같아요. 
포인터 연산자 *가 어디에 붙어도 컴파일상에 어떠한 문제가 없기때문에 이러한 문제가 발생한답니다.
그러니 *를 int *p 와 같이 변수명 바로 앞에 붙여쓰기로 해요:) ! 

## 배열의([])와 포인터 연산자(*)의 우선순위
배열 기호와 포인터 연산자 둘중의 우선순위는 배열의 기호([])가 더 높습니다.
그래서 포인터 연산자로 나타내기 위해서는 (*p) 이런식으로 묶어주는 것이 필요한데요.
예를 한번 들어볼게요.

``` c
void foo(int (*p)[3])
{
	//
}

int main() 
{
	int arr[2][3]; // 
	foo(arr);

	// 배열의 이름은 배열의 첫번째의 원소의 이름으로 해석되므로
	// arr
	// arr[0]
	// arr[0] 의 타입은 int[3]
	// int[3] 의 주소값을 담을 포인터 변수가 필요합니다.
	// int *p[3] 이렇게요! 하지만
	// 우선순위가 배열 기호([])가 더 높기때문에 (*) 포인터 연산자를 변수의 이름과 함께 감싸주어야 합니다.
	// 그러므로 foo()의 함수의 argument 타입은
	// int (*p)[3] 이 되는 것이죠!
}
```

위 예제의 주석에 자세히 설명해놓았으니 주의해서 봅시다.

## 배열의 이름의 비밀
앞서 설명했던 주의사항에서 '배열의 이름은 배열의 첫번째 원소의 시작주소로 해석된다'라는 것이 중요해요.
하지만 여기서 2가지 예외가 있습니다.

예외 1. sizeof() 연산자

``` c
int arr[3];
int size = sizeof(arr);

printf("size: %d", size); // 주소값의 사이즈 8이 아닌 12가 출력됨 
```

sizeof() 연산은 (배열의 크기 * 타입의 크기) 로 계산됩니다.

예외 2. & 연산자

``` c

foo(int (*p)[3])
{
 	// 
}

int main()
{
	int arr[3];
	foo(&arr);
}
```
위 예에서 보듯이 &연산자와 배열의 이름이 함께 쓰이면 int[3]로 해석되게 되어, foo함수의 argument의 타입은 int[3]의 주소값을 담을 포인터 변수타입이 필요합니다. 

## 포인터와 배열의 연산이 호환되는 이유
배열의 연산은 포인터의 연산으로 변환되기 때문이에요.

식 | 해석
---|-----
포인터 + 상수 | 주소값 + (상수 * 포인터 대상체 타입 크기)
포인터 + 상수 | 주소값 - (상수 * 포인터 대상체 타입 크기)
포인터 - 포인터 | 주소값 차 / 대상체 타입 크기 => 사이에 원소가 몇개 들어갈 수 있는지 계산 가능

``` c
int main{
	int arr[5] = {1, 2, 3, 4, 5};
	
	printf("%d\n", arr[3]);     // 4
	printf("%d\n", *(arr + 3)); // 4
	printf("%d\n", 3[arr]);     // 4 
}
```

## .rodata
.rodata 에는read only data를 모아 저장해두는 곳입니다.
read only이기 때문에 데이터를 여기에 저장된 내용을 변경하고자하면 예외가 발생하게 됩니다.
.rodata 에 저장되는 예를 하나 들어볼게요.

``` c
char *str = "hello";
``` 

여기서 str은 "hello"를 담고있는 char 배열이 아니라, "hello"라는 텍스트를 저장하고있는 .rodata내의 메모리 주소를 가리키고 있는 변수에요.
그러니 str은 영역을 가리키는 메모리주소를 가리키고 있고, 이 주소에 저장된 내용인 "hello"는 read only의 정보이기 때문에 내용변경이 불가능합니다.

## 변수의 저장 영역
프로세스의 4계층은 text / data / heap / stack 으로 이루어지죠.
함수는 stack에서 실행되기 때문에, 함수 내에서 선언한 지역변수들 또한 stack영역에 생성됩니다.
함수의 실행은 stack 포인터를 -(위로 옮기는 것을 빼는 것으로 표현)해가면서 실행하게 되는데, 
만약 char a나, char a[1000] 이라는 지역변수를 선언했다고 할때 단순히 스택 포인터를 +1000 이나 +1 만큼씩 단순 계산해서 움직이면 되기때문에 생성의 비용이 크지않아요. 생성의 매커니즘이 위와 같다면 파괴도 마찬가지입니다.
그러니 사이드 이펙트가 발생할 가능성이 큰 전역변수를 사용하지마시고, 지역변수를 많이 사용하세요!

그럼 한 프로세스의 stack 사이즈는 얼마나 될까요?
이는 윈도우와 리눅스가 다른데요.

윈도우 - 1M
리눅스 - 8M

입니다.

## 동적 메모리 할당
언제 동적메모리 할당을 사용할까요? 바로 프로그래머가 메모리를 직접 관리하고 싶을때 사용합니다. 
동적 메모리 할당에서 가장 많은 실수를 하는부분이 바로 메모리를 할당하고, 메모리를 해제하지 않는 문제입니다. 