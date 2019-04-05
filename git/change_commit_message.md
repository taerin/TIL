# Commit message 변경하기
커밋 메세지를 변경할 일이 거의 없다. 
메세지를 변경할 필요가 있을때에도 amend 옵션을 사용하면 바로 직전에 커밋한 메시지를 쉽게 변경할 수 있다.

하지만 만약 내가 바로 직전의 커밋이 아니라, 전전 커밋 아니면 그보다 더 오래전의 커밋 메세지를 변경해야한다면 어떡하지..
그런일이 실제로 일어났다..
사실 웬만해서는 커밋 메세지를 변경하지 않지만, 숫자의 순서가 중요한 커밋에서는 꼴보기 싫을 때가 있었다.. 바로 오늘처럼

그럴 때를 위해 남겨두는 TIL

``` sh
# 마지막 커밋을 포함한 n개의 commit 리스트를 가져와라
$ git rebase -i HEAD~{n}
```


이 명령어를 치면 


``` sh 
pick e123d89 Hello
pick 0232403 first commit
``` 

과 같이 자신이 커밋한 리스트가 나오게 되는데
pick 을 reword로 변경하면, 해당 커밋의 메시지를 수정할 수 있는 파일로 가게된다.