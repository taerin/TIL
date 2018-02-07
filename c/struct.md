# 구조체(Struct) 
구조체란 사용자 정의 타입으로 데이터를 캡슐화 하기 위해 사용한다.
데이터 캡슐화를 좀 더 이해하기 쉽게 설명하자면, 캡슐 알약을 생각하면된다. 캡슐 알약 속에는 여러가지 기능들을 하는 각기 다른 가루약들을 하나의 캡슐로 모아둔 것인데, 구조체 하나로 내부의 데이터들을 하나로 취급할 수 있음을 뜻한다.

```c

struct student
{
	 char name[32];
	 int age;
}

//  아래 함수처럼 사용되면 구조체의 크기만큼 항상 복사가 일어납니다.
// => 포인터를 사용하는 것이 효과적입니다.

// call by value
void print_student(struct student s)
{
	printf("%s %d\n", s.name, s.age);
}

// call by reference
void print_student2(strunct student*p)
{
	strcpy(p->name, "AAA");
	printf("%s %d\n", p->name, p->age);
}


int main ()
{
	struct student s = {"Taerin", 23"};
	struct student *p = &s;

	print_student2(p);
    print_student(s);

	printf("%s %d\n", s.name, s.age);
	printf("%s %d\n", (*p).name, (*p).age);
	printf("%s %d\n", p->name, p->age);
} 

```

```c
// (*p).name == p->name 같다.
```

## struct의 사이즈
``` c
#include <stdio.h>

struct {
    char name[32];
    int age;
} person;

int main()
{
    printf("%lu", sizeof(person));
}
```

위 코드는 person struct의 크기를 출력하는 동작의 코드입니다.
결과는 어떻게 될까요? 어렵지 않아요. 

sizeof(char[32]) + sizeof(int) = 32 + 4 = 36
예상했듯 36이 나오게 됩니다.


그러면 아래 코드의 결과는 어떻게 될까요?

``` c
#include <stdio.h>

struct {
    char name[32];
    double grade;
    int age;
} person;

int main()
{
    printf("%lu", sizeof(person));
}
```

double 타입의 grade가 추가된 struct 네요. 결과는 그럼 36 + 8 = 44가 나와야 하겠죠?
하지만 결과는 48이 나오게 됩니다. 그 이유는 무엇일까요?

위에서 말했든 struct는 메모리상에서 연속적인 위치를 차지하게 됩니다.
메모리의 크기를 결정할때 몇가지 규칙이 작용하는데요.

1. 구조체의 멤버 중 가장 큰 크기를 가지는 필드의 크기로 정렬하는 형태로 구현되어 있다.
2. 필드의 메모리 위치는 4의 배수 / 8의 배수로 위치한다. 

위 student의 메모리는 
[       char[32]       ][  int 4 [][][][] ] [   double 8   ] 
int 의 크기 뒤에 4byte의 공간이 추가적으로 할당된것이 보이시나요?
바로 첫번째 규칙이 적용되어 8의 크기로 정렬되어야 하기 때문입니다

