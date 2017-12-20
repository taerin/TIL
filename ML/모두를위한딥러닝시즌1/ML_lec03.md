# ML lec 03 - Linear Regression의 cost 최소화 알고리즘의 원리 설명
## Gradient descent algorithm
cost(W,b) function의 최솟값을 찾기위한 알고리즘
이 알고리즘은 cost(W1, W2, W3...) 형태 등의 일반화된 cost function의 최소값을 찾는데도 사용될 수 있다.
알고리즘 이름에서 유추할 수 있듯 경사 하강법(傾斜下降法, Gradient descent)은 1차 근삿값 발견용 최적화 알고리즘이다. 기본 아이디어는 함수의 기울기(경사)를 구하여 기울기가 낮은 쪽으로 계속 이동시켜서 극값에 이를 때까지 반복시키는 것이다.
하지만 만약 실제 산처럼 각 경사의 시작점이 다르면 다른 최저점에 도착하기 때문에 문제가 되지만, 이 Gradient descent 알고리즘을 미분하여 그래프로 나타내게되면 아래와 같은 형태가 되어 언제나 동일한 최저점에 도달할 수 있다.

![convex_function](../images/convex_function.png)

