terraform {
 backend "s3" {
   bucket         = "my_state_aws_project"
   key            = "state/terraform.tfstate"
   region         = "us-east-1"
  }
}
