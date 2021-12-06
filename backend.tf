terraform {
    backend "s3" {
      bucket         = "my-state-aws-terraform"
      region         = "us-east-1"
    }
}

