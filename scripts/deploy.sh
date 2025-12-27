

echo "Déploiement de l'application sur Kubernetes..."

kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mysql/
kubectl apply -f kubernetes/petclinic/
