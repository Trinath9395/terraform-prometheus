terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.11.0"
    }
  }

  backend "s3" {
    bucket = "82-remote-state-pr"
    key    = "prometheus-grafana" # you should have unique keys with in the bucket, same key should not be used in other repos or tf projects
    region = "us-east-1"
    use_lockfile = false
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}