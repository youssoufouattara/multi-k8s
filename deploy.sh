docker build -t youatt/multi-client-k8s:latest -t youatt/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t youatt/multi-server-k8s:latest -t youatt/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t youatt/multi-worker-k8s:latest -t youatt/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push youatt/multi-client-k8s:latest
docker push youatt/multi-server-k8s:latest
docker push youatt/multi-worker-k8s:latest

docker push youatt/multi-client-k8s:$SHA
docker push youatt/multi-server-k8s:$SHA
docker push youatt/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=youatt/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=youatt/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=youatt/multi-worker-k8s:$SHA