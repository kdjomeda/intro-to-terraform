resource "aws_security_group" "allow_ssh_from_public" {
  name = "single_node_secgroup"
  description = "simple Security Group for the single node"

  ingress {
    from_port = 22 // port to allow connection from ie to allow port range such as 20-26. this will be 20
    to_port = 22 // port to allow connection to ie to allow port range such as 20-26. this will be 26
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // This opens the node to the world. This is not good for production systems
    description = "allow connection to ssl port"
  }

  egress {  // most of the time the egress is always needed. Here you can retrict the node out bound connection
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my-identity-pem" {
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8YsFK22z0OAJ1YdsBESQDnwJxTb/36EN1Zeymo2CksmPtURxp524nud0cI6uBCsCAgsYXaT3p7ijtmkDKA8tnIWr9pjfswUByUaJPKhnxp2r/V16U/VjgDs0RyTxQ0lo+hoy0OUVgapw9cXrtGBPukAT4qRVe8JLM7FDEMmGu8pkntgBbFneuj84YTHR4jcLzpF1FdoS+88ks9Oaw76bVlvJfLEeSDV7xdvF8IXqMznfoLPfe0gP0PTJ+bmLYwXfjlP7CUPPYEKG1sQHGEcKCs81QyncK6IwKSTwnpZX4YD/m45Yi0xi22tqI4qJ4oSN8Q2hNoAhS3/gCZXd6AiKDVJoVe6gQ5QpfCA+ZP21AH6z0T6HmPSvu6dbCm+qDfDGckysqwQBpHQANMLhWDEA7uVjr9Wpgyx60H1oCl2zYW40kcwBqO2i4tqQ+BnpZBgEPTn8DA0rn8LcfTNS/blrDIfJTYuYgW8HnCeT8hshelbux9B2YhAQE3AF1hQzFlgu23RHDcRHNQemkC20f4C8RAZcoY6ET99Xe+Ke46bHUcqOMK3oLKcCKfER3HLDHdAnaw5hJ2qkQEnDfYGBRCSRfetM0sCB7f3peYoH7WyTSR0/Qhn5iDWdjTqeopcIDY4KwEqag6rm3evLawnarUxnkvM6ez+A0OVTiUn7ZcndCTw== AWS Tutorial Usage"
  key_name = "MyIdentity.pem"
}

resource "aws_instance" "single-node-no-vpc" {
  ami = "ami-03248a0341eadb1f1"
  instance_type = "t2.nano"
  associate_public_ip_address = true // This allows the AWS to assign a public IP to the nonde
  security_groups = [aws_security_group.allow_ssh_from_public.name] // assigning the security group defined above
  key_name = aws_key_pair.my-identity-pem.key_name

  tags = {
    Name = "SingleNodeNoVPC"
    Env  = "Tutorial"
    Product = "DemoPurpose"
    Terraform = true
  }

}