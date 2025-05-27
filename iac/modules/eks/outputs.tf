output "eks_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_certificate_authority" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "id" {
  value = aws_eks_cluster.eks.id
}

output "oidc_issuer" {
  value = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

output "sha" {
  value = data.tls_certificate.example.certificates[0].sha1_fingerprint
}
