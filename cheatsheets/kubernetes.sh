#!/bin/bash
export KUBECONFIG=./kubeconfig
export name=reservador

kubectl delete svc ${name} -n frontends
kubectl delete deployment ${name} -n frontends
kubectl delete ingressroute  ${name} - frontends
