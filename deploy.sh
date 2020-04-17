docker build -t raph37/multi-client:latest -t raph37/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t raph37/multi-server:latest -t raph37/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t raph37/multi-worker:latest -t raph37/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push raph37/multi-client:latest
docker push raph37/multi-client:$SHA
docker push raph37/multi-server:latest 
docker push raph37/multi-server :$SHA
docker push raph37/multi-worker:latest 
docker push raph37/multi-worker :$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=raph37/multi-server:$SHA
kubectl set image deployment/client-deployment client=raph37/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=raph37/multi-worker:$SHA