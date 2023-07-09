
/*
  FOI CRIADO A VPC D COMPLETA, COM SUBNNET,RT,SG,IGW,VM E PEERING.
  O OUTPUT DA VM4 FOI COLOCADO NO CÓDIGO LEGADO, APENAS PARA ORGANIZAÇÃO.
*/

// VPC D

resource "aws_vpc" "VPC-D" {
  cidr_block           = "10.40.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-D"
  }
}

// SUBNET 1 - VPC D
resource "aws_subnet" "subnet-pb_VPC-D-1a" {
  vpc_id            = aws_vpc.VPC-D.id
  cidr_block        = "10.40.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-pb_VPC-D-1a"
  }
}

# resource "aws_route" "rota-vpca" {
#   route_table_id            = aws_route_table.rt-subnet-pb-vpc-d.id
#   destination_cidr_block    = "10.10.0.0/16"
#   transit_gateway_id        = aws_ec2_transit_gateway.acme-tgw2.id
#   depends_on                = [aws_route_table.rt-subnet-pb-vpc-d, aws_ec2_transit_gateway.acme-tgw2]
# }

// ROUTE TABLE VPCD

resource "aws_route_table" "rt-subnet-pb-vpc-d" {
  vpc_id = aws_vpc.VPC-D.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-vpc-d.id
  }

  tags = {
    Name = "rt-subnet-pb-vpc-d"
  }
}

resource "aws_route_table_association" "vpcd-az1" {
  subnet_id = aws_subnet.subnet-pb_VPC-D-1a.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-d.id
}

// IGW

resource "aws_internet_gateway" "igw-vpc-d" {
  vpc_id = aws_vpc.VPC-D.id

  tags = {
    Name = "igw-vpc-d"
  }
}

// TGW2

resource "aws_ec2_transit_gateway" "acme-tgw2" {
  description                     = "Transit Gateway VPC D"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"

  tags = {
    Name = "acme-tgw2"
  }
}

// subnets para o tgw VPCD

resource "aws_subnet" "tgw-sub-VPC-D-1a" {
  vpc_id            = aws_vpc.VPC-D.id
  cidr_block        = "10.40.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tgw-sub-VPC-D-1a"
  }
}

resource "aws_route_table_association" "tgw-vpcd-az1" {
  subnet_id      = aws_subnet.tgw-sub-VPC-D-1a.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-d.id
}

// attachment

resource "aws_ec2_transit_gateway_vpc_attachment" "vpcd-attachment" {
  subnet_ids         = [aws_subnet.tgw-sub-VPC-D-1a.id]
  transit_gateway_id = aws_ec2_transit_gateway.acme-tgw2.id
  vpc_id             = aws_vpc.VPC-D.id
  depends_on         = [aws_subnet.tgw-sub-VPC-D-1a]

  tags = {
    "Name" = "tgw-attachment-vpcd"
  }
}

// TGW PEERING

resource "aws_ec2_transit_gateway_route_table" "rt_tgw2" {
  transit_gateway_id = aws_ec2_transit_gateway.acme-tgw2.id
}
    
resource "aws_ec2_transit_gateway_route_table_association" "tgw2_route_table_association" {
  transit_gateway_route_table_id  = aws_ec2_transit_gateway_route_table.rt_tgw2.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcd-attachment.id
}

// Validação

/*

  // EC2

  resource "aws_instance" "vm4" {
    ami                         = "ami-06b09bfacae1453cb"
    instance_type               = "t2.micro"
    key_name                    = "acme"
    subnet_id                   = aws_subnet.subnet-pb_VPC-D-1a.id
    associate_public_ip_address = true
    vpc_security_group_ids      = [aws_security_group.vpcd-sg.id]
    user_data                   = file("userdata.tpl")

    tags = {
      Name = "VM-acme4"
    }

  }

  // output

  output "VM4-PV-IP" {
      value = aws_instance.vm4.private_ip
  }

  output "VM4-PV-IP" {
      value = aws_instance.vm4.public_dns
  }

  // SG

  resource "aws_security_group" "vpcd-sg" {
      vpc_id = aws_vpc.VPC-D.id
      description = "Regras VPCD"
      name = "VPCD SSH,HTTP"
    
    ingress {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "vpcd-sg"
    }
  }

*/