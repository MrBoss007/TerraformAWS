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
  region = var.aws_region
  shared_credentials_file = "aws_shared_creds.txt"
  profile = "TerraformPipeline"
  # If Hardcorded in Provider File
  # access_key = "AKIAZI7FZ7VZILDPPUFH"
  # secret_key = "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"
}
