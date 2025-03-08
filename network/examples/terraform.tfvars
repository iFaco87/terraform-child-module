# The two below values should be stored in Terraform Cloud
# do not commit them to the repository
#aws_access_key     = ""
#aws_secret_key     = ""
service_name   = "myservice"
environment    = "test"
vpc_cidr_block = "10.0.0.0/16"

public_subnets = {
  "public1" = {
    name              = "Public Subnet 1"
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
  }
  "public2" = {
    name              = "Public Subnet 2"
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"
  }
  "public3" = {
    name              = "Public Subnet 3"
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1c"
  }
}

private_subnets = {
  "private1" = {
    name              = "Private Subnet 1"
    cidr_block        = "10.0.51.0/24"
    availability_zone = "us-east-1a"
  }
  "private2" = {
    name              = "Private Subnet 2"
    cidr_block        = "10.0.52.0/24"
    availability_zone = "us-east-1b"
  }
  "private3" = {
    name              = "Private Subnet 3"
    cidr_block        = "10.0.53.0/24"
    availability_zone = "us-east-1c"
  }
}