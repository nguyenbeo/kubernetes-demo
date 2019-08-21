# kubernetes-demo
A simple demo to try out the kubernetes (K8s) locally

## Some brief Kubernetes(K8s) notes
[Kubernetes Notes](KUBERNETES_NOTES.md)

## Scenario of this demo
We have a micro service application running on Docker, we want to deploy the application on Kubenetes cluster.

The following steps need to be carried out:
* Create docker image for the app locally
* Create a cluster
* Deploy the app
* Explore the app
* Expose the app publicly
* Scale the app

## Technologies
* Java 11
* Spring Boot 2
* Docker
* Kubectl
* [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)

## How to deploy the app quickly used POD template


## How to deploy the app manually step by step into Kubenetes cluster
1. Create docker image
* Go to directory of the project
* Run "**eval $(minikube docker-env)**" to point local docker environment to minikube
* Run "**gradle build**""
* Run "**docker build -t kubernetes_demo .**"
* Run "**docker images**" to verify whether docker image has been created

2. Create a K8s cluster
* If minikube is already installed, then run "**minikube version**" to verify
* Start the cluster by running "**minikube start**" (It might take time to create the cluster)
* To interact with K8s, use CLI, **kubectl**, Run "**kubectl version**"
* Run "**kubectl cluster-info**" to see the cluster details
* Run "**kubectl get nodes**" to show all nodes used to host the app

=> Cool! Now you have a running Kubernetes cluster in your local computer
3. Deploy the app
* Run "**kubectl run kubernetes-demo --image-pull-policy=Never --image=kubernetes-demo:latest --port=8080**" to deploy the app docker to K8s cluster
* Run "**kubectl get deployments**" to double check the recent deployment

Now, Pods are running inside K8s on a private and isolated network so they are not visible from outside that network, we will expose it later.

Instead, we are going to create proxy to forward request to private network:
* Run "**echo -e "\n\n\n\e[92mStarting Proxy. After starting it will not output a response. Please click the first Terminal Tab\n"; kubectl proxy**" to create proxy
* Open another tab in terminal and run "**curl http://localhost:8001/version**"
* Run "**export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'); echo Name of the Pod: $POD_NAME**" to store env variable POD_NAME
* Open a new tab and run "**curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/actuator/health**", then you will see the JSON saying the server is up.                           

4. Explore the app
* Run "**kubectl get pods**" to look for existing Pods
* Run "**kubectl describe pods**" to see the details of the pods
* Run "**kubectl logs $POD_NAME**" to see the logs for the container within the Pod.
* Run "**kubectl exec $POD_NAME env**" to list the environment variables on the container.
* Run "**kubectl exec -ti $POD_NAME bash**" to start bash session

5. Expose the app publicly
* Run "**kubectl get services**" to list the current Services
* Run "**kubectl expose deployment/kubernetes-demo --type="NodePort" --port 8080**" to create new service and expose it to external traffic
* Run "**kubectl get services**" to check whether new service has been created
* Run "**kubectl describe services/kubernetes-demo**" to see the details of the service
* Run "**export NODE_PORT=$(kubectl get services/kubernetes-demo -o go-template='{{(index .spec.ports 0).nodePort}}'); echo NODE_PORT=$NODE_PORT**"
* Run "**curl $(minikube ip):$NODE_PORT/actuator/health**" to check whether the container is exposed and up and running
* Run "**kubectl label pod $POD_NAME app=v1**" to label the Pod
* Run "**kubectl get pods -l app=v1**" to get the Pods by label

6. Scale the app
* Run "**kubectl get deployments**" to get deployments
* Run "**kubectl scale deployments/kubernetes-demo --replicas=4**"
* Run "**kubectl get deployments**" to check whether there are 4 running instances
* Run "**kubectl get pods -o wide**" to check number of Pods
