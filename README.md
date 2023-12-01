# HERMESChain Cluster Launcher

Create ready-to-go Kubernetes clusters for deploying a HermesNode on selected providers.

Open the Local Terminal, and follow the below steps.

## Requirements

* [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

> Note: Some provider integrations may require additional tools which is outlined in the respective documentation.



# HERMESChain Kubernetes Cluster – Amazon Web Services

Deploy a Kubernetes cluster in AWS using EKS service.

## Requirements

* an AWS account
* CLI and AWS credentials configured
* AWS IAM Authenticator
* wget (required for eks module)

Prerequisites:

1. AWS Account: You must have an AWS account to create and manage resources on the AWS cloud. If you don’t already have this, you can sign up for an account and use the free tier. you can visit the link below. 
   
   https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html

   To enable IAM User with permissions, see doc below:

   ["    "]

2. AWS CLI installed & IAM User with permissions: 
  You’ll need to have the AWS Command Line Interface (CLI) installed on your machine to interact with EC2 instances and other AWS resources from the command line. You can download the appropriate version for your system below. 
  
  " https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html "


 or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install the AWS CLI.

```bash
brew install awscli
aws configure
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install the AWS CLI.

```bash
choco install awscli
aws configure
```

   Outputs: AWS Access Key ID [****************NC]: 
            AWS Secret Access Key [****************nN]: 
            Default region name [*****-1]: 
            Default output format [json]: 

### AWS IAM Authenticator

To install the AWS IAM Authenticator, follow [these instructions]
  (https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
  or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install the AWS IAM Authenticator.

```bash
brew install aws-iam-authenticator
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install the AWS IAM Authenticator.

```bash
choco install aws-iam-authenticator

## HERMESNode

To you have a Kubernetes cluster up and running, please refer to the [documentation here](https://gitlab.com/dojimanetwork/dojima-cluster-launcher) to get started with your HermesNode.


### Upgrade

```bash
terraform init -upgrade
```

If installing plugins or modules, ignore previously-downloaded objects and install the latest version allowed within the configured constraints.

### Creating Lockfiles

```bash
terraform providers lock -platform=linux_arm64 -platform=linux_amd64 -platform=darwin_amd64 -platform=windows_amd64
```

Normally the dependency lock file (.terraform.lock.hcl) is updated automatically by "terraform init", but the information available to the normal provider installer can be constrained when you're installing providers from filesystem or network mirrors, and so the generated lock file can end up incomplete.

The "providers lock" subcommand addresses that by updating the lock file based on the official packages available in the origin registry, ignoring the currently-configured installation strategy.

After this command succeeds, the lock file will contain suitable checksums to allow installation of the providers needed by the current configuration on all of the selected platforms.

By default this command updates the lock file for every provider declared in the configuration. You can override that behavior by providing one or more provider source addresses on the command line.
