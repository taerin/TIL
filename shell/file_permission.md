# 파일 권한

#### 파일 권한(file mode)

\-     | rwx | rwx | rwx
------|-----|-----|-----
파일타입| user 권한| group 권한| other 권한

이 세가지 권한 그룹을 UGO라고 표현하기도 한다.

#### 파일 타입 (file type)

기호 | 설명
-----|-----
- | plain file. 일반 파일. 실행 파일도 포함한다.
d | directory. 디렉토리 형식.
l | link. 다른 파일을 가리키는 링크 파일.
p | pipe. 두 개의 프로그램을 연결하는 파이프 파일. 
b | block device. 블럭 단위로 하드웨어와 반응하는 파일.
c | character device. 스트림 단위로 하드웨어와 반응하는 파일.


#### 권한
rwx : 각각 읽기 (Read)/ 쓰기(Write)/ 실행(Execute)를 의미
해당 권한이 있을 경우 각각 r,w,x 로 표시하고, 권한이 없을 경우 대시(-)표시

\- rwx r-x r-- : 일반 파일이며, 
				파일 소유주는 읽기, 쓰기, 실행 가능
				파일 그룹의 유저는 읽기, 실행 가능
				나머지 유저는 읽기만 가능

#### 1. 파일 권한 확인하기
```bash
$ ls -l
```

#### 2. 파일 권한 변경하기

*chmod* : change mode

```bash
$ chmod {권한} {파일}
```

예)
```bash
$ chmod g+w test  # test라는 파일에 그룹(g)에 쓰기권한(w)을 추가(+)한다.
$ chmod o-x test  # test라는 파일에 나머지사용자(o)의 실행권한(x)을 제거(x) 한다.
```

아래와 같이 여러 심볼을 묶어서 권한할당도 가능하다.

예)
```bash
$ chmod u+rwx test  # test라는 파일에 유저권한에 rwx 권한 부여
$ chmod ugo+rx test
```
매번 심볼을 사용하기 불편하다면 간편하게 숫자로 설정할 수도 있다.
r = 4
w = 2
x = 1
\- = 0

각 그룹에 대한 권한을 숫자를 합한 값으로 한자리로 표현할 수 있다.
rw- = 4 + 2 + 0 = 6
r-x = 4 + 0 + 1 = 5

예) 숫자를 이용해 권한을 설정하는 예
```bash
$ chmod 755 test  # test라는 파일의 u: rwx / g: r-x / o: r-x로 설정한것 
$ chmod 4 test    #  == chmod 004 test
```

#### 3. 파일의 소유주 및 소유그룹 변경

*chown* : change owner
 이 명령어가 허용되려면 파일에 대한 소유권이 있어야만 가능하다.

```bash
$ chown taerin file    # file의 소유주를 taerin 으로 변경
$ chown :taerin3 fiel  # file의 소유그룹을 taerin3 로 변경
$ chown taerin:taerin2 file # file 의 소유주를 taerin/ 소유 그룹을 taerin2로 변경
```

디렉토리 전체를 변경
```bash
$ chown -R taerin:taerin2 dir    # dir과 그 안에있는 파일과 디렉토리의 소유주를 taerin으로 소유 그룹을 taerin2 로 변경u
$ chown -c taerin:taerin2 file   # -c 옵션을 사용하면 변경된 파일들의 정보를 자세히 볼 수 있음  
```
