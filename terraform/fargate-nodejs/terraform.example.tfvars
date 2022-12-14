name                = "nodejs-my-project-name"
environment         = "test"
aws_region          = "ap-southeast-1"
aws_profile         = "wize-space-local-ducnguyen"
availability_zones  = ["ap-southeast-1a", "ap-southeast-1b"]
private_subnets     = ["10.0.0.0/20", "10.0.32.0/20"]
public_subnets      = ["10.0.16.0/20", "10.0.48.0/20"]
tsl_certificate_arn = "arn:aws:acm:ap-southeast-1:952458421842:certificate/06991621-e675-4fdd-abb1-19ba8c7cc3aa"
container_memory    = 512
container_port      = 8080
cidr = "10.0.0.0/16"