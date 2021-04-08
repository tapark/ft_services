#!/bin/bash
# minikube 설치 경로 설정(root에 설치 시 용량 부족)
export MINIKUBE_HOME=/Users/tapark/goinfre
# 가상환경(VirtualBox)에서 minikube 시작(실행)
# MSC에서 virtualbox, docker 설치 가능
minikube start --driver=virtualbox
# local의 docker를 minikube의 docker와 연결
# minikube ssh의 도커 이미지/컨테이너들을 local에서 핸들링할수있음
eval $(minikube -p minikube docker-env)
# minikube 상태확인
minikube status
# minikube ip 명령어로 ip 확인 및 저장
MINIKUBE_IP=$(minikube ip)
# minikube addons list 명령어로 사용 가능한 리스트 확인
# LoadBallance 사용 가능으로 변경
minikube addons enable metallb
# dashborad 사용 가능으로 변경
minikube addons enable dashboard
# metrics-server 사용 가능으로 변경(metallb 설치 시 이것도 설치하라고 권장한다.)
minikube addons enable metrics-server
# yaml 파일에 MINIKUBE_IP 로 작성되어있는 부분을 minikube ip로 치환
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/metallb/metallb.yaml
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/nginx/nginx.yaml
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/phpmyadmin/phpmyadmin.yaml
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/wordpress/wordpress.yaml
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/ftps/ftps.yaml

# 설정파일에서..
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/nginx/default.conf
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/mysql/wordpress.sql
sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/ftps/vsftpd.conf


# docker images build
docker build -t nginx-container ./srcs/nginx
docker build -t mysql-container ./srcs/mysql
docker build -t phpmyadmin-container ./srcs/phpmyadmin
docker build -t wordpress-container ./srcs/wordpress
docker build -t ftps-container ./srcs/ftps
docker build -t influxdb-container ./srcs/influxdb
#docker build -t grafana-container ./srcs/grafana

# run metallb
kubectl apply -f srcs/metallb/metallb.yaml
# run
kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/mysql/mysql.yaml
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f srcs/wordpress/wordpress.yaml
kubectl apply -f srcs/ftps/ftps.yaml
kubectl apply -f srcs/influxdb/influxdb.yaml

minikube dashboard

#alpine Linux 버젼 : 3.12.0