docker build -t ibucev/multi-client:latest -t ibucev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ibucev/multi-server:latest -t ibucev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ibucev/multi-worker:latest -t ibucev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ibucev/multi-client:latest
docker push ibucev/multi-server:latest
docker push ibucev/multi-worker:latest

docker push ibucev/multi-client:$SHA
docker push ibucev/multi-server:$SHA
docker push ibucev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ibucev/multi-server:$SHA
kubectl set image deployments/client-deployment client=ibucev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ibucev/multi-worker:$SHA