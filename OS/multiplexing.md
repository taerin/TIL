# Multiplexing 
비동기 이벤트를 처리하는 방법에는 크게 멀티 프로세스/ 멀티 스레드 모델과 멀티 플렉싱 기법이 있습니다. 오늘은 멀티 플렉싱 기법에 대해 알아보도록 하겠습니다. 

예를하나 들어보겠습니다.

``` c
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/uio.h>

int main ()
{
        char buff[1024];
        int ret;
        int fd;

        // mkfifo myfifo -> named pipe를 만드는 명령어
        fd = open("myfifo", O_RDWR);

        if(fd == -1)
        {
                perror("opne()");
                return -1;
        }


        while(1)
        {
                ret = read(0, buff, sizeof buff);

                // 파일의 끝이면 0 리턴하고, -1 이면 에러
                if(ret > 0)
                {
                        buff[ret - 1] = '\0';
                        printf("keyboard: %s\n", buff);
                }

                // named pipe로부터 읽어오기
                ret = read(fd, buff, sizeof buff);
                if(ret > 0)
                {
                        buff[ret - 1] = '\0';
                        printf("myfifo: %s\n", buff);
                }
        }

	return 0;
}

```
 
위 예제는 키보드 입력을 한번 받을 수 있고 다음으로 파이프로부터 입력을 받아오는 예제입니다. 하지만 이 코드에는 문제가 있습니다. 비동기적으로 이벤트를 처리할 수 없기때문에 파이프로 입력을 하나 보내고 다음으로 파이프입력을 또 다시 하게되면 키보드 입력 전까지는 파이프에서 read를 할 수 없습니다.

이 상황에서 multiplexing을 사용해보겠습니다. read 이벤트 발생시 read(0) 이나 read(fd)를 사용하는 것이 아니라 select를 통하여 어떤 이벤트가 발생했는지를 감지하여 blocking된 상태를 풀어줍니다. 이 select는 운영체제 내에서 동작하는 함수입니다.

``` c
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/uio.h>


#include <poll.h>

int main ()
{
        char buff[1024];
        int ret;
        int fd;
        struct pollfd fds[2] = {0, };

        // mkfifo myfifo -> named pipe를 만드는 명령어
        fd = open("myfifo", O_RDWR);

        if(fd == -1)
        {
                perror("opne()");
                return -1;
        }

        fds[0].fd = 0; //  키보드 등록
        fds[0].events = POLLIN;
        fds[1].fd = fd; // named pipe's file descriptor
        fds[1].events =  POLLIN;



        while(1)
        {

                poll(fds, 2, -1); // timeout -1 이면 무한정 대기


                // 수신한 이벤트가 비트 flag로 세팅되는 것
                if(fds[0].revents & POLLIN) {

                        ret = read(0, buff, sizeof buff);

                        // 파일의 끝이면 0 리턴하고, -1 이면 에러
                        if(ret > 0)
                        {
                                buff[ret - 1] = '\0';
                                printf("keyboard: %s\n", buff);
                        }
                }


                // named pipe로부터 읽어오기
                // else if(fds[1].revents & POLLIN) { 로 두면안됩니다. 그 이유는 두 이벤트가 동시에 발생할 수 있기 때문입니다.
                if(fds[1].revents & POLLIN) {

                        ret = read(fd, buff, sizeof buff);
                        if(ret > 0)
                        {
                                buff[ret - 1] = '\0';
                                printf("myfifo: %s\n", buff);
                        }
                }
        }
        return 0;
}
```
위 예제는 multiplexing을 사용하여 작성한 코드로 이제 select 함수를 통하여 어떤 이벤트가 발생했는지를 감지하여 처리합니다.

## Multiplexing 모델
	* Window - IOCP (I/O Comp letion Port) => Proactor
	윈도우에서는 아래와 같은 문제를 thread로 처리합니다. 별도의 thread로 callback을 호출하는 방법으로 처리합니다. 이 방법은 무한정 스레드를 계속해서 만드는 것이 아니라 스레드 풀을 사용합니다. 멀티 코어의 시대로 오면서 이 방법이 성능의 향상을 기대할 수 있게 되었습니다.
	* Linux - epoll => Reactor 
	리눅스의 epoll은 extention poll입니다. 기존의 poll은 한번에 처리할 수 있는 file descriptor의 수가 한정되어있다는 문제가 있기 때문에 확장한 것입니다. 이 방법 또한 별도의 스레드 풀을 사용하여 이벤트를 처리합니다.
	자바의 NIO1은 이 모델을 구

 
