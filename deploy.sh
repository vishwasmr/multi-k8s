docker build -t vimr/multi-client:latest -t vimr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vimr/multi-server:latest -t vimr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vimr/multi-worker:latest -t vimr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vimr/multi-client:latest
docker push vimr/multi-server:latest
docker push vimr/multi-worker:latest

docker push vimr/multi-client:$SHA
docker push vimr/multi-server:$SHA
docker push vimr/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-delpoyment server=vimr/multi-server:$SHA
kubectl set image deployment/client-delpoyment client=vimr/multi-client:$SHA
kubectl set image deployment/worker-delpoyment worker=vimr/multi-worker:$SHA
