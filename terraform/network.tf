resource "aws_vpc" "deployvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
     Name = "deploy-vpc-terraform"
  }
}

resource "aws_subnet" "deploysubnet" {
  vpc_id     = aws_vpc.deployvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "deploy-subnet-terraform"
  }
}

resource "aws_internet_gateway" "deployigateway" {
  vpc_id = aws_vpc.deployvpc.id

  tags = {
    Name = "deploy-i-gateway-terraform"
  }
}

resource "aws_route_table" "deployroutetable" {
  vpc_id = aws_vpc.deployvpc.id

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.deployigateway.id
  }

   tags = {
    Name = "deploy-rount-table-terraform"
  }
}

resource "aws_route_table_association" "deployroutetassociation" {
  subnet_id      = aws_subnet.deploysubnet.id
  route_table_id = aws_route_table.deployroutetable.id
}

