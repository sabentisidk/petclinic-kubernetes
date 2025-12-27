Architecture du projet PetClinic sur Kubernetes


Ce projet déploie l'application Spring PetClinic sur un cluster Kubernetes local (Minikube).

L'architecture repose sur une séparation claire entre l'application métier et la base de données.


1. Environnement général

L’ensemble du projet est déployé dans un cluster Kubernetes local fourni par Minikube.
Un namespace dédié nommé petclinic est utilisé afin d’isoler les ressources du projet du reste du cluster.



2. Application PetClinic

L’application PetClinic est une application Java Spring Boot.

- Elle est déployée sous forme de Deployment Kubernetes

- Le Deployment utilise deux réplicas afin d’assurer une haute disponibilité

- Chaque instance de l’application s’exécute dans un Pod distinct

- L’application écoute sur le port 8080

- Elle est exposée à l’extérieur du cluster via un Service Kubernetes de type NodePort

- La configuration applicative (URL de la base de données, nom de la base, utilisateur) est injectée via un ConfigMap

- Des probes de type liveness et readiness sont configurées afin de vérifier l’état de santé de l’application

- Des limites et des requêtes de ressources CPU et mémoire sont définies



3. ase de données MySQL

La base de données utilisée par l’application est MySQL.

- MySQL est déployée dans un Pod Kubernetes séparé

- Une seule instance est utilisée

- Les données sont stockées de manière persistante grâce à un PersistentVolumeClaim de 5 Go

- Le Pod MySQL est exposé uniquement à l’intérieur du cluster via un Service de type ClusterIP

- La base de données écoute sur le port 3306

- Les informations sensibles (mot de passe MySQL, utilisateur) sont stockées dans un Secret Kubernetes



4. Communication entre les composants

- L’application PetClinic communique avec la base de données MySQL via le Service Kubernetes nommé mysql

- Le Service permet à l’application de se connecter à MySQL sans dépendre de l’adresse IP du Pod

- Les paramètres de connexion sont injectés dynamiquement à l’application via les ConfigMaps et Secrets

- Aucune information sensible n’est stockée en dur dans les manifests Kubernetes



5. Résilience et bonnes pratiques

L’architecture mise en place intègre plusieurs mécanismes de résilience et de bonnes pratiques :

- Redémarrage automatique des Pods en cas de défaillance

- Haute disponibilité de l’application grâce aux deux réplicas

- Séparation claire entre l’application et la base de données

- Utilisation d’un stockage persistant pour MySQL

- Gestion des ressources CPU et mémoire

- Sécurité renforcée grâce à l’utilisation de Secrets et à l’absence de credentials en dur