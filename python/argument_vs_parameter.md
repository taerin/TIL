# Argument / Parameter
나는 이 두 용어를 자주 혼동해서 사용하는 것을 목격했고, 나 또한 헷깔리기 때문에 정리를 한다.

## Argument
함수를 호출하면서 전달하는 값을 의미한다. 즉 함수로 전달 한 __값__을 인자(Argument)라고 부른다.

## Parameter
인자와 함수를 호출하면 인자의 값은 함수 내에서 해당하는 매개변수(Parameter)로 복사되게 되는데, 함수를 선언할 때 인자가 저장될 수 있는 변수의 이름을 의미한다.

## Positional arguments(위치 인자)
인자의 가장 익숙한 타입으로 값을 순서대로 상응하는 매개변수에 복사하는 것을 말한다.

``` python
def menu(wine, entree, dessert):
	return {'wine': wine, 'entree': entree, 'dessert': dessert}

// 함수 호출
menu('chardonnay', 'chicken', 'cake')
// {'wine': 'chardonnay', 'entree': 'chicken', 'dessert': 'cake']}

```
이 방법이 가장 일반적이지만 위치 인자의 단점은 각 위치의 의미를 알아야 한다는 것이다.

## 키워드 인자
위치 인자의 혼동을 피하기 위해 매개변수에 상응하느 이름을 인자에 지정할 수 있다.
심지어 인자를 함수의 정의와 다른 순서로 지정할 수 있다.

``` python
menu(entree:'beef', dessert='bagel', wine='bordeaux')
```

위치인자와 키워드 인자를 섞어서 쓸 수 있다.

``` python
menu('fish', dessert='bagel', wine='bordeaux')
```

단 위치 인자와 키워드 인자를 함께 사용하여 함수를 호출한다면, 위치인자가 먼저 와야한다.
