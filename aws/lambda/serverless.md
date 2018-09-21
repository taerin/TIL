# Serverless Framework 
[Serverless](https://serverless.com)는 아마존 lambda의 third-party 프레임워크로 브라우저에서 직접 코드 작성없이 로컬에서 명령어를 통해 테스트 후 Lambda로 업로드할 수 있는 기능을 제공한다.
이를 사용하기 위해선 아마존 IAM을 권한 설정이 필요한데 계속해서cloudformation:describestacks 에 대한 권한이 없다는 오류때문에 너무 고생했다..
admin access를 부여한뒤에도 계속해서 동일한 에러가 발생했는데, 따로 인라인 권한을 부여해도 해결되지 않던 것이 갑자기 됐다.
아직도 왜그런지 모름..ㅎ
Serverless 자체에서도 우선 admin access를 부여하라고 나와있으니 나중에 꼭 다시 찾아봐야 할 것같다.

아래는 serverless의 기본 명령어다.

``` shell
$ serverless create --template aws-nodejs --path {dir_name}
$ serverless deploy -v -r us-east-1
$ serverless invoke -f hello -l
$ serverless remove -f hello
``` 

내일은 Apex를 테스트 해봐야지.

## node modules dependency 추가
작성한 handler 파일이 있는 곳에 package.json 파일을 생성하고, $ npm install 을 잊지말고 시행해 준다.

## 기존에 존재하는 버킷에 이벤트 추가
현재 이 기능은 serverless에서 구성이 불가능해보인다.
severelss.yml에 이미 존재하는 S3 버켓에 이벤트를 연결하도록 구성해 놓은 채 deploy 하게되면 이미 존재하는 버켓이라는 오류가 발생했다.
그래서 존재하는 버킷을 삭제 후 다시 deploy를 했더니 이벤트에 연결해놓은 버킷을 생성하면서 람다 및 스택, S3들이 구성된다.  
이는 serverless를 remove 하거나 잘못된 구성으로부터 스토리지를 보호하려는 serverless의 철학으로 보인다. [이 이슈](https://github.com/serverless/serverless/issues/2154)를 참고할것. 
