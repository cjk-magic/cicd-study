variable "access_key" { # export TF_VAR_access_key=...
  default = "XXX"
}

variable "secret_key" { # export TF_VAR_secret_key=...
  default = "XXX"
}

variable "region" {
  default = "KR"
}

variable "server_name" {
  default = "terraform-test"
}

variable "server_image_product_code" { # Centos 7.3 64 bit
  default = "SPSW0LINUX000046"
}

variable "server_product_code" {
  default = "SPSVRHICPU000001" # vCpu 2, Memory 4G, Disk 50GB
}
