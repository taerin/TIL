# 심볼릭 링크 / 하드링크
## 1. 심볼릭 링크
윈도우의 바로가기 같은것. 단순히 다른 파일을 가리키고 있는 파일이다. 심볼릭 링크와 하드링크 둘다 __ln__ 명령어로 만든다.
심볼릭 링크를 만들 때는 __-s__ 옵션을 사용한다.

``` shell
ln -s target_file link_file_name
```

이렇게 만들어진 링크는 __ln -l__ 명령어를 통해 어떤 파일을 가리키고 있는지 볼 수 있다.

## 2. 하드 링크
심볼릭 링크가 이미 존재하는 파일을 가리키는 새로운 파일이라면 하드 링크는 원래 파일의 데이터에 대한 또 다른 접근 경로이다.
심볼릭 링크와 비슷하게 하드 링크도 어떤 것을 가리키지만 그 가리키는 것이 이미 존재하는 파일을 가리키는 것이 아니라 파일 시스템에 있는 데이터의 위치를 가리킨다.

	심볼릭 링크 -> 원래 파일 -> 파일 시스템의 데이터

아래는 하드 링크의 모습이다.

	하드 링크 -> 파일 시스템의 데이터 <- 원래 파일

두 링크의 차이를 가장 체감할 수 있을 때는 바로 '원래 파일'을 지웠을 때이다. 
심볼릭 링크의 경우 원래 파일을 지울 경우 파일 시스템의 데이터에 접근할 방법이 사라진다.  하지만
하드 링크의 경우 원래 파일을 지워도 데이터에 접근하는 데는 아무런 문제가 없다. 자신도 완전한 하나의 파일이기 때문이다.
그러나 일반적인 복사본과는 다르다. 파일 시스템에 있는 데이터를 복사한 것이 아니라 그 겉모습인 파일(inode 값)만 복사했기 때문이다.
따라서 진짜 복사했을 때와 달리 파일 시스템 내의 데이터는 여전히 1개만 존재한다. 파일과 실제 파일이 가리키는 데이터를 동일하게 생각하면 이해가 되지 않겠지만 파일을 '실제데이터에 대한 정보를 가지고 있는 정보체' 로 실제 데이터와 분리해서 생각한다면 쉽다.

특정 파일이 가리키는 데이터에 대한 하드 링크의 개수를 보는 첫 번째 방법은 __stat 파일명__ 명령어다.
만든 하드 링크는 1개지만 원본 파일도 결국 실제 데이터를 가리키는 링크이기 때문에 생성한 하드링크와 다를바 없다. 즉 원본 파일도 하드 링크의 개수에 포함된다.

하드링크의 개수를 보는 두번째 방법은 __ls -l__ 명령어다.

``` shell
ls -l
total 0
-rw-r--r--  2 taerin  staff  0  7  6 22:15 test_symbolic.c
```

3번째 열에 숫자 2가 적혀 있는데 이것이 바로 이파일이 가리키고 있는 데이터에 대한 하드링크의 개수이다.

## 장단점
하드 링크는 아래의 2가지 제약이 있다.

1. 다른 파일 시스템에 있는 데이터에 대해 하드 링크 생성 불가
2. 디렉토리에 대한 링크 생성 불가

위의 경우에는 심볼릭 링크를 사용해야 하며, 위의 경우 말고도 같은 프로그램을 여러 버전 별로 가지고 있고 다른 프로그램이나 스크립트에서 그 프로그램을 실행해야 하는 경우에도 프로그램 소스나 스크립트를 변경할 필요없이 원하는 버전을 실행하도록 심볼릭 링크를 유용하게 사용할 수 있다.

반면 하드 링크의 장점은 아래와 같다.

1. 성능: 하드 링크는 데이터가 있는 위치를 직접 가리키고 있기 때문에 다른 파일을 가리키고있는 심볼릭 링크에 비해 약간 더 빠르다.
2. 저장 공간: 하드 링크 파일은 마치 용량을 점유하고 있는 것처럼 보이지만 진짜로 데이터를 복사한 것이 아니라 이미 존재하는 데이터의 위치만 (Inode)를 통해 가리키고 있으며 별도의 데이터를 저장하지 않기 때문에 용량을 차지하지 않는다. 약간의 용량(보통 4KB)을 차지한다.

덤으로 원래 파일이 지워지면 쓸모없어지는 심볼릭 링크와 달리 하드링크는 1개라도 남아있을 경우 실제 데이터가 남는다는 장점이 있다.

[출처](http://www.myservlab.com/64)



