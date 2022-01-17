---
layout: post
category: Pro
---

### 시작하기 앞서..
> 이 포스팅은 `Docker in Practice[2 ed.]`와 `Using Docker: Developing and Deploying Software with Containers [1 ed.]`의 내용을 바탕으로 작성됐습니다. 

2021년 2학기 사이드 프로젝트를 끝내면서 가장 아쉬웠던 점이 Docker를 활용하지 못한 것이다. 당시 나는 windows 10 home을 사용중이었고, wsl2의 확장없이는 도커를 사용할 수 없었다. 또한 wsl2는 개발자들에게 제한적으로 공개된 상태라(..) Windows 참가자 프로그램에 참가해 베타채널을 동의했어야 했다. Docker를 사용하고 싶은 마음이 앞서서 참가자 모드로 진입했고, 한동안 블루스크린에 허우적거렸다!! 베타채널이 `베타`라는 것을 조금이라도 깨달았어야 했다. ~~하지만, 지금의 나는 windows10 education이 있다!~~ 제멋대로 11으로 업그레이드 되더니 home으로 변했다! ~~망했다~~ 이번 겨울에 Docker를 차근차근 배우고 내 로컬에 테스트 환경을 구축하는 과정을 블로그에 남기려고 한다. 먼저 Docker에 대해 알아보자. 

## The What and Why of Containers
 Containers are an encapsulation of an application with its dependencies. At first glance, they appear to be just a lightweight form of virtual machines (VMs) like a VM, a container holds an isolated instance of an operating system (OS), which we can use to run
 applications. However, containers have several advantages that enable use cases that are difficult or impossible with traditional VMs:

 - Containers share resources with the host OS, which makes them an order of magnitude more efficient. Containers can be started and stopped in a fraction of a second. Applications running in containers incur little to no overhead compared to applications running natively on the host OS.
 - The portability of containers has the potential to eliminate a whole class of bugs caused by subtle changes in the running environment—it could even put an end to the age-old developer refrain of “but it works on my machine!”
 - The lightweight nature of containers means developers can run dozens of containers at the same time, making it possible to emulate a production-ready distributed system. Operations engineers can run many more containers on a single host machine than using VMs alone.
 - Containers also have advantages for end users and developers outside of deploying to the cloud. Users can download and run complex applications without needing to spend hours on configuration and installation issues or worrying about the changes required to their system. In turn, the developers of such applications can avoid worrying about differences in user environments and the availability of dependencies.

컨테이너와 VM은 근본적인 목적이 다르다. VM은 외부 환경을 `완전하게 에뮬레이트`하는 데 목적을 둔 데 반해, 컨테이너를 응용프로그램의 `이식성과 독립성`에 목적을 두고 있다. 

## Docker and Containers
도커는 기존 리눅스 컨테이너 기술을 차용하였으며 다양한 방식(주로 이식 가능한 이미지와 사용자에게 친숙한 인터페이스를 통하여)으로 포장하고 확장하여 컨테이너의 생성 및 배포를 위한 완벽한 솔루션을 만들게 되었다. 도커 플랫폼은 두 개의 독립된 컴포넌트로 구성된다. 먼저 도커 엔진은 컨테이너를 생성하고 실행하는 역할을 수행하며, 도커 허브(Docker Hub)는 컨테이너 배포를 위한 클라우드 서비스를 제공한다. 도커 엔진(Docker Engine)은 컨테이너를 운영하기 위한 빠르고 간편한 인터페이스를 제공한다.

**작성중**