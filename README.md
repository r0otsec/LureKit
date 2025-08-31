# LureKit

<p align="center">
  <img src="https://raw.githubusercontent.com/JonnyPake/LureKit/refs/heads/main/images/LureKitLogo.png" alt="lurekit" width="450" height="450"/>
</p>

>[!important]
>Currently under active development and testing. Full code will be released once all bugs are resolved. Do not download/run until release v1.0.0.

LureKit is a modern phishing infrastructure toolkit that helps you quickly deploy, manage, and destroy phishing environments for internal security assessments, social engineering simulations, and campaign testing - providing the ability to send phishing emails, serve branded landing pages, and collect credentials in a simple easy to use script.

# What It Does

- Sends phishing emails using Mailgun via SMTP
- Deploys GoPhish backend on a clean VPS with hardened configuration (removed standard IOCs)
- Deploys NGINX redirector with TLS and region-based filtering (optional)
- Supports multiple client subdomains like login.company.co.uk, mail.portalsite.net
- Uses Cloudflare for DNS management (can used other hosting providers)
- Can be taken offline/pointed to benign pages easily to protect domain reputation
- Designed to avoid detection and indexing by scanners (GeoIP, bot filters, anti-crawler rules)
- Fully automatable using Terraform + Ansible

# Components

| Component     | Purpose                            |
|---------------|------------------------------------|
| `GoPhish`     | Backend campaign + credential capture |
| `NGINX`       | TLS termination and redirector logic |
| `Mailgun`     | Email delivery with proper SPF/DKIM |
| `Terraform`   | VPS infrastructure provisioning (DigitalOcean) |
| `Ansible`     | VPS config: installs GoPhish, NGINX, TLS, etc |
| `.env`        | Operator-defined settings (domain, SMTP, ports) |

# Deployment Workflow

1. **Prepare config**  
   - Clone repo and create `.env` from `.env.example`
2. **Provision infrastructure**  
   - Use `terraform/` to deploy GoPhish + Redirector VPS
3. **Configure environments**  
   - Use `ansible/` to install and harden services
4. **Tunnel into GoPhish admin**  
   - SSH forward port to securely access admin UI
5. **Run phishing campaign**  
   - Send Mailgun SMTP emails to targets, capture via landing pages
6. **Clean up**  
   - Run `destroy-all.sh` or `terraform destroy` to decommission if necessary

# Requirements

A couple of requirements are necessary for this to run:

- Registered domain (e.g., `yourdomain.co.uk`)
- VPS 1: GoPhish backend (e.g., `phish.yourdomain.co.uk`)
- VPS 2: Redirector (e.g., `login.yourdomain.co.uk`)
- Verified Mailgun domain (w/ SMTP credentials)
- Cloudflare (optional, for DNS automation)
- Ubuntu 20.04 or 22.04 LTS

