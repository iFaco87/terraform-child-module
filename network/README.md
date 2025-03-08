# network
This module provides core network setup for Go Beyond AWS accounts.

## Resources Provided
This module will set up the following:

* One VPC
* public/private subnets per input variable
* one internet gateway for public subnets
* one nat gateway per private subnet (egress only)
* the appropriate routing tables

## Note on Tagging
Hard coded tags ("private", "public") are set on certain resources. These tags are useful in other modules' data sources. Highly recommended not to change them...you will break stuff.

For extra tags, there are variables that you can utilise for subnets and VPC.  
## Caveats

1. Under no circumstance do we want to overlap CIDR block ip space, so when choosing `vpc_cidr_block`. be sure to consult [confluence](https://gustazos.atlassian.net/wiki/spaces/GUS/pages/2657615873/AWS+VPC+CIDR+Matrix).
2. For correct `public_subnets` and `private_subnets` variable format, see examples directory.
3. The IP planning of subnets and VPC CIDRs is a separate problem from this module. The example directory's settings are not a template for those specific values.
4. The module supports ONE vpc at this time. It should be possible to source it in multiple resources in a root module, but the need to avoid overlapping any parameters is a root module concern if that is done.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.46.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.to_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.to_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable DNS hostnames for the VPC | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support for the VPC | `bool` | `true` | no |
| <a name="input_enable_network_address_usage_metrics"></a> [enable\_network\_address\_usage\_metrics](#input\_enable\_network\_address\_usage\_metrics) | Enable network address usage metrics | `bool` | `false` | no |
| <a name="input_extra_private_subnet_tags"></a> [extra\_private\_subnet\_tags](#input\_extra\_private\_subnet\_tags) | Extra Tags for Private Subnets | `map(string)` | `null` | no |
| <a name="input_extra_public_subnet_tags"></a> [extra\_public\_subnet\_tags](#input\_extra\_public\_subnet\_tags) | Extra Tags for Public Subnets | `map(string)` | `null` | no |
| <a name="input_extra_vpc_tags"></a> [extra\_vpc\_tags](#input\_extra\_vpc\_tags) | Extra Tags for VPC | `map(string)` | `null` | no |
| <a name="input_igw_name"></a> [igw\_name](#input\_igw\_name) | The name of the internet gateway | `string` | `"main"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | ```map(object({ name = string cidr_block = string availability_zone = string }))``` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | ```map(object({ name = string cidr_block = string availability_zone = string }))``` | n/a | yes |
| <a name="input_to_igw_cidr_block"></a> [to\_igw\_cidr\_block](#input\_to\_igw\_cidr\_block) | The CIDR block for the route table to the internet gateway | `string` | `"0.0.0.0/0"` | no |
| <a name="input_to_nat_cidr_block"></a> [to\_nat\_cidr\_block](#input\_to\_nat\_cidr\_block) | The CIDR block for the route table to the NAT gateway | `string` | `"0.0.0.0/0"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | `"main"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internet_gateway_arn"></a> [internet\_gateway\_arn](#output\_internet\_gateway\_arn) | n/a |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | n/a |
| <a name="output_nat_gateway_arns"></a> [nat\_gateway\_arns](#output\_nat\_gateway\_arns) | n/a |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | n/a |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | n/a |
| <a name="output_private_subnet_arns"></a> [private\_subnet\_arns](#output\_private\_subnet\_arns) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_arns"></a> [public\_subnet\_arns](#output\_public\_subnet\_arns) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->