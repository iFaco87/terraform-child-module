output "ec2_id" {
  value = {
    for k, ec2_id in aws_instance.this.id : k => ec2_id.id
  }
  }
