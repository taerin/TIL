# 구조체(Struct) 

구조체 : 사용자 정의 타입
		 데이터를 캡슐화 한다.

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

