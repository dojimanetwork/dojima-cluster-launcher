# HERMESChain Cluster Launcher in GCP

Open the Local Terminal, and follow the below steps.

## Requirements
* A GCP account with a service account and its keys.
* Terraform CLI (https://learn.hashicorp.com/tutorials/terraform/install-cli)
* gcloud cli installed. (https://cloud.google.com/sdk/docs/install#deb)

Open the gcp console, create a new project.
Under resource select the newly created project & enable the list of api's for the project,
- kubernetes Cluster
- Compute Engine
- secrect manager

Under IAM & Admin, click on service accounts--> go to Actions --> Manage keys--> Add key(activate & download)
Open the code editor and add file "keys.json" to the dojima-cluster-launcher & paste the downloaded keys into the folder to enable access with terraform to gcp via terminal.

In terminal run the following commands.
- terraform init ( to pull all the required terraform modules )
- terraform validate ( to check the code validation )
- terraform apply
  Provide the cluster name, project id and region in which you want deploy the cluster (GCP price calculator for various regions " https://cloud.google.com/products/calculator-legacy ")
this would take 30 to 40 min for the cluster to launch.

Open the GCP console , go to kubernetes engine --> Clusters --> "Your cluster" --> Connect

Once you have ssh, run the following commands to install the packages;

apt update
apt install -y git

#install make
apt install -y make

#install helm
install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

#install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

Once all the packages are installed , you are ready to for node launcher deployment.
