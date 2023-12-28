docker build -t aaaknot30/multi-client-k8s:latest -t aaaknot30/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t aaaknot30/multi-server-k8s:latest -t aaaknot30/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t aaaknot30/multi-worker-k8s:latest -t aaaknot30/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push aaaknot30/multi-client-k8s:latest
docker push aaaknot30/multi-server-k8s:latest
docker push aaaknot30/multi-worker-k8s:latest

docker push aaaknot30/multi-client-k8s:$SHA
docker push aaaknot30/multi-server-k8s:$SHA
docker push aaaknot30/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aaaknot30/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=aaaknot30/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=aaaknot30/multi-worker-k8s:$SHA