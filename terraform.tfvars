network_name = "cg-stg-gcp-vpc"
project_id   = "gamehub-stg1"
mtu = 1460
region = "us-central1"
zone   = "us-central1-a"
bastion_name = "cg-stg-gcp-bastion"
service_account_name_bastion = "cg-stg-gcp-sa-bastion"
tags_bastion = ["bastion", "iap-access", "http-server", "https-server", "glb-class0", "glb-class1"]
subnets = [
  {
    subnet_name                      = "cg-stg-public-subnet-1"
    subnet_ip                        = "10.0.2.0/24"
    subnet_region                    = "us-central1"
    # Các trường không cần thiết có thể bỏ qua vì sẽ sử dụng giá trị mặc định
  },
  {
    subnet_name                      = "cg-stg-public-subnet-2"
    subnet_ip                        = "10.0.3.0/24"
    subnet_region                    = "us-central1"
    # Các trường không cần thiết có thể bỏ qua vì sẽ sử dụng giá trị mặc định
  },
  {
    subnet_name                      = "cg-stg-bastion-subnet"
    subnet_ip                        = "10.0.4.0/24"
    subnet_region                    = "us-central1"
    # Các trường không cần thiết có thể bỏ qua vì sẽ sử dụng giá trị mặc định
  }
]

ingress_rules = [
  {
    name = "firewall-rule-for-bastion"
    description = "Allow SSH to bastion on port 4222"
    priority = 1000
    disabled = false
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["bastion"]
    allow = [
      {
        protocol = "tcp"
        ports    = ["4222"]
      }
    ]
    deny       = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  },
  {
    name        = "firewall-rule-for-iap"
    description = "Allow IAP access to the instance on port 443"
    priority    = 1001
    disabled    = false
    source_ranges = ["35.235.240.0/20"] # IP ranges cho IAP từ Google Cloud (hoặc tùy chỉnh nếu cần)
    target_tags   = ["iap-access"]
    allow = [
      {
        protocol = "tcp"
        ports    = ["22"] # Port cần thiết cho IAP (hoặc port khác nếu cần)
      }
    ]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }
]
