# Kubernetes Notes

## What is Kubernetes?

- K8s is a portable, extensible, open-source platform for managing containerized workloads and service that facilitates both declarative configuration and automation.

- Container deployment era

## Why K8s?

- K8s provides a framework to run distributed systems resiliently
- Take care of scaling requirements, failover, deployment patterns
- K8s can manage a canary deployment.
- K8s provides:
    - Service discovery and load balancing
    - Storage Orchestration
    - Automated rollouts and rollbacks
    - Automatic bin packing
    - Self-healing
    - Secret and configuration management

## Why not K8s

- K8s is not traditional, all-inclusive PaaS -> K8s operates at container level rather than at hardware level
- Doesn’t limit the types of applications supported
- Doesn’t deploy source code and not build your application
- Doesn’t provide application-level services such as message buses, data-processing frameworks, databases, …
- Doesn’t dictate loggin, monitoring, or alerting solutions
- Doesn’t provides nor mandate a configuration language/system but provides a declarative API 
- Doesn’t provides nor adopt any comprehensive machine configuration, maintenance, management or self-healing systems. 

## K8s Components

- Master Components: provide the cluster’s control plane -> global decisions about the cluster, and detect and respond to cluster events. 
    - Kube-apiserver
        - Exposes the K8s API -> front-end for K8s control plane
        - Scales horizontally
    - Etcd
        - Key-value store used as K8s’ backing store for all cluster data -> should have back-up plan
    - Kube-scheduler
        - Watches newly created pods that have no node assigned and select a node for them to run
        - Factor to assign for scheduling decisions include individual and collective resource requirements, hardware/software/….
    - Kube-controller-manager
        - Runs controllers. Each controller -> separate process but reduce complexity -> compiled into a single binary and run in single process
        - Controllers:
            - Node Controller: responsible for noticing and responding when nodes go down
            - Replication Controller: responsible for maintaining the correct number of pods for every replication controller object
            - Endpoints Controller: populates the Endpoints object (joins Services & Pods)
            - Service Account & Token Controllers: Create default accounts and API access tokens for new namespaces
    - Cloud-controller-manager
        - Runs controllers that interact with the underlying cloud providers
        - Runs cloud-provider-specific controller loops only
        - Allows the cloud vender’s code and k8s code to evolve independently
        - Controllers have cloud provider dependencies:
            - Node controller: for checking the cloud provider
            - Route controller: for setting up routes
            - Service controller: for creating, updating and deleting cloud provider LB
            - Volume controller: for creating, attaching, and mounting volumes and interacting with the cloud provider
- Node Components: run on every node, maintain running pods and provide K8s runtime environment
    - Kubelet
        - An agent that runs on each node in the cluster, makes sure that containers are running in a pod
        - Takes a set of PodSpecs that are provided through various mechanisms and ensures containers are running and healthy
        - Doesn’t manage containers which were not created by K8s
    - Kube-proxy
        - Is a network proxy that runs on each node in cluster
        - Maintains network rules on nodes - network communication to your Pods
        - Uses the OS packet filtering layer if available. Otherwise forward traffic itself.
    - Container runtime
        - Is the software that is responsible for running containers
- Addons
    - DNS: Cluster DNS for clusters
    - Web UI (Dashboard): Web-based UI for clusters for managing and troubleshooting purpose
    - Container resource monitoring: records generic time-series metrics about containers 

## K8s API

The K8s API serves as the foundation of the declarative configuration schema for the system. Use kubectl command line tool can be used to create, update, delete and get API objects.

## K8s Objects

K8s Objects are persistent entities in the K8s system to represent the state of your cluster.
- What containerised applications are running (an on which nodes)
- The resource available to those applications
- The policies around how app behave, such as restart policies, upgrades and fault-tolerance

=> Use Kubernetes API to create/modify/delete

## Workloads

### Pods
- Is the smallest deployable object in K8s object model
- Is a basic execution unit of a K8s application
- Represents processes running on your cluster
- Pods running a single container: “one-container-per-Pod”
- Pods running multiple containers that need to work together: “Sidecar container”

### Controllers
- Replica Set
- Replication Controller
- Deployments
- Stateful Sets
- Daemon Set
- GC
- TTL Controller for Finished Resources
- Jobs - Run to Completion
- CronJob

### Working with Pods
- Pods do not, by themselves, self-heal
- K8s uses higher-level abstraction called CONTROLLER to handle disposable Pod instances.

### Pods and Controller
- A Controller can create and manage multiple Pods, handle replication and rollout, provide self-healing
- Some controllers:
    - Deployment
    - Stateful Set
    - Daemon Set
