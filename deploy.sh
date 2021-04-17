docker build -t parulkumarpal/multi-client:latest -t parulkumarpal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t parulkumarpal/multi-server:latest -t parulkumarpal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t parulkumarpal/multi-worker:latest -t parulkumarpal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push parulkumarpal/multi-client:latest
docker push parulkumarpal/multi-server:latest
docker push parulkumarpal/multi-worker:latest
docker push parulkumarpal/multi-client:$SHA
docker push parulkumarpal/multi-server:$SHA
docker push parulkumarpal/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=parulkumarpal/multi-server:$SHA
kubectl set image deployments/client-deployment client=parulkumarpal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=parulkumarpal/multi-worker:$SHA