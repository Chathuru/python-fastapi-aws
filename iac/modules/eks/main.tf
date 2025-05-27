resource "aws_eks_cluster" "eks" {
  name     = join("-", [var.environment, var.project, var.cluster_name])
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.subnet_id_list
    public_access_cidrs     = var.eks_public_access_cidrs
    security_group_ids      = var.security_group_ids
    endpoint_public_access  = var.eks_endpoint_public_access
    endpoint_private_access = var.eks_endpoint_private_access
  }

  tags = {
    Name = join("-", [var.environment, var.project, var.cluster_name])
  }

  depends_on = [aws_iam_role.eks_cluster_role]
}

data "tls_certificate" "eks_oidc" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
  depends_on = [aws_eks_cluster.eks]
}

data "tls_certificate" "example" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}
