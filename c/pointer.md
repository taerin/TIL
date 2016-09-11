# Pointer

* pointer의 크기 = 4byte (32bit 컴퓨터 기준)
32bit / 64bit : CPU가 한번에 처리할 수 있는 연산의 크기

#### 배열과  포인터

```c
int arr[10];
// arr = &arr[0]
//     = *int (& => * / arr[0]은 int 타입의 원소)   
```
* 컴파일러는 배열의 이름(arr)을 배열의 첫번째 원소의 주소로 해석합니다.(decay : 원래는 아닌데 부식되고 오염된다는 뜻입니다.)

* 변수 arr의 실제 타입은 무엇인가?
변수의 타입을 알아내는 법은 이름을 가리고 나머지가 타입이 됩니다!

예) int a => int 타입
	char b => char 타입

그러므로 __int arr[10] => int[10] 타입__

#### decay 예외
1) sizeof 
2) addressof => &

* 주소값연산을 할땐 원래 타입으로 써주어야 합니다. (+ 배열의 크기는 맨 뒤에 와야합니다.)

&arr => &int[10] => int[10]* p => int (*p)[10];
int (*p)[10] = &arr; 

```c
void foo(int *p)
{
	// ...
}

int main ()
{
	int arr[10];

	foo(arr, sizeof(arr)/size(arr[0])));
}
```

#### 배열 parameter
배열은 배열의 크기와 함께 넘겨야 합니다..
```c
int arr[10];

printf("%lu\n", sizeof(arr)); // 10 * 4byte = 40byte;
printf("%lu\n", sizeof(arr)/sizeof(int)); // 배열의 크기40 / 4 = 10개;
```
하지만 만약 배열을 int[10] 에서 char[10]으로 변경하자고 해봅시다.
이때는 배열을 사용하고 있는 곳들을 찾아 자료형을 바꿔야하는일이 생깁니다.

```c
// int arr[10];
char arr[10];

printf("%d\n", sizeof(arr)/sizeof(arr[0]));
```
이렇게 해주면 배열 arr의 자료형이 바뀌어도 다른 곳에서는 변경이 필요 없습니다. -> OCP를 만족시키는 설계가 됩니다. 
