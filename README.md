# ft_services
## 1. 실행
~~~bash
#실행
git clone https://github.com/tapark/ft_services.git && cd ft_services && bash setup.sh
#초기화
bash clean.sh
~~~
## 2. 설명
 <img width="1000" alt="service" src="https://user-images.githubusercontent.com/67908647/115204290-47816b00-a133-11eb-88da-3973a1ae95c0.png">
<img src="https://user-images.githubusercontent.com/67908647/115196427-d9d14100-a12a-11eb-94e3-321f49bdfaee.png"  width="500"> <img src="https://user-images.githubusercontent.com/67908647/115196763-3df40500-a12b-11eb-88ae-9b3287f7c69c.png"  width="500">
 |service|type|  port  |description|
 |-------|--------|-----------|-----------------------------------------------|
 |Metallb|LoadBalancer||LoadBalancer를 통한 각 서비스 접근 관리 및 단일 ip 사용 :minikube ip|
 |mysql|ClusterIP||persisatent_volume 으로 wordpress, phpmyadmin과 연동|
 |influxdb|ClusterIP||persisatent_volume 으로 각 서비스(컨테이너)들의 상태를 telegraf를 통해 시계열 데이터 정보로 저장|
 |nginx|LoadBalancerIP|80<br>443|http -> https(301 redirect)<br>minikube_ip/wordpress -> minikube_ip:5050(307 redirect)<br>minikube_ip/phpmyadmin -> minikube_ip:5000(reverse proxy)|
 |wordpress|LoadBalancerIP|5050|mysql 서버와 연동, 초기설정과 여러명의 유저가 db형태로 저장되어 적용되어있는 상태<br>(id : tapark / pw : 1234)|
 |phpmyadmin|LoadBalancerIP|5000|mysql 서버와 연동, nginx에서 porxy_pass와 http_head로 reverse proxy<br>(id : tapark / pw : 1234)|
 |ftps|LoadBalancerIP|21|컨테이너 내의 user_volume을 루트 저장소로 지정<br>(ip : minikube_ip / id : tapark / pw : 1234 / port : 21)
 |grafana|LoadBalancerIP|3000|influxdb에 수집된 db를 통한 각 서비스(컨테이너)의 상태 시각화<br>(id : admin / pw : admin)|  
  - 각 docker images는 alpine linux를 base로 하여 build
  - setup.sh, clean.sh 에서 MINIKUBE_IP를 유동적으로 관리하여, 클러스터IP가 변경되거나 다른 환경에서 실행시에도 해당하는 IP가 적용될 수 있게 설계함
  - livenessProbe로 서비스(컨테이너)나 컨테이너에서 구동중이 앱이 비정상 적으로 종료될 시 해당 컨테이너를 재시작할 수 있도록 설정  

# minikube + docker 초기 설정
## 1. MacOS (cluster)
 - MSC에서 docker, virtualbox 설치
 - 터미널 입력  
~~~C
// homebrew 설치
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update
// minikube 설치
brew minikube
// mnikube start경로 지정, local에 설치 시 용량부족 
export MINIKUBE_HOME=/Users/tapark/goinfre  
minikube start --driver=virtualbox  
// minikube 의 docker를 local로 연결 (minikube docker-env 입력 시 확인가능) 
eval $(minikube -p minikube docker-env) 
~~~
## 2. Windows
 - minikube 설치 [[Download](https://github.com/kubernetes/minikube/releases/latest/download/minikube-installer.exe)]
 - docker desktop 설치 [[Download](https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe)]
 - 터미널(CMD) 입력(관리자권한 실행)  
~~~C
// hyper-v 활성화 (virtualbox 대신 사용)  
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V  
minikube start --driver=hyperv  
// minikube 의 docker를 local로 연결 (minikube docker-env 입력 시 확인가능)  
@FOR /f "tokens=*" %i IN ('minikube -p minikube docker-env') DO @%i  
~~~
