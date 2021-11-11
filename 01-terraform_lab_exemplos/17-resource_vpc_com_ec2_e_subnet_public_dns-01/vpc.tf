resource "aws_vpc" "my_vpc" {
  cidr_block = "172.17.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "TerraformVPCPublicSubnet"
  }
}
variable "ips-subnet" {
  default = {"172.17.0.0/17"=1,"172.17.128.0/18"=2,"172.17.192.0/19"=3,"172.17.224.0/19"=4}
}

resource "aws_subnet" "my_subnet" {
  count = 4
  vpc_id            = aws_vpc.my_vpc.id
  #cidr_block = var.ips-subnet[count.index+1]
  cidr_block = "${keys(var.ips-subnet)[count.index]}"
  availability_zone = "sa-east-1a"

  tags = {
    #Name = "tf-lab-guilhermeagb-subnet"
    Name = "tf-lab-guilhermeagb-subnet${(count.index+1)}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "aws_internet_gateway_terraform"
  }
}

resource "aws_route_table" "rt_terraform" {
  vpc_id = aws_vpc.my_vpc.id

  route = [
      {
        carrier_gateway_id         = ""
        cidr_block                 = "0.0.0.0/0"
        destination_prefix_list_id = ""
        egress_only_gateway_id     = ""
        gateway_id                 = aws_internet_gateway.gw.id
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
    Name = "route_table_terraform"
  }
}

resource "aws_route_table_association" "a" {
  count = 3
  #for_each = toset(["1","2","3"])
  #subnet = "tf-lab-guilhermeagb-subnet${each.key}"
  subnet_id      = aws_subnet.my_subnet[count.index].id
  route_table_id = aws_route_table.rt_terraform.id
}

# resource "aws_network_interface" "my_subnet" {
#   subnet_id           = aws_subnet.my_subnet.id
#   private_ips         = ["172.17.10.100"] # IP definido para instancia
#   # security_groups = ["${aws_security_group.allow_ssh1.id}"]

#   tags = {
#     Name = "primary_network_interface my_subnet"
#   }
# }