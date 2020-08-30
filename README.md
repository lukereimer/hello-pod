#### README

This repo is a simple helm chart to deploy a hello world type app on to minikube with a deployment, a service and a local ingress.


#### Local Deployment


Prerequisites for running locally:

- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
  - `minikube addons enable ingress`
  In order to enable the ingress addon, minikube requires a vm-based driver instead of using docker as the driver. This deployment script is tested with the virtualbox driver, but any vm-based drivers should work.
- [helm](https://helm.sh/docs/intro/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

With the prerequisites installed you can run the script to deploy the application in the terminal with `bash deployment-script.sh`. Script completion usually takes 5-10 minutes.

The final output of the script will be a line to add to your local `/etc/hosts` file similar to `192.168.99.10X hello.local`. I chose not to script in changes to a user's `/etc/hosts` file as it is an action that generally requires `sudo` access. Adding the line to `/etc/hosts` will make [http://hello.local](http://hello.local) accessible through your browser. Refreshing the page will cycle between deployed pods.
