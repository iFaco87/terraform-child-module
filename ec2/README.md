# ec2
This module sets up a Go Beyond offering in an AWS EC2.

## Resources Provided
This module will set up the following:

* an arbitrary number of ec2 instances
* an arbitrary number of keypairs for those instances
* always uses the latest Ubuntu 22 LTS AMI

## Design Considerations
This module does not handle security groups internally. The user needs to create them in the root module and feed them in. The example root module uses the recommended method, Cloudposse's [security group module](https://registry.terraform.io/modules/cloudposse/security-group/aws/latest).

The decision to leave Security Groups out was a compromise between maintaining control of SG creation and maintainability of Terraform code. It should be used in Root modules following Terraform best practice (keep module hierarchy as flat as possible). This also makes it easier to match SGs with the appropriate ec2 instances.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.79.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.79.0 |

## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_security_groups.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_groups) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_filter_name"></a> [ami\_filter\_name](#input\_ami\_filter\_name) | n/a | `string` | `"ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"` | no |
| <a name="input_ami_filter_owners"></a> [ami\_filter\_owners](#input\_ami\_filter\_owners) | n/a | `string` | `"099720109477"` | no |
| <a name="input_ami_filter_virtualization_type"></a> [ami\_filter\_virtualization\_type](#input\_ami\_filter\_virtualization\_type) | n/a | `string` | `"hvm"` | no |
| <a name="input_ami_most_recent"></a> [ami\_most\_recent](#input\_ami\_most\_recent) | n/a | `bool` | `true` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | the key for each instance will be the hostname | ```map(object({ key_name = string instance_type = string subnet_id = string security_group_ids = optional(list(string)) associate_public_ip_address = optional(bool, false) monitoring = optional(bool, false) private_ip = optional(string, null) secondary_private_ips = optional(list(string), []) instance_profile = optional(string, null) user_data = optional(string, null) volume_size = optional(number, 8) volume_type = optional(string, "gp3") extra_tags = optional(map(string), {}) ami = optional(string, null) }))``` | n/a | yes |
| <a name="input_keypairs"></a> [keypairs](#input\_keypairs) | n/a | ```map(object({ name = string public_key = string }))``` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->