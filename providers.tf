variable "leanix_base_url" {
  default = "https://svc.leanix.net"
}

variable "leanix_api_token" {}

provider "aws" {
  region = "eu-central-1"
}

provider "leanix" {
  url       = "${var.leanix_base_url}"
  api_token = "${var.leanix_api_token}"
}
