terraform {
    backend "s3" {
        bucket         = "my-state-aws-terraform"
    	key            = "terraform"
        region         = "us-east-1"
    }
}

