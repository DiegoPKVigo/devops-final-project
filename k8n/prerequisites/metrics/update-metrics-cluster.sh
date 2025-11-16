#!/bin/bash

# Minikube Delete
minikube delete

# Minikube Start
minikube start --driver=docker --cpus=4 --memory=4096 --disk-size=20g

# Configure namespace
kubectl apply -f /home/ctag/Escritorio/devops-final-project/k8n/base/metrics/namespace.yaml


#COnfigure
kubectl apply -f /home/ctag/Escritorio/devops-final-project/k8n/base/metrics/

#Check pods
kubectl get pods -n monitoring


# Retrieve the auto-generated password
PW=$(kubectl -n grafana get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)


echo \|#########################################
echo \#   "Grafana admin password is $PW"      \#
echo \#########################################

#Port redirection
#kubectl -n monitoring port-forward svc/prometheus-service 9090:9090
#kubectl -n monitoring port-forward svc/grafana 3000:3000
#kubectl -n monitoring port-forward svc/promtail-daemonset 3101:3101
#kubectl -n monitoring port-forward svc/loki 3100:3100 

#http://prometheus-service.monitoring.svc.cluster.local:9090
