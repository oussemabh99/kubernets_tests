git config --global user.name "oussemabh99"
git config --global user.email "oussema.benhdid@etudiant-enit.utm.tn"
kubectl create -f $(pwd)/pods/namespace.yaml;
kubectl create -f $(pwd)/secrets/secret1.yaml;
kubectl create -f $(pwd)/Deployments/kube-registry-2.yaml;
kubectl create -f $(pwd)/Service/kube-regitry.yaml;
kubectl create -f $(pwd)/Volume/pv-local.yaml
kubectl create -f $(pwd)/Volume/pvc-local.yaml

sleep 20 ;
if ( curl -v  localhost:32000); then
   if (docker login localhost:32000); then
    docker pull alpine && docker tag alpine:latest localhost:32000/myos:v1 && docker push localhost:32000/myos:v1 &&
    kubectl create secret generic auth --from-file .dockerconfigjson=/root/.docker/config.json --type kubernetes.io/dockerconfigjson -n devops && 
    kubectl create -f $(pwd)/Deployments/app1.yaml ;
   else 
    echo "ereur";
   fi
  
fi

