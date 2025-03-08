locals {
  bastion_security_group_id = module.sg_bastion.id
  db_security_group_id      = module.sg_db.id
  private_subnet_ids        = module.network.private_subnet_ids
  instances = {
    "bastion" = {
      key_name                    = "one"
      instance_type               = "t2.micro"
      subnet_id                   = local.private_subnet_ids[0]
      security_group_ids          = [local.bastion_security_group_id]
      associate_public_ip_address = false
      monitoring                  = false
      volume_size                 = 20
      volume_type                 = "gp3"
    }
    "db" = {
      key_name                    = "two"
      instance_type               = "t2.micro"
      subnet_id                   = local.private_subnet_ids[1]
      security_group_ids          = [local.db_security_group_id]
      associate_public_ip_address = false
      monitoring                  = false
      extra_tags = {
        Custom = "tagging"
      }
    }
  }
}