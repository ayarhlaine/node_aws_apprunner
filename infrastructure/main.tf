terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_ecr_repository" "node-aws-apprunner-repo" {
  name                 = "node-aws-apprunner-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_apprunner_service" "node-aws-apprunner-service" {
  service_name = "node-aws-apprunner-service"

  source_configuration {
    image_repository {
      image_configuration {
        port = "3000"
      }
      image_identifier      = "504776330223.dkr.ecr.ap-southeast-1.amazonaws.com/node-aws-apprunner-repo:latest"
      image_repository_type = "ECR_PUBLIC"
    }
    auto_deployments_enabled = false
  }

  tags = {
    Name = "node-aws-apprunner-service"
  }
}