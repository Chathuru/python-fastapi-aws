terraform {
  backend "s3" {
    bucket  = "terraform"
    region  = "us-east-1"
    key     = "state"
    profile = "default"
    encrypt = true

  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1"
    }
  }
}
