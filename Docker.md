# Docker

## Docker Installation

### Ubuntu

```bash
sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install docker-ce
```
### Update Docker

```bash
sudo apt-get update

sudo apt-get install docker-ce
```

### Docker cmds

```bash
# -d is for detached mode. This will run the container in the background. -p is for port mapping. 8080 is the host port and 80 is the container port.

docker run -d -p 8080:80 nginx

# enter the container (it has to be running)
docker exec -it 48dbc099f4d6 sh

# save a container as an image
docker commit 48dbc099f4d6 followcrom/nginx-custom:v3

# push an image to docker hub
docker push followcrom/nginx-custom:v3

# test it
docker run -d -p 8080:80 followcrom/nginx-custom:v3

# remove docker image
docker rmi followcrom/nginx-custom:v2

# docker stop all containers
docker stop $(docker ps -a -q)

# docker remove all containers
docker rm $(docker ps -a -q)
```

### Northwind app as Docker container

```bash
# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

ENV FLASK_APP=northwind_web.py

# Run app.py when the container launches
CMD [ "waitress-serve", "--port=5000", "northwind_web:app"]
```


# Kubernetes

1. Create a deployment that manages your pods, e.g.:

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx-deployment

spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: followcrom/nginx-custom:v3
          ports:
            - containerPort: 80
```

2. Save this as nginx_deployment.yaml

3. Create the deployment:

```bash
kubectl create -f nginx_deployment.yaml

# if necessary, delete a previous deployment and recreate it:
kubectl delete deployment nginx-deployment

# delete service

kubectl delete service nginx-svc

kubectl get deployments

kubectl get pods
```

4. Create a service that exposes your deployment to the outside world, e.g.:

```yaml
apiVersion: v1
kind: Service

metadata:
  name: nginx-svc
  namespace: default

spec:
  ports:
    - nodePort: 30001
      port: 80
      targetPort: 80

  selector:
    app: nginx

  type: NodePort
```

5. Save this as nginx_service.yaml

`kubectl create -f nginx_service.yaml`

6. Check that your service is running. Go to localhost:30001 in your browser.


## K8 cmds

```bash
kubectl get all
kubectl get deployments
kubectl get pods
kubectl get services

kubectl create -f app_deployment.yml

kubectl delete deployment nginx-deployment

kubectl get pods

kubectl create -f app_service.yml

### scale a deployment

kubectl scale deployment sta-deployment --replicas=0

### delete a service

kubectl delete service sta-svc

# delete one pod

kubectl delete pod <pod-name>

# delete all deployments

kubectl delete deployment --all

# exec into a pod

kubectl exec -it <pod-name> -- /bin/bash

kubectl exec -it sta-deployment-6df8784669-86c2f -- node seeds/seed.js

# edit a deployment
kubectl edit deployment <deployment-name>
```


