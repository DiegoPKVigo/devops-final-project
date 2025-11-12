#!/bin/bash

# Create a dedicated namespace for ArgoCD
kubectl create namespace argocd

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for all ArgoCD components to be ready (this may take 2-3 minutes)
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

# Verify installation
kubectl get pods -n argocd


echo "ArgoCD installed / updated sucesfully"


# Retrieve the auto-generated password
PW=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)


echo \|#########################################
echo \#   "ArgoCD admin password is $PW"      \#
echo \#########################################


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd $SCRIPT_DIR

kubectl apply -f argocd-ingress.yaml
kubectl apply -f argocd-cmd-params-cm.yaml

kubectl -n argocd rollout restart deployment argocd-server
