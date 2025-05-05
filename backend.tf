terraform {
  backend "s3" {
    bucket = "terraformstate74621"
    key = "terraform/backend"
    region = "us-east-1"
  }
}