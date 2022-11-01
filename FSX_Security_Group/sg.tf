# locals {
#  # domain = local.region == "us-west-2" ? data.terraform_remote_state.managed_ad.outputs.west_ds_id : data.terraform_remote_state.managed_ad.outputs.east_ds_id
#  # domain_sg =  local.region == "us-west-2" ? data.terraform_remote_state.managed_ad.outputs.west_sg_id : data.terraform_remote_state.managed_ad.outputs.east_sg_id
#   managed_ad_ports_tcp_udp = ["53","88","464","389"]
#   managed_ad_ports_udp = ["123"]
#   managed_ad_ports_tcp = ["135","445","636","3268","3269","5985","9389"]
#   managed_ad_ports_tcp_range = {
#     ephimeral_ports = {
#       from_port = "49152"
#       to_port = "65535"
#     }
#   }
# }

# resource "aws_security_group" "fsx_i" {
#   name        = "test-fsx-i-sg"
#   description = "FSx instance security group"
#   vpc_id      = "vpc-04a0d8740d7bf122d"
# }
 
# resource "aws_security_group_rule" "ingress_smb_transfer" {
#   security_group_id        = aws_security_group.fsx_i.id
#   type                     = "ingress"
#   protocol                 = "tcp"
#   from_port                = 445
#   to_port                  = 445
#   cidr_blocks = [
#     "10.16.16.0/20"
#   ] 
#   description              = "Allow Inbound SMB from the transfer box"
# }
 
# resource "aws_security_group_rule" "egress_fsx_managed_ad_tcp" {
#   for_each = toset(concat(local.managed_ad_ports_tcp_udp,local.managed_ad_ports_tcp))
#   security_group_id        = aws_security_group.fsx_i.id
#   type                     = "egress"
#   protocol                 = "tcp"
#   from_port                = each.value
#   to_port                  = each.value
#   cidr_blocks = [
#     "10.16.16.0/20"
#   ] 
#    description              = "Allow Outbound ${each.value} from the FSx to managed AD"
# }
 
# resource "aws_security_group_rule" "egress_fsx_managed_ad_udp" {
#   for_each = toset(concat(local.managed_ad_ports_tcp_udp,local.managed_ad_ports_udp))
#   security_group_id        = aws_security_group.fsx_i.id
#   type                     = "egress"
#   protocol                 = "udp"
#   from_port                = each.value
#   to_port                  = each.value
#   cidr_blocks = [
#     "10.16.16.0/20"
#   ] 
#    description              = "Allow Outbound ${each.value} from the FSx to managed AD"
# }
 
# resource "aws_security_group_rule" "egress_fsx_managed_ad_tcp_range" {
#   for_each = local.managed_ad_ports_tcp_range
#   security_group_id        = aws_security_group.fsx_i.id
#   type                     = "egress"
#   protocol                 = "tcp"
#   from_port                = each.value.from_port
#   to_port                  = each.value.to_port
#   cidr_blocks = [
#     "10.16.16.0/20"
#   ] 
#    description              = "Allow Outbound from ${each.value.from_port} to ${each.value.to_port} from the FSx to managed AD"
# }