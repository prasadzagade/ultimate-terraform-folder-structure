terraform {
  backend "s3" {
    dynamodb_table = "terraform-locks"
    bucket         = "terraform-tfstate-payment"
    encrypt        = true
    key            = "infrastructure/environments/com/ultimate-terraform-folder-strucutre/common.tfstate"
    region         = "eu-north-1"
    role_arn       = "arn:aws:iam::007400497555:user/project_user"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
}

provider "aws" {
  allowed_account_ids = [var.aws_account_id]
  region              = var.aws_default_region

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/AssumableAdmin"
  }

  default_tags {
    tags = {
      terraform  = true
      repository = "ultimate-terraform-folder-strucutre"
    }
  }
}
