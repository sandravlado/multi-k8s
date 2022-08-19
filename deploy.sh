docker build -t sandravlado/multi-client-k8s:latest -t sandravlado/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t sandravlado/multi-server-k8s-pgfix:latest -t sandravlado/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t sandravlado/multi-worker-k8s:latest -t sandravlado/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push sandravlado/multi-client-k8s:latest
docker push sandravlado/multi-server-k8s-pgfix:latest
docker push sandravlado/multi-worker-k8s:latest

docker push sandravlado/multi-client-k8s:$SHA
docker push sandravlado/multi-server-k8s-pgfix:$SHA
docker push sandravlado/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sandravlado/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=sandravlado/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=sandravlado/multi-worker-k8s:$SHA