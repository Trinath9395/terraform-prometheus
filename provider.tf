terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.84.0"
    }
  }

  backend "s3" {
    bucket = "82s-tf-remote-state-pr"
    key = "prometheus-dev"
    region = "us-east-1"
    dynamodb_table = "82s-tf-remote-state-pr"
  }
}

provider "aws" {
  region = "us-east-1"
}