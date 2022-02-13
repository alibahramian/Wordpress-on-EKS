# Wordpress-on-EKS
Deploy a wordpress on top of EKS on AWS using terraform

**Configure AWS CLI**


```dotnetcli
$ aws configure
AWS Access Key ID [None]: YOUR_AWS_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_AWS_SECRET_ACCESS_KEY
Default region name [None]: YOUR_AWS_REGION
Default output format [None]: json
```

**Set up and initialize your Terraform workspace**

Here, you will find 5 files used to provision a VPC, security groups, and an EKS cluster.

1. vpc.tf - provisions a VPC, subnets, and availability zones using the AWS VPC Module. A new VPC is created for this tutorial so it doesn't impact your existing cloud environment and resources.
2. security-groups.tf - provisions the security groups used by the EKS cluster.
3. eks-cluster.tf - provisions all the resources (AutoScaling Groups, etc...) required to set up an EKS cluster in the private subnets and bastion servers to access the cluster using the AWS EKS Module.
4. outputs.tf - defines the output configuration.
5. versions.tf - sets the Terraform version to at least 0.12. It also sets versions for the providers used in this sample.

**Initialize Terraform workspace**

```
$ cd eks-cluster
$ terraform init
```

**Provision the EKS cluster**

In your initialized directory, run `terraform apply` and review the planned actions. Your terminal output should indicate the plan is running and what resources will be created

```
$ terraform apply
```

This `terraform apply` will provision a total of 53 resources (VPC, Security Groups, AutoScaling Groups, EKS Cluster, etc...). Confirm the apply with a yes.

This process should take approximately 10 minutes. Upon successful application, your terminal prints the outputs defined in `outputs.tf`

**Configure kubectl with the Amazon EKS Cluster**

Run the following command to retrieve the access credentials for your cluster and automatically configure `kubectl`.

```$ aws eks --region $(terraform output region) update-kubeconfig --name $(terraform output cluster_name)```


**Provision RDS Instance**

Change directory to rds and Create RDS to use by wordpress
```
$ cd rds
$ terraform init
$ terraform apply
```

**Deploy worpress using helm**

In this step we use terraform and helm-release to deploy a wordpress on top of the EKS cluster.
change directory to wordpress-helm and deploy wordpress
```
$ cd wordpress-helm
```

required values have been set in helm chart in case of needed it can be changed in`wordpress-chart/values.yaml`
RDS intance variable that needs to be use by wordpress app will be passed by helm-release.

```
$ terraform init
$ terraform apply
```
The worpress application will be accessible by loadbalancer ip address that shown in `outputs.tf`
