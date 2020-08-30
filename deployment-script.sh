#!/bin/bash

# Start minikube
# in order to enable the ingresses addon, minikube requires a vm-based driver instead of using docker as the driver
minikube start --driver=${MINIKUBE_DRIVER}
#make sure the ingess addon is enabled for minikube
minikube addons enable ingress

echo "sleeping for 2 minutes to let the ingress addon be applied"
sleep 120
#Install the application with helm
echo "installing the application with helm"
helm install hello-pod hello-pod/

echo "sleeping for 2 minutes to allow the pods and ingress to be created"
sleep 120

#Get the ingress IP and hostname
INGRESS_IP=$(kubectl get ingress hello-pod -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
HOSTNAME=$(kubectl get ingress hello-pod -o jsonpath="{.spec.rules[0].host}")

echo "To reach the application add this line to your /etc/hosts file:"
echo "${INGRESS_IP}   ${HOSTNAME}"
echo "in your browser you should be able to go to:"
echo "http://${HOSTNAME}"
