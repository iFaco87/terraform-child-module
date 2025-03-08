# key_name can be one of the keypairs declared with this module
# the root module is most competent to create security groups, so create them there and feed them in
variable "instances" {
  nullable    = false
  description = "the key for each instance will be the hostname"
  type = map(object({
    key_name                    = string
    instance_type               = string
    subnet_id                   = string
    security_group_ids          = optional(list(string))
    associate_public_ip_address = optional(bool, false)
    monitoring                  = optional(bool, false)
    private_ip                  = optional(string, null)
    secondary_private_ips       = optional(list(string), [])
    instance_profile            = optional(string, null)
    user_data                   = optional(string, null)
    volume_size                 = optional(number, 8)
    volume_type                 = optional(string, "gp3")
    extra_tags                  = optional(map(string), {})
    ami                         = optional(string, null)
  }))
}

variable "keypairs" {
  type = map(object({
    name       = string
    public_key = string
  }))
}

variable "ami_most_recent" {
  default = true
  type    = bool
}

variable "ami_filter_name" {
  default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  type    = string
}

variable "ami_filter_virtualization_type" {
  default = "hvm"
  type    = string
}

variable "ami_filter_owners" {
  default = "099720109477" # Canonical
  type    = string
}
