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

sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/phpmyadmin/config.inc.php

minikube stop
minikube delete
eval $(minikube docker-env -u)

rm ../Library/VirtualBox/HostInterfaceNetworking-vboxnet0-Dhcpd.leases

eval $(minikube docker-env -u)