# VPC > User scenario > Scenario 1. Single Public Subnet
# https://docs.ncloud.com/ko/networking/vpc/vpc_userscenario1.html

provider "ncloud" {
  support_vpc = true
  region      = "KR"
  access_key  = var.access_key
  secret_key  = var.secret_key
}

resource "ncloud_login_key" "key_ncp_login" {
  key_name = var.server_token
}

resource "ncloud_vpc" "vpc_scn_01" {
  name            = var.name_ncp_login
  ipv4_cidr_block = "192.168.0.0/16"
}

resource "ncloud_subnet" "subnet_scn_01" {
  name           = var.name_ncp_login
  vpc_no         = ncloud_vpc.vpc_scn_01.id
  subnet         = cidrsubnet(ncloud_vpc.vpc_scn_01.ipv4_cidr_block, 8, 1)
  // 192.168.1.0/24
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc_scn_01.default_network_acl_no
  subnet_type    = "PUBLIC"
  // PUBLIC(Public) | PRIVATE(Private)
}

resource "ncloud_server" "server_scn_01" {
  subnet_no                 = ncloud_subnet.subnet_scn_01.id
  name                      = var.name_ncp_login
  server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR2004.B050" //ubuntu 20.04
  //login_key_name            = ncloud_login_key.key_ncp_login.key_name
}

resource "ncloud_public_ip" "public_ip_scn_01" {
  server_instance_no = ncloud_server.server_scn_01.id
  description        = "for ${var.name_ncp_login}"
}

locals {
  scn01_inbound = [
    [1, "TCP", "0.0.0.0/0", "80", "ALLOW"],
    [2, "TCP", "0.0.0.0/0", "443", "ALLOW"],
    [3, "TCP", "${var.client_ip}/32", "22", "ALLOW"],
    [4, "TCP", "${var.client_ip}/32", "3389", "ALLOW"],
    [5, "TCP", "0.0.0.0/0", "8080", "ALLOW"],
    [6, "TCP", "0.0.0.0/0", "10022", "ALLOW"],
    [7, "TCP", "0.0.0.0/0", "20022", "ALLOW"],
    [8, "TCP", "0.0.0.0/0", "8001", "ALLOW"],
    [9, "TCP", "0.0.0.0/0", "32768-65535", "ALLOW"],
    [197, "TCP", "0.0.0.0/0", "1-65535", "DROP"],
    [198, "UDP", "0.0.0.0/0", "1-65535", "DROP"],
    [199, "ICMP", "0.0.0.0/0", null, "DROP"],
  ]

  scn01_outbound = [
    [1, "TCP", "0.0.0.0/0", "80", "ALLOW"],
    [2, "TCP", "0.0.0.0/0", "443", "ALLOW"],
    [3, "TCP", "${var.client_ip}/32", "1000-65535", "ALLOW"],
    [197, "TCP", "0.0.0.0/0", "1-65535", "DROP"],
    [198, "UDP", "0.0.0.0/0", "1-65535", "DROP"],
    [199, "ICMP", "0.0.0.0/0", null, "DROP"]
  ]
}

resource "ncloud_network_acl_rule" "network_acl_01_rule" {
  network_acl_no = ncloud_vpc.vpc_scn_01.default_network_acl_no
  dynamic "inbound" {
    for_each = local.scn01_inbound
    content {
      priority    = inbound.value[0]
      protocol    = inbound.value[1]
      ip_block    = inbound.value[2]
      port_range  = inbound.value[3]
      rule_action = inbound.value[4]
      description = "for ${var.name_ncp_login}"
    }
  }

  dynamic "outbound" {
    for_each = local.scn01_outbound
    content {
      priority    = outbound.value[0]
      protocol    = outbound.value[1]
      ip_block    = outbound.value[2]
      port_range  = outbound.value[3]
      rule_action = outbound.value[4]
      description = "for ${var.name_ncp_login}"
    }
  }
}