##########################################################
# Example for Red5 Pro Stream Manager cluster deployment #
##########################################################

provider "aws" {
  region     = "us-west-1"                                                    # AWS region
  access_key = ""                                                             # AWS IAM Access key
  secret_key = ""                                                             # AWS IAM Secret key
}

module "red5pro" {
  source = "./modules/red5pro-aws"

  type = "cluster"                                                            # Deployment type: single, cluster, autoscaling
  name = "red5pro-cluster"                                                    # Name to be used on all the resources as identifier

  # AWS authetification variables it use for Stream Manager autoscaling configuration
  aws_region     = "us-west-1"                                               # AWS region 
  aws_access_key = ""                                                        # AWS IAM Access key
  aws_secret_key = ""                                                        # AWS IAM Secret key

  # SSH key configuration
  ssh_key_create          = false                                             # true - create new SSH key, false - use existing SSH key
  ssh_key_name            = "red5pro"                                         # Name for new SSH key or for existing SSH key
  ssh_private_key_path    = "/PATH/TO/EXISTING/SSH/PRIVATE/KEY/red5pro.pem"   # Path to existing SSH private key
  
  # VPC configuration
  vpc_create              = false                                              # true - create new VPC, false - use existing VPC
  vpc_id_existing         = "vpc-b310bfd7"                                    # VPC ID for existing VPC

  # MySQL DB configuration
  mysql_rds_create        = false                                             # true - create new RDS instance, false - install local MySQL server on the Stream Manager EC2 instance
  mysql_rds_instance_type = "db.t2.micro"                                     # Instance type for RDS instance
  mysql_user_name         = "smadmin"                                         # MySQL user name
  mysql_password          = "password"                                        # MySQL password
  mysql_port              = 3306                                              # MySQL port

  # Stream Manager Elastic IP configuration
  elastic_ip_create       = false                                             # true - create new elastic IP, false - use existing elastic IP
  elastic_ip_existing     = "52.53.69.196"                                    # Elastic IP for existing elastic IP

  # Stream Manager HTTPS/SSL certificate configuration
  https_letsencrypt_enable                   = true                           # true - create new Let's Encrypt HTTPS/SSL certificate, false - use Red5 Pro server without HTTPS/SSL certificate
  https_letsencrypt_certificate_domain_name  = "terra-sm-cluster.red5.net"    # Domain name for Let's Encrypt SSL certificate
  https_letsencrypt_certificate_email        = "oles@infrared5.com"           # Email for Let's Encrypt SSL certificate
  https_letsencrypt_certificate_password     = "abc123"                       # Password for Let's Encrypt SSL certificate

  # Stream Manager configuration 
  stream_manager_instance_type  = "t3.medium"                                 # Instance type for Stream Manager
  stream_manager_volume_size    = 20                                          # Volume size for Stream Manager
  stream_manager_api_key        = "abc123"                                    # API key for Stream Manager

  # Red5 Pro general configuration
  red5pro_license_key           = "1111-2222-3333-4444"                       # Red5 Pro license key (https://account.red5pro.com/login)
  red5pro_cluster_key           = "abc123"                                    # Red5 Pro cluster key
  red5pro_api_enable            = true                                        # true - enable Red5 Pro server API, false - disable Red5 Pro server API (https://qa-site.red5pro.com/docs/development/api/overview/#gatsby-focus-wrapper)
  red5pro_api_key               = "abc123"                                    # Red5 Pro server API key (https://qa-site.red5pro.com/docs/development/api/overview/#gatsby-focus-wrapper)

  # Red5 Pro autoscaling Origin node image configuration
  origin_image_instance_type                      = "t3.medium"               # Instance type for Origin node image
  origin_image_volume_size                        = 8                         # Volume size for Origin node image
  origin_image_red5pro_inspector_enable           = false                     # true - enable Red5 Pro server inspector, false - disable Red5 Pro server inspector (https://www.red5pro.com/docs/troubleshooting/inspector/overview/#gatsby-focus-wrapper)
  origin_image_red5pro_restreamer_enable          = false                     # true - enable Red5 Pro server restreamer, false - disable Red5 Pro server restreamer (https://qa-site.red5pro.com/docs/special/restreamer/overview/#gatsby-focus-wrapper)
  origin_image_red5pro_socialpusher_enable        = false                     # true - enable Red5 Pro server socialpusher, false - disable Red5 Pro server socialpusher (https://www.red5pro.com/docs/special/social-media-plugin/overview/#gatsby-focus-wrapper)
  origin_image_red5pro_suppressor_enable          = false                     # true - enable Red5 Pro server suppressor, false - disable Red5 Pro server suppressor
  origin_image_red5pro_hls_enable                 = false                     # true - enable Red5 Pro server HLS, false - disable Red5 Pro server HLS (https://www.red5pro.com/docs/protocols/hls-plugin/hls-vod/#gatsby-focus-wrapper)
  origin_image_red5pro_round_trip_auth_enable     = false                     # true - enable Red5 Pro server round trip authentication, false - disable Red5 Pro server round trip authentication (https://qa-site.red5pro.com/docs/special/round-trip-auth/overview/)

