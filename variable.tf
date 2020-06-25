variable "aws_profile" {
  description = "the aws profile to be used in the setup"
}

variable "aws_region" {
  description = "the aws region to be used in the setup"
}

variable "vpc_cidr" {
  description = "the address range of our vpc"
}

variable "product" {
  description = "name of the product the setup is for"
  default = "handson"
}

variable "environment" {
  description = "the environment the setup it meant for"
  default = "tutorial"
}

variable "vpc_name_suffix" {
  description = "name to append to the vpc as part of the naming convention"
}

variable "vpc_subnets_cidr_map" {
  description = "dictionary of corresponding cidr subnets"
  type = map(string)
}

variable "service_secgroup_suffix" {
  description = "suffix to append to naming convention for the security group"
}

variable "service_http_port" {
  description = "http port to be opened for the service instance"
}
variable "service_https_port" {
  description = "https port to be opened for the service instance"
}

variable "service_ssh_port" {
  description = "ssh port to be opened for the service instance"
}

variable "service_ssh_key_name" {
  description = "name of the ssh key name to use"
}

variable "service_ami" {
  description = "ID of the OS AMI to use"
}

variable "service_instance_type" {
  description = "The type/size of the instance to use on AWS"
}

variable "service_storage_type" {
  description = "The type of storage to use standard,gp2 etc"
}

variable "service_storage_size" {
  description = "The size of the storage to use"
}

variable "service_intsance_tag_name_suffix" {
  description = "suffix to use for the tag name"
}

variable "db_subnet_group_name_suffix" {
  description = "name to append to the naming convention for the subnet group"
}

variable "db_param_group_name_suffix" {
  description = "identifier of the parameter group in AWS"
}

variable "db_param_group_family" {
  description = "engine family for which to create the parameter group for"
}

variable "db_access_port" {
  description = "database port"
  default = 7708
}

variable "db_sec_group_name_suffix" {
  description = "actually the suffix of our db sec group name"
}

variable "db_instance_class" {
  description = "size of the db instance "
}

variable "db_instance_storage_type" {
  description = "type of db storage to use ie, magnetic,gp2 etc"
}

variable "db_instance_storage_size" {
  description = "size of the storage to use id 5GB, 10GB etc"
}

variable "db_instance_engine" {
  description = "name of the RDS compatible db to use, mysql,mssql,oracledb"
}

variable "db_instance_engine_version" {
  description = "version number corresponding to the engine chosen"
}

variable "db_instance_identifier" {
  description = "identifier name for the database instace on AWS"
}

variable "db_instance_username" {
  description = "superuser/root username of the database"
}

variable "db_instance_password" {
  description = "password of the superuser/root"
}

variable "db_instance_multiaz" {
  description = "boolean corresponding to lanching in AZ mode or not"
}

variable "db_instance_skip_finalsnapshot" {
  description = "boolean corresponding to choice of taking snapshot when db is being destroyed"
  type = bool
}