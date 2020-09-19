docker build -t joseandrade2/multi-client:latest -t joseandrade2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t joseandrade2/multi-server:latest -t joseandrade2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t joseandrade2/multi-worker:latest -t joseandrade2/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push joseandrade2/multi-client:latest
docker push joseandrade2/multi-server:latest
docker push joseandrade2/multi-worker:latest

docker push joseandrade2/multi-client:$SHA
docker push joseandrade2/multi-server:$SHA
docker push joseandrade2/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=joseandrade2/multi-server:$SHA
kubectl set image deployments/client-deployment client=joseandrade2/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=joseandrade2/multi-worker:$SHA