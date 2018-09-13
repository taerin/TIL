# Apex
Lambda를 사용함에 있어 웹 콘솔에서 직접 코드를 작성하거나 ZIP 파일을 통해 배포하고 관리해야하는 일은 너무나도 번거로운 일이다.ㅠㅠ
어제 사용했던 Serverless 프레임워크와 마찬가지로 이러한 불편한 점을 해결해주는 서드파티중에 하나인 Apex를 사용해 보았다.
Apex는 node의 인기 프레임워크인 express를 만든 사람이자 현재는 Go언어로 넘어간 TJ가 만든 프레임워크다.

사용법은 Serverless와 크게 다르지 않았다.

``` shell
$ echo '# apex 설치'
$ curl https://raw.githubusercontent.com/apex/apex/master/install.sh | sh

$ echo '# apex 프로젝트 초기화'
$ apex init

$ echo '# Lambda 함수 배포'
$ apex deploy

$ echo '# Lambda 함수 호출'
$ apex invoke hello
```

Apex와 Serverless를 둘다 사용해본 결과 사실 사용법에서는 큰 차이점을 느끼지 못했다. 
하지만 큰 두가지 차이점은 Apex는 node 버전 6까지만 지원한다는점..! Serverless는 node 8 까지 지원한다.
그리고 그리고 Serverless는 실제 aws 람다에 올라가 있는 함수를 호출하는 메커니즘인 반면, Apex는 로컬 시뮬레이션만 지원한다는 점에서 큰 차이가 난다.
