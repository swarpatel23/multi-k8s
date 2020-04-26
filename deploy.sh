docker build -t swar23/multi-client:latest -t swar23/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t swar23/multi-server:latest -t swar23/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t swar23/multi-worker:latest -t swar23/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push swar23/multi-client:$SHA
docker push swar23/multi-worker:$SHA
docker push swar23/multi-server:$SHA

docker push swar23/multi-client:latest
docker push swar23/multi-worker:latest
docker push swar23/multi-server:latest

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=swar23/multi-server:$SHA
kubectl set image deployments/client-deployment client=swar23/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=swar23/multi-worker:$SHA
