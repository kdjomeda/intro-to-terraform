aws_profile     =  "blacksensei"
aws_region     = "us-east-1"
vpc_cidr     = "10.10.0.0/16"
//product  we have default value already set for this     = "
//environment we have default value already set for this     = "
vpc_name_suffix     = "terraform_vpc"
vpc_subnets_cidr_map     = {
"public_a" = "10.10.0.0/24"
"public_b" = "10.10.1.0/24"
"private_a" = "10.10.10.0/24"
"private_b" = "10.10.11.0/24"
"private_c" = "10.10.12.0/24"
}
service_secgroup_suffix     = "terraform_app_secgroup"
service_http_port     = 80
service_https_port     = 443
service_ssh_port     = 22
service_ssh_key_name     = "MyIdentity.pem"
service_ami     = "ami-068663a3c619dd892"
service_instance_type     = "t2.micro"
service_storage_type     = "gp2"
service_storage_size     = 30
service_intsance_tag_name_suffix = "terraform_app"
db_subnet_group_name_suffix     = "terraform_subnetgroup"
db_param_group_name_suffix     = "terraform-param-gr"
db_param_group_family     = "mysql8.0"
//db_access_port has a default value     = "
db_sec_group_name_suffix     = "terraform-db-sec-group"
db_instance_class     = "db.t2.micro"
db_instance_storage_type     = "gp2"
db_instance_storage_size     = 5
db_instance_engine     = "mysql"
db_instance_engine_version     = "8.0"
db_instance_identifier     = "terraform-db"
db_instance_username     = "terraform_user"
//db_instance_password     = ""
db_instance_multiaz     = true
db_instance_skip_finalsnapshot     = true