---
layout: post
category: Pro
---

> `공부 목적`으로 작성한 포스팅입니다. 오타가 많고, 틀린 내용이 있을 수 있습니다.

## 목차
* [Issue with Linux Operating System](#issue-with-linux-operating-system)
  + [Network connectivity Issue](#network-connectivity)
  + [Disk Space Issue](#disk-space)
  + [Memory Issue](#memory)
  + [System Load Issue](#system-load)
  + [Top consumer processes Issue](#top-consumer-processes)
* [Tricks to become better and faster at diagnosing and resolving the trouble of a Linux system](#tricks-to-become-better-and-faster-at-diagnosing-and-resolving-the-trouble-of-a-linux-system)
  + [USE method](#use-method)
* [References](#references)

---
{: data-content="start!"}

## Issue with Linux Operating System

## Network connectivity
리눅스 서버의 문제 중 가장 흔한 것은 네트워크 커넥팅 이슈이다. 이는 시스템 관리자와 엔드유저에게 모두 치명적이다.
리눅스 서버에 네트워킹 이슈가 발생한다면 다음 4가지를 확인해야 한다.

1. ifconfig나 ip와 같은 UseTool을 활용한다.
2. External server을 Ping하거나 traceroute 커맨드를 돌려서 network bottlenecks을 확인한다.
3. 때때로, 트래픽을 차단하는 방화벽이 있을 수 있다. 방화벽 규칙을 적절히 했는지 확인한다.
4. 물리 네트워크 장비를 확인한다.

### TIP! traceroute command
**ping**을 이용하여 IP 네트워크 접속 가능성을 확인할 수 있지만, 패킷이 실제로 어디서 유실되었는지 확인하지는 못한다. 이를 보완한 커맨드가 **traceroute**이다. 이 커맨드는 네트워크 로드를 일으키기 때문에, 일반적인 조작 중에는 절대로 사용하지 말고 트러블슈팅 중에만 사용해야하는 것을 명시한다. 

네트워킹 문제가 아니라면, 다음과 같은 문제가 있을 수 있다.
local과 webserver 두 관점에서 원인을 파악해보자.

## Disk Space
일단 Disk Space를 체크하기 위해서 df 를 사용한다. -h argument를 통해 human readable한 MB/GB 형태로 표출할 수 있다. 이중에 Use%가 100%가 된 volume이 있는지 찾아본다.
```shell
domicmeia@domicmeia:~$ df -h
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              392M  1.6M  390M   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   30G   17G   12G  59% /
tmpfs                              2.0G     0  2.0G   0% /dev/shm
tmpfs                              5.0M  4.0K  5.0M   1% /run/lock
/dev/vda2                          2.0G  261M  1.6G  15% /boot
/dev/vda1                          1.1G  6.4M  1.1G   1% /boot/efi
tmpfs                              392M   44K  392M   1% /run/user/1000
```

사실, disk 문제였으면 느려지는 것이 아니라 crash 했을 것이다.

## Memory
메모리가 부족할 경우 운영체제는 현재 사용되지 않는 부분을 디스크에 임시로 기록할 수 있다(swap out). OS는 freed memory를 다음 프로세스에게 제공한 다음, swapped data의 주인 프로세스가 다시 필요할 때 다시 읽어온다. 이 방식은 swapping이라 불리는데, 디스크에 읽고 쓰는 과정은 RAM에서 바로 읽고 쓰는 것보다 훨씬 느리므로 시스템의 성능 저하를 불러온다.

메모리의 활용 상태를 보기 위해 free command를 쓸 수 있다.

```shell
domicmeia@domicmeia:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3911         500        2834           5         576        3255
Swap:           3910           0        3910
```

## System Load
프로세서가 계산을 수행하는데, 계산에 필요한 프로세서 시간이 부족하면 시스템 속도가 느려질 수 있다. 프로세서가 연산할 수 있는 여유 시간이 있어야만 계산을 할 수 있다. 프로세서의 load를 체크하는 한가지 방법은 uptime 이다.

```shell
domicmeia@domicmeia:~$ uptime
 10:16:52 up 7 min,  1 user,  load average: 0.00, 0.08, 0.06
```
1분, 5분, 15분간의 load 평균 

## Top consumer processes
CPU와 memory의 전체적인 그림과, 이 리소스를 쓰고 있는 프로세스들을 보기 위해서는 near-real time으로 시스템 로드를 표출해주는 top command를 사용할 수 있다.

- shift + p : CPU 사용률 내림차순
- shit + m : 메모리 사용률 내림차순
- shift + t : 프로세스가 돌아가고 있는 시간 순

```shell
top - 10:19:53 up 10 min,  1 user,  load average: 0.01, 0.05, 0.05
Tasks: 145 total,   1 running, 144 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.4 us,  0.5 sy,  0.0 ni, 98.9 id,  0.0 wa,  0.0 hi,  0.2 si,  0.0 st
MiB Mem :   3911.2 total,   2828.1 free,    505.6 used,    577.6 buff/cache
MiB Swap:   3911.0 total,   3911.0 free,      0.0 used.   3250.6 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                 
   1796 domicme+  20   0  947576  87484  39060 S   1.0   2.2   0:05.30 node                                    
   2065 domicme+  20   0  720212  56800  36584 S   1.0   1.4   0:02.22 node                                    
    129 root      20   0       0      0      0 I   0.3   0.0   0:00.25 kworker/1:2-mm_percpu_wq                
   1173 root      20   0 1343264  37140  25884 S   0.3   0.9   0:01.40 containerd                              
   2280 domicme+  20   0 5183100 141684  42100 S   0.3   3.5   0:11.78 node                                    
      1 root      20   0  166952  11160   7448 S   0.0   0.3   0:00.48 systemd                                 
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd                                
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp                                  
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp

# 쓰여진 약어는 다음을 참고하자
us: user cpu time (or) % CPU time spent in user space
sy: system cpu time (or) % CPU time spent in kernel space
ni: user nice cpu time (or) % CPU time spent on low priority processes
id: idle cpu time (or) % CPU time spent idle
wa: io wait cpu time (or) % CPU time spent in wait (on disk)
hi: hardware irq (or) % CPU time spent servicing/handling hardware interrupts
si: software irq (or) % CPU time spent servicing/handling software interrupts
st: steal time - - % CPU time in involuntary wait by virtual cpu while hypervisor is servicing another processor (or) % CPU time stolen from a virtual machine
```

# Checking process
최고 사용량을 차지하는 프로세스를 찾았다면, 해당 PID와 ps 명령어를 통해서 조금 더 자세히 알아보자.

```shell
domicmeia@domicmeia:~$ ps -ef| grep 1796 | grep -v "grep"
```

---
{: data-content="Tricks"}

# Tricks to become better and faster at diagnosing and resolving the trouble of a Linux system

## USE Method
- which is stands for Utilization, Saturation and Errors.

```shell
$ dmseg #kernel Buffer
$ vmstat #virtual memory
$ pidstat #checks every pid status
$ mtr #checks network latency
$ mpstat #checks every CPU usages
$ iostat #checks disk status
$ free #chekcs memory status
$ ifconfig #checks network interfaces
$ sar #checks completed system activities
$ ss #checks connection performances
$ iftop #checks network performances
$ smem #checks memory allocated to per process 
```

---
{: data-content="references"}

## References

- [리눅스 기본 트러블 슈팅 가이드 - Jaemun Jung][blog]
- [5 Common Linux Server Problems and How to Fix Them - Rohan Timalsina][tuxcare]

[blog]:https://jaemunbro.medium.com/linux-%EB%AC%B8%EC%A0%9C%ED%95%B4%EA%B2%B0-%EA%B0%80%EC%9D%B4%EB%93%9C-for-beginners-8e1867bf834f
[tuxcare]:https://tuxcare.com/blog/5-common-linux-server-problems-and-how-to-fix-them/