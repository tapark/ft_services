#!/bin/bash
export MINIKUBE_HOME=/Users/tapark/goinfre

kubectl delete svc --all
kubectl delete rc --all
kubectl delete pod --all

#ip changer
MINIKUBE_IP=$(minikube ip)
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/metallb/metallb.yaml
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/nginx/nginx.yaml
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/phpmyadmin/phpmyadmin.yaml
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/wordpress/wordpress.yaml
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/ftps/ftps.yaml
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/grafana/grafana.yaml

# 설정파일에서..
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/nginx/default.conf
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/mysql/wordpress.sql
sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/ftps/vsftpd.conf

minikube stop
minikube delete

rm ../Library/VirtualBox/HostInterfaceNetworking-vboxnet0-Dhcpd.leases

eval $(minikube docker-env -u)