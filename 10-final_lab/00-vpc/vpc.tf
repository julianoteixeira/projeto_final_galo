resource "aws_vpc" "vpc-g4-terraform-01" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-g4-terraform-01"
  }
}

resource "aws_subnet" "sub-g4-terraform-1a" {
  vpc_id            = aws_vpc.vpc-g4-terraform-01.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "sub-g4-terraform-1a"
  }
}

resource "aws_subnet" "sub-g4-terraform-1b" {
  vpc_id            = aws_vpc.vpc-g4-terraform-01.id
  cidr_block        = "10.0.40.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name = "sub-g4-terraform-1b"
  }
}

resource "aws_subnet" "sub-g4-terraform-1c" {
  vpc_id            = aws_vpc.vpc-g4-terraform-01.id
  cidr_block        = "10.0.60.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "sub-g4-terraform-1c"
  }
}

resource "aws_subnet" "sub-g4-terraform-2a-private" {
  vpc_id            = aws_vpc.vpc-g4-terraform-01.id
  cidr_block        = "10.0.80.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "sub-g4-terraform-2a-private"
  }
}


resource "aws_internet_gateway" "gtw-g4-terraform-01" {
  vpc_id = aws_vpc.vpc-g4-terraform-01.id

  tags = {
    Name = "gtw-g4-terraform-01"
  }
}

resource "aws_route_table" "rt-g4-terraform-01" {
  vpc_id = aws_vpc.vpc-g4-terraform-01.id

  route = [
      {
        carrier_gateway_id         = ""
        cidr_block                 = "0.0.0.0/0"
        destination_prefix_list_id = ""
        egress_only_gateway_id     = ""
        gateway_id                 = aws_internet_gateway.gtw-g4-terraform-01.id
        instance_id                = ""
        ipv6_cidr_block            = ""
        local_gateway_id           = ""
        nat_gateway_id             = ""
        network_interface_id       = ""
        transit_gateway_id         = ""
        vpc_endpoint_id            = ""
        vpc_peering_connection_id  = ""
      }
  ]

  tags = {
    Name = "rt-g4-terraform-01"
  }

}

resource "aws_route_table" "rt-g4-terraform-02-private" {
  vpc_id = aws_vpc.vpc-g4-terraform-01.id
   route = [
      {
        carrier_gateway_id         = ""
        cidr_block                 = "0.0.0.0/0"
        destination_prefix_list_id = ""
        egress_only_gateway_id     = ""
        gateway_id                 = ""
        instance_id                = ""
        ipv6_cidr_block            = ""
        local_gateway_id           = ""
        nat_gateway_id             = aws_nat_gateway.nat-g4.id
        network_interface_id       = ""
        transit_gateway_id         = ""
        vpc_endpoint_id            = ""
        vpc_peering_connection_id  = ""
      }
  ]
  tags = {
    Name = "rt-g4-terraform-02-private"
  }
}


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sub-g4-terraform-1a.id
  route_table_id = aws_route_table.rt-g4-terraform-01.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.sub-g4-terraform-1b.id
  route_table_id = aws_route_table.rt-g4-terraform-01.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.sub-g4-terraform-1c.id
  route_table_id = aws_route_table.rt-g4-terraform-01.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.sub-g4-terraform-2a-private.id
  route_table_id = aws_route_table.rt-g4-terraform-02-private.id
}

resource "aws_nat_gateway" "nat-g4" {
  allocation_id = aws_eip.eip-g4.id
  subnet_id     = aws_subnet.sub-g4-terraform-1a.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #depends_on eh opcional
  depends_on = [aws_internet_gateway.gtw-g4-terraform-01]
}

resource "aws_eip" "eip-g4" {
  vpc = true
}

#resource "aws_eip_association" "eip_assoc" {
#  network_interface_id = aws_nat_gateway.nat-g4.network_interface_id
#  allocation_id = aws_eip.eip-g4.id
#}