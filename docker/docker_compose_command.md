# docker-compose 
 여러 개의 컨테이너를 사용하여 하나의 서비스를 제공해야 할 때 Docker Compose를 사용한다. 

#### docker-compose file은 yml파일로 작성한다.
	* yml이란? xml과 비슷한 데이터 직렬화 방식.


#### 컨테이너 띄우기
compose파일이 있는 디렉토리에서 실행하기
```
$ docker-compose up
```

#### 지정한 컨테이너만 띄우고 싶을 때
	여기서 -d 옵션은 데몬으로 켜기.
``` 
$ docker-compose up -d {컨테이너 명}
```
	
#### Docker 로그보기
```
$ docker-logs {컨테이너 명}
```

#### Host 등록하기
다른 컴퓨터와 통신해야 할 경우 host를 DNS 등록해주어야 한다.
```
$ sudo vi /etc/hosts
```

#### docker 로그보기 (이어지게 보기)
```
$ docker logs -f -t {컨테이너 명/ app 명}
```

#### docker-compose 빌드하기
	변경되었으면 재 빌드해야한다.
```
$ docker-compose --build
```

