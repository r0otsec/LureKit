terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "lurekit" {
  name       = var.ssh_key_name
  public_key = file(var.ssh_public_key)
}

data "digitalocean_vpc" "default" {
  name = "default-lon1"
}

resource "digitalocean_droplet" "gophish" {
  name     = "lurekit-gophish"
  region   = var.region
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-22-04-x64"
  ssh_keys = [digitalocean_ssh_key.lurekit.id]
  vpc_uuid = data.digitalocean_vpc.default.id
  tags     = ["lurekit", "gophish"]
}

resource "digitalocean_droplet" "redirector" {
  name     = "lurekit-redirector"
  region   = var.region
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-22-04-x64"
  ssh_keys = [digitalocean_ssh_key.lurekit.id]
  vpc_uuid = data.digitalocean_vpc.default.id
  tags     = ["lurekit", "redirector"]
}

output "gophish_ip" {
  value = digitalocean_droplet.gophish.ipv4_address
}

output "redirector_ip" {
  value = digitalocean_droplet.redirector.ipv4_address
}
