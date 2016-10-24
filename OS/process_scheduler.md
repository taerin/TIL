# Scheduler

1) Long-term Scheduler
	디스크 내의 job pool 에서 메모리 내에 준비완료된 프로세스들이 대기하는  레디큐로 옮길 때 사용되는 스케줄러

2) Mid-term Scheduler
	메모리 내에 너무 많은 프로세스가 적재되어 있으면 관리가 힘드므로, 메모리에서 disk 영역으로 swapping 하게 될때 사용되는 스케줄러

3) Short-term Scheduler
	레디큐에 존재하는 프로세스들 중 어떤 프로세스가 CPU에 할당되어 실행될 지를 결정하는 스케줄러
