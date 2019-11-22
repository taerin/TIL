# Git Flow

Git flow 는Vincent Driessen의 브렌치 모델을 적용하여 고수준으로 저장소를 관리하기 위한 Git 확장 콜렉션이다.


Vincent의 branching model은 “feature – develop – release – hotfixes – master” 단계로 branch를 나눠서 코드를 관리하는 전략이다.


git의 branch 관리가 아무리 빠르고 편하다 한들, 이렇게 프로세스를 나눠서 작업을 하려면 귀찮기 마련이다.


그래서 사용자가 쉽게 접근할 수 있도록 확장 명령어 셋을 제공하는 것이 바로 gitflow다.

### gitfow 설치

``` shell
$ brew install git-flow-avh
```

git flow 프로젝트 설정을 변경하기 위해 초기화를 해야한다.
``` shell
$ git flow init
```

### 새 기능(feature) 시작하기
새 기능의 개발은 'develop' 브랜치에서 시작한다.

``` shell
$ git flow feature start MYFEATURE
```

위 명령은 'develop'에 기반한 새 기능 (feature) 브랜치를 생성하고 그 브랜치로 전환한다.

### 기능 완료
기능 개발 완료 후 MYFEATURE 브랜치를 'develop'에 merge 한다.


그 후 기능 브랜치를 삭제한다. 'develop' 브랜치로 전환한다.
``` shell
$ git flow feature finish MYFEATURE
```

### 기능 게시 (publish)
기능을 공동으로 개발하고 있다면 기능을 원격 서버에 게시하여 다른 사용자들도 사용할 수 있게 한다.
``` shell
$ git flow feature publish MYFEATURE
```

### 게시된 기능 가져오기
다른 사용자가 게시한 기능을 가져온다.

``` shell
$ git flow feature pull origin MYFEATURE
```

## release 시작
새로운 제품 출시 준비를 지원 및 출시를 위한 사소한 버그 수정이나 메타 데이터 준비를 허용하는 과정


### 릴리즈 시작
릴리스를 시작하려면 git flow의 release 명령을 사용한다.
'develop' 브랜치로부터 'release' 브랜치를 생성


``` shell
$ git flow release start RELEASE [BASE]
```

릴리스를 시작할 [BASE] commit sha-1 해시를 선택적으로 줄 수도 있다.


그 commit은 반드시 'develop' 브랜치에 있어야 한다.



릴리스 브랜치를 생성한 후에는 다른 개발자들의 릴리스 commit을 허용하기 위해 게시(publish)하는 것이 좋다. 이는 기능 게시와 비슷한 방법으로 한다.


``` shell
$ git flow release publish RELEASE
```

+) 원격 'release' 브랜치의 변경 추적은 다음과 같이 합니다

``` shell
$ git flow release track RELEASE
```

### 릴리즈 완료
'release' 브랜치를 'master' 브랜치에 병합(merge) 하고 -> 릴리스를 릴리스 이름으로 태그(tag) -> 릴리스를 'develop' 브랜치로 재병합(back-merge) -> 'release' 브랜치 삭제한다.

``` shell
$ git flow release finish RELEASE
$ git push --tags # 태그들을 push하는 것
```

## Hotfixes
핫 픽스는 현재 출시된 제품에 문제가 생겨서 즉각 대응해야하는 상황에서 필요하다.


master 브랜치의 현재 출시된 버전으로 mark된 태그(tag)로 부터 브랜치를 딴다.

### 핫픽스 시작
``` shell
$ git flow hotfix start VERSION [BASENAME]
```


여기서 버전은 핫픽스 릴리스 이름을 지정한다. 선택적으로 basename으로 시작점을 지정할 수도 있다.

### 핫픽스 완료
핫픽스를 종료하면 핫픽스는 'develop' 및 'master'브랜치로 merge된다. 추가적으로 'master'의 병합부분은 핫픽스 버전으로 태그된다.

``` shell
$ git flow hotfix finish VERSION
```
