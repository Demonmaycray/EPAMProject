terraform {
 backend "s3" {
   bucket         = "my-state-aws-project"
   key            = "state/terraform.tfstate"
   region         = "us-east-1"
  }
}
