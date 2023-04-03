#VPC, Subnet, 
resource "aws_vpc" "TrainingVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "TrainingSubnet" {
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id     = aws_vpc.TrainingVPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "TrainingSubnet"
  }
}