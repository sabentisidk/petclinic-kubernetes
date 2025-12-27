Déploiement de Spring PetClinic sur Kubernetes


Introduction


Ce projet a été réalisé dans le cadre du module Conteneurisation et Orchestration. Il consiste à conteneuriser puis déployer l’application Spring PetClinic, une application Java Spring Boot de gestion vétérinaire, sur un cluster Kubernetes local à l’aide de Minikube.

L’objectif principal est de mettre en pratique les concepts fondamentaux étudiés durant le cours, notamment Docker, Kubernetes, la persistance des données, la configuration externalisée, les bonnes pratiques et le monitoring basique.


------------------


1. Présentation de l’application Spring PetClinic


Spring PetClinic est une application de démonstration développée avec le framework Spring Boot. Elle simule un système de gestion pour une clinique vétérinaire et repose sur une architecture classique application / base de données.

Dans ce projet, l’application PetClinic communique avec une base de données MySQL déployée séparément dans le cluster Kubernetes.


--------------------------


2. Architecture du projet


L’architecture repose sur un cluster Kubernetes local (Minikube) et se compose des éléments suivants :


Application PetClinic :

- Application Spring Boot exécutée dans des Pods Kubernetes
- Déployée via un Deployment
- Exposée à l’extérieur du cluster via un Service de type NodePort
- Deux réplicas pour assurer une haute disponibilité


Base de données MySQL :

- Déployée dans un Pod Kubernetes distinct
- Stockage persistant assuré par un PersistentVolumeClaim (PVC)
- Accès interne uniquement via un Service de type ClusterIP


Configuration et sécurité :

- Les paramètres applicatifs sont externalisés à l’aide d’un ConfigMap
- Les informations sensibles (identifiants MySQL) sont stockées dans des Secrets Kubernetes


Cette architecture permet une séparation claire des responsabilités et respecte les bonnes pratiques Kubernetes.


-----------------------------


3. Prérequis techniques


Pour exécuter ce projet, les outils suivants sont nécessaires :

- Système d’exploitation : Windows 11
- Docker Desktop
- Minikube
- kubectl
- Git


Vérification des installations :

docker --version
minikube version
kubectl version --client


-------------------------------


4. Organisation du projet


La structure du projet est organisée comme suit :


MonProjetKubernetes/
│
├── README.md
│
├── docker/
│   ├── spring-petclinic/
│   │   └── Dockerfile
│   └── .dockerignore
│
├── kubernetes/
│   ├── namespace.yaml
│   │
│   ├── mysql/
│   │   ├── mysql-secret.yaml
│   │   ├── mysql-pvc.yaml
│   │   ├── mysql-deployment.yaml
│   │   └── mysql-service.yaml
│   │
│   └── petclinic/
│       ├── petclinic-configmap.yaml
│       ├── petclinic-deployment.yaml
│       └── petclinic-service.yaml
│
├── docs/
│   ├── architecture.md
│   └── deployment-guide.md
│
├── screenshots/
│
└── scripts/
    ├── build.sh
    ├── deploy.sh
    └── cleanup.sh


-------------------------------


5. Conteneurisation avec Docker


L’application PetClinic a été conteneurisée à l’aide d’un Dockerfile multi-stage.

Principales caractéristiques :

- Compilation de l’application avec Gradle dans une image de build
- Image finale allégée contenant uniquement l’environnement d’exécution
- Exécution avec un utilisateur non-root


Construction de l’image Docker :

docker build -t petclinic:1.0 docker/spring-petclinic


-------------------------------------------


6. Déploiement Kubernetes


6.1 Démarrage du cluster

minikube start


6.2 Création du namespace

kubectl create namespace petclinic
kubectl config set-context --current --namespace=petclinic


6.3 Déploiement de MySQL

kubectl apply -f kubernetes/mysql/mysql-secret.yaml
kubectl apply -f kubernetes/mysql/mysql-pvc.yaml
kubectl apply -f kubernetes/mysql/mysql-deployment.yaml
kubectl apply -f kubernetes/mysql/mysql-service.yaml


6.4 Déploiement de l’application PetClinic

kubectl apply -f kubernetes/petclinic/petclinic-configmap.yaml
kubectl apply -f kubernetes/petclinic/petclinic-deployment.yaml
kubectl apply -f kubernetes/petclinic/petclinic-service.yaml


----------------------------------------------


7. Accès à l’application


L’application est exposée via un Service NodePort. L’accès se fait à l’aide de la commande suivante :

minikube service petclinic -n petclinic

Cette commande ouvre automatiquement l’application dans le navigateur.


--------------------------------


8. Bonnes pratiques mises en œuvre


Les bonnes pratiques suivantes ont été appliquées :

- Utilisation d’un namespace dédié
- Séparation application / base de données
- Stockage persistant pour MySQL
- Définition de ressources CPU et mémoire (requests et limits)
- Mise en place de probes de type liveness et readiness
- Utilisation de ConfigMaps et Secrets
- Exécution de l’application avec un utilisateur non-root


--------------------------


9. Monitoring et logs


Le monitoring est assuré de manière basique par Kubernetes.

Vérification de l’état des ressources :

kubectl get pods -n petclinic
kubectl get services -n petclinic
kubectl top pods -n petclinic


Accès aux logs applicatifs (exemple avec un pod PetClinic) :

kubectl logs petclinic-677f974bfb-h6l6d -n petclinic


Les logs de l’application et de la base de données sont accessibles directement via kubectl.


----------------------------


10. Captures d’écran


Le dossier screenshots contient les preuves de bon fonctionnement du projet, notamment :

- Pods en état Running
- Services Kubernetes
- Accès à l’application via le navigateur
- Logs applicatifs
- PersistentVolumeClaim MySQL


------------------------


Conclusion


Ce projet a permis de mettre en pratique les concepts essentiels de la conteneurisation et de l’orchestration avec Docker et Kubernetes. L’architecture mise en place est fonctionnelle, respecte les bonnes pratiques et est conforme aux exigences du module.

Il constitue une base solide pour la compréhension du déploiement d’applications conteneurisées dans un environnement Kubernetes.
