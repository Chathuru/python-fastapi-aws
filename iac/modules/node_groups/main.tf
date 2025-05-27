locals {
  eks_cluster_name = join("-", [var.environment, var.project, var.cluster_name])
  user_data = <<EOF
#!/bin/bash
set -ex
/etc/eks/bootstrap.sh ${local.eks_cluster_name} --b64-cluster-ca ${var.eks_cluster_ca} --apiserver-endpoint ${var.eks_api_server_url}
EOF
}

resource "aws_launch_template" "launch_template" {
  for_each = var.node_groups_configs

  name                   = join("-", [var.environment, var.project, each.key])
  image_id               = lookup(each.value, "image_id")
  instance_type          = lookup(each.value, "instance_type")
  #key_name               = "ec2"
  vpc_security_group_ids = var.security_group_ids
  user_data              = base64encode(local.user_data)

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = lookup(each.value, "volume_size", 20)
      volume_type = lookup(each.value, "volume_type", "gp2")
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = join("-", [var.environment, var.project, each.key])
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = join("-", [var.environment, var.project, each.key])
    }
  }
}

resource "aws_eks_node_group" "node_group" {
  for_each = var.node_groups_configs

  cluster_name    = local.eks_cluster_name
  node_group_name = join("-", [var.environment, var.project, each.key, "ng"])
  node_role_arn   = aws_iam_role.eks_cluster_node_role.arn
  subnet_ids      = var.subnet_ids

  launch_template {
    id = lookup(aws_launch_template.launch_template[each.key], "id")
    version = lookup(aws_launch_template.launch_template[each.key], "latest_version")
  }

  scaling_config {
    desired_size = lookup(each.value, "desired_size", 1)
    max_size     = lookup(each.value, "max_size", 2)
    min_size     = lookup(each.value, "min_size", 1)
  }

  update_config {
    max_unavailable = lookup(each.value, "max_unavailable", 1)
  }
}
