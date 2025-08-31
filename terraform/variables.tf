variable "do_token" {}
variable "ssh_key_name" {
  default = "lurekit-key"
}
variable "ssh_public_key" {}
variable "phish_domain" {}
variable "redirect_domain" {}
variable "region" {
  default = "lon1"
}