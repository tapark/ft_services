# ft_services
<img src="https://user-images.githubusercontent.com/67908647/115196427-d9d14100-a12a-11eb-94e3-321f49bdfaee.png"  width="400"> <img src="https://user-images.githubusercontent.com/67908647/115196763-3df40500-a12b-11eb-88ae-9b3287f7c69c.png"  width="400">
  
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
