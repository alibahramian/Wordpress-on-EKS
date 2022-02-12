provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "wordpress" {
  name       = "wordpress"
  chart      = "${abspath(path.root)}/wordpress-chart"
}

  set {
    name  = "WORDPRESS_DB_DATABASE"
    value = aws_db_instance.rds.name
  }

  set {
    name  = "WORDPRESS_DB_USER"
    value = aws_db_instance.rds.master_username
  }

  set {
    name  = "WORDPRESS_DB_PASSWORD"
    value = aws_db_instance.rds.master_user_password
  }

  set {
    name  = "WORDPRESS_DB_HOST"
    value = aws_db_instance.rds.endpoint.address
  }

