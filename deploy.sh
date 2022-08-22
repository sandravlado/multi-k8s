docker build -t stephengrider/multi-client-k8s:latest -t vbundalo/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server-k8s-pgfix:latest -t vbundalo/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker-k8s:latest -t vbundalo/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push vbundalo/multi-client-k8s:latest
docker push vbundalo/multi-server-k8s-pgfix:latest
docker push vbundalo/multi-worker-k8s:latest

docker push vbundalo/multi-client-k8s:$SHA
docker push vbundalo/multi-server-k8s-pgfix:$SHA
docker push vbundalo/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vbundalo/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=vbundalo/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=vbundalo/multi-worker-k8s:$SHA