# Go

## 1. Go 언어의 특징
- 높은 생산성 : 같은 기능의 코드를 더 빠르고 간결하게 작성할 수 있다.
- 빠른 컴파일 속도

## 2. 기본 문법
- 세미콜론(;)은 구문분석을 통해 자동으로 붙는다.
- Package main - import - func main() 순서
- 변수 이름 -> 자료형 순서의 변수 선언

## 3. 변수 선언

``` go
var a: int // 변수 a의 자료형은 int다. 라고 읽으면 쉽다 
b := 10 // var 를 삭제하고 선언 가능
var c = 10 // 자료형 추론기능이 있어 자료형 생략 가능
```

## 4. 함수 선언

``` go 
// foo 라는 함수는 정수 하나를 인자로 받고 정수를 리턴한다.
func foo(n int) int {
	return n
}

// 함수 foo는 정수 하나와 두 정수를 인자로 받는 함수를 인자로 받고 반환값은 정수 하나를 받고 정수 하나를 반환하는 함수 
func foo(a int, func(b int, c int)) func(d int) int {
}
```

## 5. 테스트

``` go
package main

import "fmt"


func fac(n int) int {
	if n<=0 {
		return 1
	}
	
	return n * fac(n - 1)
}


func fac2(n int) int {
	result := 1
	
	for n>0 {
		result *= n
		n--
	}
	
	return result
}

func fac3(n int) int {
	result := 1
	
	for i:=2; i<=n; i++ {
		result *= i
	}
	
	return result
}

	
func main() {
	fmt.Println(fac3(5))
}
```

## 6. 작업 공간
작업 공간 내에 하위디렉토리 3개가 생성된다.

* bin: 바이너리 파일들이 들어간다고 bin이라는 이름이 붙었다. 여기에는 실행파일들이 들어가게 된다.
* pkg: 패키지 오브젝트 파일들이 들어간다. 소스가 컴파일 된 후의 코드들이 여기 들어가는 것 이지만, 실행 가능한 파일 들은 아니다. 라이브러리들이 들어간다고 보면 된다.
* src: 소스 코드들이 들어간다. 이 아래에 자신만의 패키지 경로를 작성하면 된다.

다른 오프소스프로젝트 들과 함께 호흡하기 위하여 pkg와 src 디렉터리는 해당 오픈소스 프로젝트를 다운로드할 수 있는 주소와 비슷하게 구성되어 있음.

### 예: 몽고
Go에서 몽고디비를 쓸 수 있는 라이브러리인 mgo는 labix.org/v2/mgo라는 경로를 접근할 수 있다.

__src/labix.org/v2/mgo__ 밑에 소스파일들이 들어가고
__pkg/labix.org/v2/mgo__ 밑에 패키지 파일들이 들어간다.



