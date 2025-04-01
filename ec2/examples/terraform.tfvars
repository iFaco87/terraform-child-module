# The two below values should be stored in Terraform Cloud
# do not commit them to the repository
#aws_access_key     = ""
#aws_secret_key     = ""
service_name   = "myservice"
environment    = "stg"
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

sg_bastion = {
  stage            = "stg"
  attributes       = ["bastion"]
  allow_all_egress = false
  rules = [
    {
      key         = "ssh"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow SSH from anywhere"
    },
    {
      key         = "https"
      type        = "egress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow HTTPS to anywhere"
    }
  ]
}

sg_db = {
  stage            = "stg"
  attributes       = ["db"]
  allow_all_egress = false
  rules = [
    {
      key         = "ssh"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow SSH from anywhere"
    },
    {
      key         = "postgres"
      type        = "ingress"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow Postgres from anywhere"
    },
    {
      key         = "https"
      type        = "egress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow https to anywhere"
    }
  ]
}

keypairs = {
  "one" = {
    name       = "one"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDup3XeZ38Hki00kZlng6Tefp8+tqiKJsO83du7vMykYPWFSWeC+hCO+khgXYfYijOlzY/RgLQKwAutVFvTthUQ0d9gAknm1F4/w+yn4H7oP5kS1O4I4pCrpjSaQwrRVa39hBis+dftrpwp15NHgUnRKbK1fS8oR1+PByATZWfZyJJ59wug7R8+DM4jiKBk8Iro5u2IJhsuXN5/Lp6D3fA/O51cDq0SGtHhNacHZN5JLfT6uSxF+gPTe45gYxa0mzvqX4Yp79iyzjCDsF8D4USCV4lSFtnD9gZdEqHM4aGOSClv6cxPRXo7wC/QDWuU546ums5fqvrB4P+tjknLE8OJrEhsVBsQSMGm/1JEhM5gLkBkHfFw/iwH7wwU1QqccxK8FSKa1o7Y2hpbWeMKDoQnt1/WioQurTDFlqh2fdkMT9fN3dOKvOa7DheX8psadZfuyDID4zOCBKo4uuWEd90mxF0D9tOJnCUsifEd2gEnPdrHqeYCJ5yWRVHnbqwGm8k= ryoung@Rodneys-MBP-2"
  }
  "two" = {
    name       = "two"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDup3XeZ38Hki00kZlng6Tefp8+tqiKJsO83du7vMykYPWFSWeC+hCO+khgXYfYijOlzY/RgLQKwAutVFvTthUQ0d9gAknm1F4/w+yn4H7oP5kS1O4I4pCrpjSaQwrRVa39hBis+dftrpwp15NHgUnRKbK1fS8oR1+PByATZWfZyJJ59wug7R8+DM4jiKBk8Iro5u2IJhsuXN5/Lp6D3fA/O51cDq0SGtHhNacHZN5JLfT6uSxF+gPTe45gYxa0mzvqX4Yp79iyzjCDsF8D4USCV4lSFtnD9gZdEqHM4aGOSClv6cxPRXo7wC/QDWuU546ums5fqvrB4P+tjknLE8OJrEhsVBsQSMGm/1JEhM5gLkBkHfFw/iwH7wwU1QqccxK8FSKa1o7Y2hpbWeMKDoQnt1/WioQurTDFlqh2fdkMT9fN3dOKvOa7DheX8psadZfuyDID4zOCBKo4uuWEd90mxF0D9tOJnCUsifEd2gEnPdrHqeYCJ5yWRVHnbqwGm8k= ryoung@Rodneys-MBP-2"
  }
}