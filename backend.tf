terraform {
    backend "s3" {
	shared_credentials_file = "/var/lib/jenkins/.aws/creds"
        bucket         = "my-state-aws-terraform-s3-for-Epamproject"
    	key            = "terraform"
        region         = "us-east-1"
    }
}

