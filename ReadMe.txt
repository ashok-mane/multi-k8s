Command to set secret in Kubernetes:

kubectl create secret generic pgpassword --from-literal PASSWORD=1234terg

This secret needs to be wired in postgres-deployment.yaml & server-deployment.yaml

To run Kubernetes dashboard ( go to complex directory )
1. kubectl apply -f kubernetes-dashboard.yaml
2. kubectl proxy
3. To access dashboard : http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
4. Click the "SKIP" link next to the SIGN IN button.

