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
