#### README

This repo is a simple helm chart to deploy a hello world type app on to minikube with a deployment, a service and a local ingress. The actual deployed container is [this one.](https://hub.docker.com/r/nginxdemos/hello)


#### Local Deployment


Prerequisites for running locally:

- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
  - `minikube addons enable ingress`
  In order to enable the ingress addon, minikube requires a vm-based driver instead of using docker as the driver. This deployment script is tested with the virtualbox driver, but any vm-based drivers should work.
- [helm](https://helm.sh/docs/intro/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Set your minikube driver as the $MINIKUBE_DRIVER environment variable. (example: `export MINIKUBE_DRIVER=virtualbox`). Acceptable driver options are [listed here.](https://kubernetes.io/docs/setup/learning-environment/minikube/#specifying-the-vm-driver)

With the prerequisites installed you can run the script to deploy the application in the terminal with `bash deployment-script.sh`. Script completion usually takes 5-10 minutes.

The final output of the script will be a line to add to your local `/etc/hosts` file similar to `192.168.99.10X hello.local`. I chose not to script in changes to a user's `/etc/hosts` file as it is an action that generally requires `sudo` access. Adding the line to `/etc/hosts` will make [http://hello.local](http://hello.local) accessible through your browser. Refreshing the page will then cycle between deployed pods.

#### Deploying on AWS

To deploy this helm chart onto AWS we have 2 options, a simple way and a more complex, but much more production like method.

*_Minikube on AWS_*

Our first option is to run the minikube on a single, AWS EC2 instance with a public IP. In this case we would need to install `minikube`, `kubectl` and `helm` all on the single instance. We could drop the ingress entirely and create the service with type NodePort. Our `/etc/hosts` entry to `<EC2_elastic_ip> hello.local`

*_Deploying to a more production like EKS cluster_*

It is certainly possible to deploy all of this onto a fully production ready EKS cluster in AWS with terraform.

To deploy an eks cluster with helm requires a number of modules, as well as providers for AWS, Kubernetes and helm.

With the AWS provider the minimum requirement for the [terraform eks module](https://github.com/terraform-aws-modules/terraform-aws-eks) is to create a standard VPC with public and private subnets.  The EKS module can then provision the EKS cluster and one or more node groups. Naturally for this level of application, a single worker node is all that is needed to server the 2 pods.

The kubernetes provider in terraform is needed simply to install helm on the cluster, and then the helm provider can deploy the `hello-pod` helm chart.
