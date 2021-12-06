terraform {
    backend "s3" {
      bucket         = "my-state-aws-terraform"
      key_name       = "terraform"
      region         = "us-east-1"
    }
}

