provider "ncloud" {
  support_vpc = true
  region      = "KR"
  access_key  = var.access_key
  secret_key  = var.secret_key
}

resource "ncloud_vpc" "vpc" {
    ipv4_cidr_block = "10.0.0.0/16"
}

resource "ncloud_subnet" "pub-sub" {  
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.1.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PUBLIC"
}

resource "ncloud_server" "server" {
  subnet_no                 = ncloud_subnet.pub-sub.id
  name                      = "my-tf-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
}
