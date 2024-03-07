terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.76"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"
}

provider "snowflake" {
  role = "SYSADMIN"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket        = "740868949166-test-bucket"
  force_destroy = true
}

resource "snowflake_database" "create_db" {
  name = "TEST_DB"
}

resource "snowflake_warehouse" "warehouse" {
  name           = "TEST_WH"
  warehouse_size = "small"
  auto_suspend   = 60
}
