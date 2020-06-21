terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "<bucket-name>"
    key            = "terraform-multi-account/org"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-lock"
  }
}
