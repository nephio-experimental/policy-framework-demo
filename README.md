# policy-framework-demo

## Environment
### Cluster creation
Create demo cluster for policy demo
```
$ kind create cluster --name policy-demo
$ kind get clusters
```

### Setting up repository
It will start a gitserver.
```
docker run -d -v `pwd`/repositories:/var/lib/git -p "8282:80" cirocosta/gitserver-http
```
Create an empty repository `deployments`.

### KPT installation
Refer KPT [official documentation](https://kpt.dev/installation/) for installtion of kpt, porch and configsync.


### Gatekeeper installation in workload cluster

Refer gatekeeper [official documentation](https://open-policy-agent.github.io/gatekeeper/website/docs/install/) to install gatekeeper in workload cluster.


## Package preparation

## Execution