  # Red5 Pro autoscaling Edge node image configuration - (Optional)
  edge_image_create                               = false                     # true - create new Edge node image, false - not create new Edge node image
  edge_image_instance_type                        = "t3.medium"               # Instance type for Edge node image
  edge_image_volume_size                          = 8                         # Volume size for Edge node image
  edge_image_red5pro_inspector_enable             = false                     # true - enable Red5 Pro server inspector, false - disable Red5 Pro server inspector (https://www.red5pro.com/docs/troubleshooting/inspector/overview/#gatsby-focus-wrapper)
  edge_image_red5pro_restreamer_enable            = false                     # true - enable Red5 Pro server restreamer, false - disable Red5 Pro server restreamer (https://qa-site.red5pro.com/docs/special/restreamer/overview/#gatsby-focus-wrapper)
  edge_image_red5pro_socialpusher_enable          = false                     # true - enable Red5 Pro server socialpusher, false - disable Red5 Pro server socialpusher (https://www.red5pro.com/docs/special/social-media-plugin/overview/#gatsby-focus-wrapper)
  edge_image_red5pro_suppressor_enable            = false                     # true - enable Red5 Pro server suppressor, false - disable Red5 Pro server suppressor
  edge_image_red5pro_hls_enable                   = false                     # true - enable Red5 Pro server HLS, false - disable Red5 Pro server HLS (https://www.red5pro.com/docs/protocols/hls-plugin/hls-vod/#gatsby-focus-wrapper)
  edge_image_red5pro_round_trip_auth_enable       = false                     # true - enable Red5 Pro server round trip authentication, false - disable Red5 Pro server round trip authentication (https://qa-site.red5pro.com/docs/special/round-trip-auth/overview/)

  # Red5 Pro autoscaling Transcoder node image configuration - (Optional)
  transcoder_image_create                         = false                     # true - create new Transcoder node image, false - not create new Edge node image
  transcoder_image_instance_type                  = "t3.medium"               # Instance type for Transcoder node image
  transcoder_image_volume_size                    = 8                         # Volume size for Transcoder node image
  transcoder_image_red5pro_inspector_enable       = false                     # true - enable Red5 Pro server inspector, false - disable Red5 Pro server inspector (https://www.red5pro.com/docs/troubleshooting/inspector/overview/#gatsby-focus-wrapper)
  transcoder_image_red5pro_restreamer_enable      = false                     # true - enable Red5 Pro server restreamer, false - disable Red5 Pro server restreamer (https://qa-site.red5pro.com/docs/special/restreamer/overview/#gatsby-focus-wrapper)
  transcoder_image_red5pro_socialpusher_enable    = false                     # true - enable Red5 Pro server socialpusher, false - disable Red5 Pro server socialpusher (https://www.red5pro.com/docs/special/social-media-plugin/overview/#gatsby-focus-wrapper)
  transcoder_image_red5pro_suppressor_enable      = false                     # true - enable Red5 Pro server suppressor, false - disable Red5 Pro server suppressor
  transcoder_image_red5pro_hls_enable             = false                     # true - enable Red5 Pro server HLS, false - disable Red5 Pro server HLS (https://www.red5pro.com/docs/protocols/hls-plugin/hls-vod/#gatsby-focus-wrapper)
  transcoder_image_red5pro_round_trip_auth_enable = false                     # true - enable Red5 Pro server round trip authentication, false - disable Red5 Pro server round trip authentication (https://qa-site.red5pro.com/docs/special/round-trip-auth/overview/)

  # Red5 Pro autoscaling Relay node image configuration - (Optional)
  relay_image_create                              = false                     # true - create new Relay node image, false - not create new Edge node image
  relay_image_instance_type                       = "t3.medium"               # Instance type for Relay node image
  relay_image_volume_size                         = 8                         # Volume size for Relay node image
  relay_image_red5pro_inspector_enable            = false                     # true - enable Red5 Pro server inspector, false - disable Red5 Pro server inspector (https://www.red5pro.com/docs/troubleshooting/inspector/overview/#gatsby-focus-wrapper)
  relay_image_red5pro_restreamer_enable           = false                     # true - enable Red5 Pro server restreamer, false - disable Red5 Pro server restreamer (https://qa-site.red5pro.com/docs/special/restreamer/overview/#gatsby-focus-wrapper)
  relay_image_red5pro_socialpusher_enable         = false                     # true - enable Red5 Pro server socialpusher, false - disable Red5 Pro server socialpusher (https://www.red5pro.com/docs/special/social-media-plugin/overview/#gatsby-focus-wrapper)
  relay_image_red5pro_suppressor_enable           = false                     # true - enable Red5 Pro server suppressor, false - disable Red5 Pro server suppressor
  relay_image_red5pro_hls_enable                  = false                     # true - enable Red5 Pro server HLS, false - disable Red5 Pro server HLS (https://www.red5pro.com/docs/protocols/hls-plugin/hls-vod/#gatsby-focus-wrapper)
  relay_image_red5pro_round_trip_auth_enable      = false                     # true - enable Red5 Pro server round trip authentication, false - disable Red5 Pro server round trip authentication (https://qa-site.red5pro.com/docs/special/round-trip-auth/overview/)

  # Red5 Pro tags configuration - it will be added to all Red5 Pro resources

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "red5pro"
  }
}

output "module_output" {
  value = module.red5pro
}