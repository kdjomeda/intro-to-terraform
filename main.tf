/**
    Using Terraform data source of type aws_availability_zones to
    pull the availability zones (AZs) that available in our AWS
    region.
*/
data "aws_availability_zones" "azones" {}
/**
  Creating our vpc with it's IP range.
  We enabled a vpc dns support
  We also enabled the dns hostname support
  Tags are also used to map the resource with specific groupings
*/
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name        = "handson_tutorial_terraform_vpc"  // this Name tag is what is displayed as name of the VPC
    Env         = "tutorial"
    Product     = "handson"
    Terraform   = true
  }
}

/**
  Creating an aws internet gateway to allow communicationn between the vpc and internet
  We launched it in the vpc using its id
*/
resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id //This is a reference to the id of VPN for whic id is known at runtime
  tags = {
    Name        = "handson_tutorial_terraform_vpc_igw"
    Env         = "tutorial"
    Product     = "handons"
    Terraform   = true
  }
}

/**
  This is the IP that will be attached to our NAT Gateway
  for outbounds calls for nodes in private subnets
*/
resource "aws_eip" "terraform_nat_eip" {
  vpc = true
  tags = {
    Name        = "handson_tutorial_terraform_nat_iep"
    Env         = "tutorial"
    Product     = "handson"
    Terraform   = true
  }
}


resource "aws_route_table" "terraform_public_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name        = "handson_tutorial_terraform_public_rtable"
    Env         = "tutorial"
    Product     = "handons"
    Terraform   = true
  }
}

/**
  Creating a public route in the public route table
  This uses the internet gateway created above
*/
resource "aws_route" "terraform_public_route" {
  route_table_id = aws_route_table.terraform_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.terraform_igw.id
}

/**
  Creating a subnet with it's IP range
  In our VPC using its id. Assigning the first availability
  name from our AZs data source to its AZ name.
  Note though its name says so,there is nothing public or private about it
*/
resource "aws_subnet" "terraform_public_subnet_a" {
  cidr_block = "10.10.0.0/24"
  vpc_id = aws_vpc.terraform_vpc.id
  availability_zone = data.aws_availability_zones.azones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "handson_tutorial_terraform_public_subnet_a"
    Env         = "tutorial"
    Product     = "handons"
    Terraform   = true
  }
}

/**
  Creating a subnet with it's IP range
  In our VPC using its id. Assigning the second availability
  name from our AZs data source to its AZ name.
  Note though its name says so,there is nothing public or private about it
*/
resource "aws_subnet" "terraform_public_subnet_b" {
  cidr_block = "10.10.1.0/24"
  vpc_id = aws_vpc.terraform_vpc.id
  availability_zone = data.aws_availability_zones.azones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "handson_tutorial_terraform_public_subnet_b"
    Env         = "tutorial"
    Product     = "handons"
    Terraform   = true
  }
}

/**
  Making public subnet A actually public
  by associating it with the public route table
*/
resource "aws_route_table_association" "terraform_public_subnet_a_rtable_assoc" {
  route_table_id = aws_route_table.terraform_public_route_table.id
  subnet_id = aws_subnet.terraform_public_subnet_a.id
}

/**
  Making public subnet B actually public
  by associating it with the public route table
*/
resource "aws_route_table_association" "terraform_public_subnet_b_rtable_assoc" {
  route_table_id = aws_route_table.terraform_public_route_table.id
  subnet_id = aws_subnet.terraform_public_subnet_b.id
}

/**
     Creating the NAT Gateway in a public subnet for it
     to have access to internet through the Internet Gateway
*/
resource "aws_nat_gateway" "terraform_nat_gtw" {
  allocation_id = aws_eip.terraform_nat_eip.id
  subnet_id = aws_subnet.terraform_public_subnet_a.id
}

resource "aws_route_table" "terraform_private_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name        = "handson_tutorial_terraform_private_rtable"
    Env         = "tutorial"
    Product     = "handons"
    Terraform   = true
  }
}

/**
  Creating a private route towards internet
  This uses the nat gateway created above
*/
resource "aws_route" "terraform_private_route" {
  route_table_id = aws_route_table.terraform_private_route_table.id
  nat_gateway_id = aws_nat_gateway.terraform_nat_gtw.id
  destination_cidr_block = "0.0.0.0/0"
}

/**
  Creating a subnet meant to be associated with our private route table
  Making it a private subnet in the AZ index 0 thus AZ A
*/
resource "aws_subnet" "terraform_private_subnet_a" {
  cidr_block = "10.10.10.0/24"
  vpc_id = aws_vpc.terraform_vpc.id
  availability_zone = data.aws_availability_zones.azones.names[0]

  tags = {
    Name        = "handson_tutorial_terraform_private_subnet_a"
    Env         = "tutorial"
    Product     = "handons"
    Terraform   = true
  }
}

/**
  Making private subnet A actually private
  by associating it with the private route table
*/
resource "aws_route_table_association" "terraform_private_subnet_a_rtable_assoc" {
  route_table_id = aws_route_table.terraform_private_route_table.id
  subnet_id = aws_subnet.terraform_private_subnet_a.id
}
/**
  Creating a subnet meant to be associated with our private route table
  Making it a private subnet in the AZ index 0 thus AZ A
*/
resource "aws_subnet" "terraform_private_subnet_b" {
  cidr_block = "10.10.11.0/24"
  vpc_id = aws_vpc.terraform_vpc.id
  availability_zone = data.aws_availability_zones.azones.names[1]

  tags = {
    Name        = "handson_tutorial_terraform_private_subnet_b"
    Env         = "tutorial"
    Product     = "handons"
    Terraform   = true
  }
}

/**
  Making private subnet B actually private
  by associating it with the private route table
*/
resource "aws_route_table_association" "terraform_private_subnet_b_rtable_assoc" {
  route_table_id = aws_route_table.terraform_private_route_table.id
  subnet_id = aws_subnet.terraform_private_subnet_b.id
}
/**
  Creating a subnet meant to be associated with our private route table
  Making it a private subnet in the AZ index 0 thus AZ A
*/
resource "aws_subnet" "terraform_private_subnet_c" {
  cidr_block = "10.10.12.0/24"
  vpc_id = aws_vpc.terraform_vpc.id
  availability_zone = data.aws_availability_zones.azones.names[2]

  tags = {
    Name        = "handson_tutorial_terraform_private_subnet_c"
    Env         = "tutorial"
    Product     = "handons"
    Terraform   = true
  }
}

/**
  Making private subnet C actually private
  by associating it with the private route table
*/
resource "aws_route_table_association" "terraform_private_subnet_c_rtable_assoc" {
  route_table_id = aws_route_table.terraform_private_route_table.id
  subnet_id = aws_subnet.terraform_private_subnet_c.id
}








