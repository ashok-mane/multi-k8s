# build and push docker images
docker build -t 52408/multi-client:latest -t 52408/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 52408/multi-server -t 52408/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 52408/multi-worker -t 52408/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push 52408/multi-client:latest
docker push 52408/multi-client:$SHA
docker push 52408/multi-server:latest
docker push 52408/multi-server:$SHA
docker push 52408/multi-worker:latest
docker push 52408/multi-worker:$SHA

# apply all kubernetes config
kubectl apply -f k8s

# update image in kubernetes
kubectl set image deployments/client-deployment client=52408/multi-client:$SHA
kubectl set image deployments/server-deployment server=52408/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=52408/multi-worker:$SHA