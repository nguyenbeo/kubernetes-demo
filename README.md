# kubernetes-demo
A simple demo to try out the kubernetes (K8s) locally

## Some brief Kubernetes(K8s) notes
[Kubernetes Notes](KUBERNETEST_NOTES.md)

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

## How to carry out step to deploy the app into Kubenetes cluster
1. Create docker image
* Go to directory of the project
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


4. Explore the app

5. Expose the app publicly

6. Scale the app

