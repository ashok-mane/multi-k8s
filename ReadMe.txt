Command to set secret in Kubernetes:

kubectl create secret generic pgpassword --from-literal PASSWORD=1234terg

This secret needs to be wired in postgres-deployment.yaml & server-deployment.yaml

To run Kubernetes dashboard ( go to complex directory )
1. kubectl apply -f kubernetes-dashboard.yaml
2. kubectl proxy
3. To access dashboard : http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
4. Click the "SKIP" link next to the SIGN IN button.


To encrypt gcp service-account.json file which will be used by Travis CI to connect to GCP, you need to do following -
1. You need Travis CLI which needs ruby, Travis is only required to encrypt the file. Installing Ruby and Travis on local machine does not
   make sense so we will install it on docker.

Follow below steps in powershell -

docker run -it -v ${pwd}:/app ruby:2.4 sh
gem install travis

travis login --github-token your guithub token --com
travis encrypt-file service-account.json -r ashok-mane/multi-k8s --pro
-> This will encrypt the file as service-account.json.enc and tie it to the ashok-mane/multi-k8s repository. Note this .enc file will be checked in to the repository and not original file (service-account.json )

============ NGINX as Router =========
Inside k8s directory you will see file ingress-service.yaml - This service will create a Nginx router service insdie Kubernetes
You may refer to this file and routing rules unders rules: section
This is a good option to test on your local but not a best option in production/cloud environments.
So what is to be done in production?
Follow below steps for google cloud deployment -
1. install helm ( kubernetes package manager ) - helps to install third party kubernetes applications. Helm has 2 parts, client and server.
server does actual work of installing and configuring kubernetes third party applications.
https://helm.sh/docs/intro/install/, search "from script" section and run below commands in gcloud command prompt 
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
2. install ingress-nginx
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update

	helm install ingress-nginx ingress-nginx/ingress-nginx

As of helm 3 seems that below steps ( 3 & 4 ) are not required so please ignore
3. Create service account and assign role/permissions for server part of helm( aka tiller )
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

4. config helm to use above service account
helm init --serviceaccount tiller --upgrade







