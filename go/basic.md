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
