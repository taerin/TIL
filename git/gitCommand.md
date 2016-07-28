# git 명령어
-------------------------------------------------------------------------------

* 브랜치 생성
```
$ git branch {branch}
```

* 브랜치 만들고 생성한 브랜치로 전환
```
$ git checkout -b {branch}
```

* 브랜치 전환
```
$ git checkout {branch}
```

* 현재 브랜치 확인하기
```
$ git branch
```

* 원격 서버에 있는 브랜치 확인하기
```
$ git branch -r
```

* 브랜치 삭제
```
$ git branch -d {branch}
```

-------
* 작성 후 브랜치 머지
```
$ git checkout {branch} 	// 개발 브랜치로 오는 명령
$ git merge {issue}
$ git push origin {issue} // 원격서버에 issue 브랜치로 push 요청
```

* pull request후
```
$ git push origin {branch}  // 원격서버에 {branch}로 합쳐줘라
$ git pull origin {branch}  // pull request 되었다면 pull 받아야 함 
```