::windows용 bat파일 (docker build && kubectl apply)

::DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
::minikube start --driver=hyperv
::@FOR /f "tokens=*" %i IN ('minikube -p minikube docker-env') DO @%i


:: 수동으로 시작 후 minikube ip 확인 하여 yaml 파일 수정 후 진행

minikube addons enable metallb
minikube addons enable dashboard
minikube addons enable metrics-server

docker build -t nginx-container ./srcs/nginx
docker build -t phpmyadmin-container ./srcs/phpmyadmin
docker build -t wordpress-container ./srcs/wordpress
docker build -t mysql-container ./srcs/mysql

kubectl apply -f srcs/metallb/metallb.yaml

kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f srcs/wordpress/wordpress.yaml
kubectl apply -f srcs/mysql/mysql.yaml

minikube dashboard