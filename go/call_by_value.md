# 값 넘겨주기
go에서의 기본 변수 전달은 c언어와 같은 call by value이다.
하지만 슬라이스의 경우 c언와 같은 decay 현상이 발생하게 된다.
go의 슬라이스는 배열에 대한 포인터, 길이, 용량 이 세가지로 이루어져 있다.
그래서 슬라이스는 배열에 대한 포인터 값으로 배열의 시작주소를 알 수 있다.
슬라이스를 서브루틴으로 넘길때 call by reference와 같은 동작을 수행할 수 있다.


``` go
package main

import (
	"fmt"
)

func Mul(arr []int) {
	for i := range arr {
		arr[i]++
	}
}

func Mul2(arr *[]int) {
	nums := *arr
		
	for i := range nums {
		nums[i]++
	}
}

func main() {
	arr := []int{1, 2, 3, 4}
	Mul(arr)
 	fmt.Println(arr)
	
	Mul2(&arr)
	fmt.Println(arr)
}
```

위 두함수의 동작은 같다. 하지만 이 두 함수가 슬라이스를 어떤 파라미터 형태로 받고 있는지를 확인해보면 차이가 난다.
슬라이스의 포인터를 사용해야하는 경우는 아래와 같이 서브루틴을 통과하고 나서의 슬라이스 용량이나 크기를 변경하고 싶을 경우이다.

``` go
package main

import (
	"fmt"
)

func Mul(arr []int) {
	for i := range arr {
		arr[i]++
	}
	
	arr = append(arr, 5)
}

func Mul2(arr *[]int) {
	nums := *arr
		
	for i := range nums {
		nums[i]++
	}
	
	*arr = append(*arr, 5)
}

func main() {
	arr := []int{1, 2, 3, 4}
	Mul(arr)
 	fmt.Println(arr)
	
	Mul2(&arr)
	fmt.Println(arr)
}

```

만약 서브루틴을 통과하고 나서 배열의 원소하나를 마지막에 추가하고자 한다면, 필연적으로 길이를 변경해야 한다.
이럴 경우에는 배열의 포인터와 용량 또한 변경이 일어날 수 있으므로 포인터를 전달해줘야한다.

포인터로 넘어온 값은 * 을 앞에 붙여서 값을 참조할 수 있고, 변수 앞에 &를 붙이면 해당 변수에 담겨있는 값의 포인터 값을 얻을 수 있다. 

