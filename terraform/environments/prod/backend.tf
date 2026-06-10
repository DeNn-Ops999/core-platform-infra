terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }

  backend "s3" {
    bucket       = "kumoscale-prod-tfstate"
    key          = "environments/prod/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    # Native S3 state locking (Terraform 1.10+), replaces legacy DynamoDB table:
    use_lockfile = true
  }
}
