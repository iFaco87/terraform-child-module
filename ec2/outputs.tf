output "ec2_id" {
  value = values(aws_instance.this)[*].id
  }
