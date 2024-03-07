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

# AWS RESOURCES
resource "aws_s3_bucket" "test_bucket" {
  bucket        = "740868949166-test-bucket"
  force_destroy = true
}

# SNOWFLAKE RESOURCES
resource "snowflake_database" "create_raw_db" {
  name = "RAW"
}
resource "snowflake_database" "create_transformed_db" {
  name = "TRANSFORMED"
}
resource "snowflake_database" "create_analytics_db" {
  name = "ANALYTICS"
}

resource "snowflake_warehouse" "warehouse" {
  name           = "DATA_WH"
  warehouse_size = "small"
  auto_suspend   = 60
}

resource "snowflake_user" "user" {
  name                 = "Mage"
  login_name           = "MAGE-SNOW"
  password             = var.SF_PASS
  default_warehouse    = "DATA_WH"
  default_role         = "ACCOUNTADMIN"
  must_change_password = false
}

variable "SF_PASS" {
  type     = string
  nullable = false
}