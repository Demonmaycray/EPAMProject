terraform {
    backend "s3" {
        bucket         = "my-state-aws-terraform-s3-for-Epamproject"
    	key            = "terraform"
        region         = "us-east-1"
    }
}

