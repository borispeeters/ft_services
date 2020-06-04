# create link in goinfre to save memory
# rm -rf ~/.minikube/machines
# mkdir -p ~/goinfre/machines
# ln -s ~/goinfre/machines ~/.minikube/machines

minikube delete

minikube start \
--vm-driver=virtualbox \
--addons ingress \
--addons dashboard \
--addons metrics-server \
--bootstrapper=kubeadm \
--extra-config=apiserver.service-node-port-range=1-30000 \
--extra-config=kubelet.authentication-token-webhook=true

cd srcs

minikube dashboard &

eval $(minikube docker-env)

export MINIKUBE_IP=$(minikube ip)

sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" ftps/tmp.conf > ftps/vsftpd.conf
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" wordpress/tmp.sh > wordpress/setup.sh
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" telegraf/tmp.conf > telegraf/telegraf.conf
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" nginx/tmp.html > nginx/index.html


docker build -t nginx_alpine nginx/

docker build -t ftps_alpine ftps/

docker build -t mysql_alpine mysql/

docker build -t wordpress_alpine wordpress/

docker build -t phpmyadmin_alpine phpmyadmin/

docker build -t influxdb_alpine influxdb/

docker build -t grafana_alpine grafana/

docker build -t telegraf_alpine telegraf/

kubectl apply -k ./


echo "\n\n\n\nLink to the site: http://$MINIKUBE_IP"
echo "\n\nHave fun :)"

# Please open the site in incognito mode to spare me the heart attack

# ssh bpeeters@$MINIKUBE_IP -p 22000 (password=fluffclub)

# kubectl exec -it <pod_name> sh

# <username>:<password>
# admin account everywhere: bpeeters:fluffclub

# in wordpress 4 additional accounts:
# editor:editor
# author:author
# contributor:contributor
# subscriber:subscriber
