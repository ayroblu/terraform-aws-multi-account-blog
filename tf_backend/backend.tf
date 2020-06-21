terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "<bucket-name>"
    key            = "terraform-multi-account/backend"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-lock"
  }
}
