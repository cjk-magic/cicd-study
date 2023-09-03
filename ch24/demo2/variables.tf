variable "access_key" { # export TF_VAR_access_key=...
  default = "XHlOWGDEpFbjJ0iBVv4a"
}

variable "secret_key" { # export TF_VAR_secret_key=...
  default = "WRyx4NV1U7YP3TCamNPIGFkEpgutBIpDcbrwVN7V"
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
