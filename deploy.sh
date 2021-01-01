docker build -t takanarisasaki1/multi-client:latest -t takanarisasaki1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t takanarisasaki1/multi-server:latest -t takanarisasaki1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t takanarisasaki1/multi-worker:latest -t takanarisasaki1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push takanarisasaki1/multi-client:latest
docker push takanarisasaki1/multi-server:latest
docker push takanarisasaki1/multi-worker:latest

docker push takanarisasaki1/multi-client:$SHA
docker push takanarisasaki1/multi-server:$SHA
docker push takanarisasaki1/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=takanarisasaki1/multi-client:$SHA
kubectl set image deployments/server-deployment server=takanarisasaki1/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=takanarisasaki1/multi-worker:$SHA
