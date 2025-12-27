\# Guide de déploiement de PetClinic sur Kubernetes



Ce document décrit les étapes permettant de déployer l'application PetClinic sur un cluster Kubernetes local à l'aide de Minikube.



\## Prérequis

\- Docker installé

\- Minikube installé

\- kubectl installé



\## Étape 1 : Démarrage du cluster Kubernetes



minikube start



\## Étape 2 : Création du namespace



kubectl create namespace petclinic

kubectl config set-context --current --namespace=petclinic



\## Étape 3 : Déploiement de MySQL



kubectl apply -f kubernetes/mysql/mysql-secret.yaml

kubectl apply -f kubernetes/mysql/mysql-pvc.yaml

kubectl apply -f kubernetes/mysql/mysql-deployment.yaml

kubectl apply -f kubernetes/mysql/mysql-service.yaml



\## Étape 4 : Déploiement de l'application PetClinic



kubectl apply -f kubernetes/petclinic/petclinic-configmap.yaml

kubectl apply -f kubernetes/petclinic/petclinic-deployment.yaml

kubectl apply -f kubernetes/petclinic/petclinic-service.yaml



\## Étape 5 : Accès à l'application



minikube service petclinic -n petclinic



