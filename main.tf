terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # pick your region
}

# Lightsail WordPress instance
resource "aws_lightsail_instance" "wordpress" {
  name              = "wp-pci-demo"
  availability_zone = "us-east-1a"

  # These blueprint/bundle IDs are common examples.
  # Double-check them in the AWS console or Lightsail docs.
  blueprint_id = "wordpress"   # WordPress blueprint
  bundle_id    = "nano_2_0"    # smallest plan; use "micro_2_0" if needed

  tags = {
    Project = "wordpress-pci-demo"
  }
}

# Optional: static IP so your URL doesn't change if the instance is recreated
resource "aws_lightsail_static_ip" "wp_ip" {
  name = "wp-pci-demo-ip"
}

resource "aws_lightsail_static_ip_attachment" "wp_ip_attach" {
  static_ip_name  = aws_lightsail_static_ip.wp_ip.name
  instance_name   = aws_lightsail_instance.wordpress.name
}

output "wordpress_public_ip" {
  value = aws_lightsail_static_ip.wp_ip.ip_address
}

output "wordpress_url" {
  value = "http://${aws_lightsail_static_ip.wp_ip.ip_address}"
}
