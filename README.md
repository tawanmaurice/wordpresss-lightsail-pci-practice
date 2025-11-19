WordPress Lightsail PCI Practice (Terraform)

This project deploys a lightweight WordPress instance on AWS Lightsail using a simple Terraform configuration.
The goal is to create a safe, disposable environment where I can practice:

WordPress deployment

Infrastructure-as-Code (IaC) with Terraform

PCI DSS scanning and reporting

Basic AWS security tools

This setup is intentionally minimal, fast to deploy, and fast to tear down.

🚀 What This Project Does

When you run:

terraform apply


Terraform automatically:

Creates a Lightsail WordPress instance

Creates a Lightsail static IP

Attaches the IP to the instance

Outputs:

the public IP

the WordPress URL

The result is a functional WordPress site reachable via:

http://<static-ip>


Perfect for testing, learning, and running security scans.

🧱 Project Architecture

Services used:

Lightsail Instance (WordPress)

Lightsail Static IP

Static IP Attachment

Terraform AWS Provider

Optional add-ons (for future updates):

Route 53 (custom domain)

CloudFront + ACM (HTTPS)

WAF + SecurityHeaders

GuardDuty / Macie

More PCI hardening steps

🛡️ Why Lightsail?

Lightsail makes it extremely easy to:

Spin up a clean WordPress environment

Avoid complex VPC, RDS, or ALB setups

Minimize cost

Reset the environment by simply running:

terraform destroy


This is ideal for PCI practice, especially when using:

Nmap

Nikto

WPScan

ZAP

SSL Labs

SecurityHeaders

ClamAV

The environment is disposable and safe to experiment with.

📂 File Structure
main.tf           -> Terraform configuration
.gitignore        -> Ensures Terraform junk doesn’t get committed


Terraform state and provider binaries are not committed to Git.

📝 Outputs

Terraform prints two important values:

wordpress_public_ip

wordpress_url

These can be used directly for testing or scanning.

🧹 Teardown

To destroy all resources and avoid charges:

terraform destroy

🔜 Next Steps (Planned)

Connect to real domain (wp.tawanperry.top)

Add HTTPS via ACM or Let’s Encrypt

Add CloudFront for PCI-friendly TLS

Add security monitoring (GuardDuty / CloudTrail)

Add README diagrams and screenshots
