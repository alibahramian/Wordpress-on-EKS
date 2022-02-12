# Wordpress-on-EKS
Deploy a wordpress on top of EKS on AWS using terraform

**Set up and initialize your Terraform workspace**

Here, you will find 5 files used to provision a VPC, security groups, and an EKS cluster.

1. vpc.tf - provisions a VPC, subnets, and availability zones using the AWS VPC Module. A new VPC is created for this tutorial so it doesn't impact your existing cloud environment and resources.
2. security-groups.tf - provisions the security groups used by the EKS cluster.
3. eks-cluster.tf - provisions all the resources (AutoScaling Groups, etc...) required to set up an EKS cluster in the private subnets and bastion servers to access the cluster using the AWS EKS Module.
4. outputs.tf - defines the output configuration.
5. versions.tf - sets the Terraform version to at least 0.12. It also sets versions for the providers used in this sample.

**Initialize Terraform workspace**

```$ terraform init```

**Provision the EKS cluster**

```$ terraform apply```

This will give an output with cluster details like endpoint, name, certificate, region, etc.

**Configure kubectl with the Amazon EKS Cluster**

```$ aws eks --region $(terraform output region) update-kubeconfig --name $(terraform output cluster_name)```
**Provision RDS Instance**

**Create rds.tf**



