docker build -t laportetyler/multi-client:latest -t laportetyler/multi-server:$SHA -f ./client/Dockerfile ./client
docker build -t laportetyler/multi-server:latest -t laportetyler/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t laportetyler/multi-worker:latest -t laportetyler/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push laportetyler/multi-client:latest
docker push laportetyler/multi-server:latest
docker push laportetyler/multi-worker:latest
docker push laportetyler/multi-client:$SHA
docker push laportetyler/multi-server:$SHA
docker push laportetyler/multi-worker:$SHA

kubectl apply -f kube
kubectl set image deployments/server-deployment server=laportetyler/multi-server:$SHA
kubectl set image deployments/client-deployment client=laportetyler/multi-cliet:$SHA
kubectl set image deployments/worker-deployment worker=laportetyler/multi-worker:$SHA