######################################################################
# Example for single Red5 Pro server deployment
######################################################################

provider "aws" {
  region     = "us-west-1"
  access_key = ""
  secret_key = ""
}

module "red5pro" {
  source = "./modules/red5pro-aws"

  type = "single" # single, cluster, autoscaling
  name = "red5pro-single"

  # SSH key configuration
  ssh_key_create            = false                                           # true - create new SSH key, false - use existing SSH key
  ssh_key_name              = "red5pro"                                       # Name for new SSH key or for existing SSH key
  ssh_private_key_path      = "/PATH/TO/EXISTING/SSH/PRIVATE/KEY/red5pro.pem" # Path to existing SSH private key
  
  # VPC configuration
  vpc_create      = true                                                      # true - create new VPC, false - use existing VPC
  vpc_id_existing = "vpc-b310bfd7"                                            # VPC ID for existing VPC

  # Security group configuration
  security_group_create      = false                                          # true - create new security group, false - use existing security group
  security_group_id_existing = "sg-0f0b2b6b7f7b1b1a9"                         # Security group ID for existing security group

  # Elastic IP configuration
  elastic_ip_create           = false                                         # true - create new elastic IP, false - use existing elastic IP
  elastic_ip_existing         = "52.53.69.196"                                # Elastic IP for existing elastic IP

  # Single server HTTPS/SSL certificate configuration
  https_letsencrypt_enable                   = true                           # true - create new Let's Encrypt HTTPS/SSL certificate, false - use Red5 Pro server without HTTPS/SSL certificate
  https_letsencrypt_certificate_domain_name  = "terra-single-server.red5.net" # Domain name for Let's Encrypt SSL certificate
  https_letsencrypt_certificate_email        = "oles@infrared5.com"           # Email for Let's Encrypt SSL certificate
  https_letsencrypt_certificate_password     = "abc123"                       # Password for Let's Encrypt SSL certificate
  
  # EC2 instance configuration
  instance_type = "t2.medium"                                                 # Instance type for Red5 Pro server
  volume_size   = 8                                                           # Volume size for Red5 Pro server

  # Red5Pro server configuration
  red5pro_license_key           = "QGZG-2OLJ-7QPE-ELBW"                      # Red5 Pro license key (https://account.red5pro.com/login)
  red5pro_api_enable            = true                                       # true - enable Red5 Pro server API, false - disable Red5 Pro server API (https://qa-site.red5pro.com/docs/development/api/overview/#gatsby-focus-wrapper)
  red5pro_api_key               = "abc123"                                   # Red5 Pro server API key (https://qa-site.red5pro.com/docs/development/api/overview/#gatsby-focus-wrapper)
  red5pro_inspector_enable      = false                                      # true - enable Red5 Pro server inspector, false - disable Red5 Pro server inspector (https://www.red5pro.com/docs/troubleshooting/inspector/overview/#gatsby-focus-wrapper)
  red5pro_restreamer_enable     = false                                      # true - enable Red5 Pro server restreamer, false - disable Red5 Pro server restreamer (https://qa-site.red5pro.com/docs/special/restreamer/overview/#gatsby-focus-wrapper)
  red5pro_socialpusher_enable   = false                                      # true - enable Red5 Pro server socialpusher, false - disable Red5 Pro server socialpusher (https://www.red5pro.com/docs/special/social-media-plugin/overview/#gatsby-focus-wrapper)
  red5pro_suppressor_enable     = false                                      # true - enable Red5 Pro server suppressor, false - disable Red5 Pro server suppressor
  red5pro_hls_enable            = false                                      # true - enable Red5 Pro server HLS, false - disable Red5 Pro server HLS (https://www.red5pro.com/docs/protocols/hls-plugin/hls-vod/#gatsby-focus-wrapper)

  # Red5 Pro tags configuration - it will be added to all Red5 Pro resources
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "red5pro"
  }
}


output "ssh_key_name" {
  value = module.red5pro.ssh_key_name
}
output "ssh_private_key_path" {
  value = module.red5pro.ssh_private_key_path
}
output "vpc_id" {
  value = module.red5pro.vpc_id
}
output "vpc_name" {
  value = module.red5pro.vpc_name
}
output "subnet_ids" {
  value = module.red5pro.subnet_ids
}
output "elastic_ip" {
  value = module.red5pro.elastic_ip
}
output "https_domain_name" {
  value = module.red5pro.https_domain_name
}
