/**
  Returning the EIP of the instance
*/
output "output_ec2_elastic_ip" {
  value = aws_instance.terraform_ec2_instance.public_ip
}

/**
  Returning the private IP of the instance
*/
output "output_ec2_private_ip" {
  value = aws_instance.terraform_ec2_instance.private_ip
}

/**
  Returning the endpoint of the DB instance
*/
output "output_db_endpoint" {
  value = aws_db_instance.terraform_db_instance.endpoint
}

/**
    Returning the port number of the DB instance
*/
output "output_db_actual_port" {
  value = aws_db_instance.terraform_db_instance.port
}