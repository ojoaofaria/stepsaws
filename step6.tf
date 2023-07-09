provider "aws" {
  region = "us-east-1"
}

// CÓDIGO LEGADO STEP4
// Route Table com adição da rota TGW Public VPC-A

resource "aws_route_table" "rt-subnet-pb-vpc-a" {
  vpc_id = aws_vpc.VPC-A.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-vpc-a.id
  }

  route {
    cidr_block         = "10.20.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.acme-tgw.id
  }

  route {
    cidr_block         = "10.30.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.acme-tgw.id
  }

  tags = {
    Name = "rt-subnet-pb-vpc-a"
  }
}

resource "aws_route_table_association" "vpca-az1" {
  subnet_id      = aws_subnet.subnet-pb_VPC-A-1a.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-a.id
}

resource "aws_route_table_association" "vpca-az2" {
  subnet_id      = aws_subnet.subnet-pb_VPC-A-1b.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-a.id
}

resource "aws_route_table_association" "vpca-az3" {
  subnet_id      = aws_subnet.subnet-pb_VPC-A-1c.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-a.id
}

// Route Table com adição da rota TGW Public VPC-B

resource "aws_route_table" "rt-subnet-pb-vpc-b" {
  vpc_id = aws_vpc.VPC-B.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-vpc-b.id
  }

  route {
    cidr_block         = "10.10.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.acme-tgw.id
  }

  tags = {
    Name = "rt-subnet-pb-vpc-b"
  }
}

resource "aws_route_table_association" "vpcb-az1" {
  subnet_id      = aws_subnet.subnet-pb_VPC-B-1a.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-b.id
}

resource "aws_route_table_association" "vpcb-az2" {
  subnet_id      = aws_subnet.subnet-pb_VPC-B-1b.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-b.id
}

resource "aws_route_table_association" "vpcb-az3" {
  subnet_id      = aws_subnet.subnet-pb_VPC-B-1c.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-b.id
}

// Route Table com adição da rota TGW Public VPC-C 

resource "aws_route_table" "rt-subnet-pb-vpc-c" {
  vpc_id = aws_vpc.VPC-C.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-vpc-c.id
  }
  route {
    cidr_block         = "10.10.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.acme-tgw.id
  }

  tags = {
    Name = "rt-subnet-pb-vpc-c"
  }
}

resource "aws_route_table_association" "vpcc-az1" {
  subnet_id      = aws_subnet.subnet-pb_VPC-C-1a.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-c.id
}

resource "aws_route_table_association" "vpcc-az2" {
  subnet_id      = aws_subnet.subnet-pb_VPC-C-1b.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-c.id
}

resource "aws_route_table_association" "vpcc-az3" {
  subnet_id      = aws_subnet.subnet-pb_VPC-C-1c.id
  route_table_id = aws_route_table.rt-subnet-pb-vpc-c.id
}

// TGW

resource "aws_ec2_transit_gateway" "acme-tgw" {
  description                     = "Transit Gateway VPC A,B,C"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"

  tags = {
    Name = "acme-tgw"
  }
}

// subnets para o tgw VPCA,  1 em cada VPC

resource "aws_subnet" "tgw-sub-VPC-A-1a" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tgw-sub-VPC-A-1a"
  }
}

resource "aws_subnet" "tgw-sub-VPC-A-1b" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.11.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "tgw-sub-VPC-A-1b"
  }
}

resource "aws_subnet" "tgw-sub-VPC-A-1c" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.12.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "tgw-sub-VPC-A-1c"
  }
}

// subnets para o tgw VPCB, 1 em cada VPC

resource "aws_subnet" "tgw-sub-VPC-B-1a" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tgw-sub-VPC-B-1a"
  }
}

resource "aws_subnet" "tgw-sub-VPC-B-1b" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.11.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "tgw-sub-VPC-B-1b"
  }
}

resource "aws_subnet" "tgw-sub-VPC-B-1c" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.12.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "tgw-sub-VPC-B-1c"
  }
}

// subnets para o tgw VPCC, 1 em cada VPC

resource "aws_subnet" "tgw-sub-VPC-C-1a" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tgw-sub-VPC-C-1a"
  }
}

resource "aws_subnet" "tgw-sub-VPC-C-1b" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.11.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "tgw-sub-VPC-C-1b"
  }
}

resource "aws_subnet" "tgw-sub-VPC-C-1c" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.12.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "tgw-sub-VPC-C-1c"
  }
}

// attachments

resource "aws_ec2_transit_gateway_vpc_attachment" "vpca-attachment" {
  subnet_ids         = [aws_subnet.tgw-sub-VPC-A-1a.id, aws_subnet.tgw-sub-VPC-A-1b.id, aws_subnet.tgw-sub-VPC-A-1c.id]
  transit_gateway_id = aws_ec2_transit_gateway.acme-tgw.id
  vpc_id             = aws_vpc.VPC-A.id
  depends_on         = [aws_subnet.tgw-sub-VPC-A-1a, aws_subnet.tgw-sub-VPC-A-1b, aws_subnet.tgw-sub-VPC-A-1c]

  tags = {
    "Name" = "tgw-attachment-vpca"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpcb-attachment" {
  subnet_ids         = [aws_subnet.tgw-sub-VPC-B-1a.id, aws_subnet.tgw-sub-VPC-B-1b.id, aws_subnet.tgw-sub-VPC-B-1c.id]
  transit_gateway_id = aws_ec2_transit_gateway.acme-tgw.id
  vpc_id             = aws_vpc.VPC-B.id
  depends_on         = [aws_subnet.tgw-sub-VPC-B-1a, aws_subnet.tgw-sub-VPC-B-1b, aws_subnet.tgw-sub-VPC-B-1c]

  tags = {
    "Name" = "tgw-attachment-vpcb"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpcc-attachment" {
  subnet_ids         = [aws_subnet.tgw-sub-VPC-C-1a.id, aws_subnet.tgw-sub-VPC-C-1b.id, aws_subnet.tgw-sub-VPC-C-1c.id]
  transit_gateway_id = aws_ec2_transit_gateway.acme-tgw.id
  vpc_id             = aws_vpc.VPC-C.id
  depends_on         = [aws_subnet.tgw-sub-VPC-C-1a, aws_subnet.tgw-sub-VPC-C-1b, aws_subnet.tgw-sub-VPC-C-1c]

  tags = {
    "Name" = "tgw-attachment-vpcc"
  }
}

// CÓDIGO LEGADO DO STEP 2

// SUBINDO EC2 PARA TESTES


resource "aws_instance" "vm1" {
  ami                         = "ami-06b09bfacae1453cb"
  instance_type               = "t2.micro"
  key_name                    = "acme"
  subnet_id                   = aws_subnet.subnet-pb_VPC-A-1a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vpca-sg.id]
  user_data                   = file("userdata.tpl")

  tags = {
    Name = "VM-acme1"
  }

}

resource "aws_instance" "vm2" {
  ami                         = "ami-06b09bfacae1453cb"
  instance_type               = "t2.micro"
  key_name                    = "acme"
  subnet_id                   = aws_subnet.subnet-pb_VPC-B-1b.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vpcb-sg.id]
  user_data                   = file("userdata.tpl")

  tags = {
    Name = "VM-acme2"
  }

}

resource "aws_instance" "vm3" {
  ami                         = "ami-06b09bfacae1453cb"
  instance_type               = "t2.micro"
  key_name                    = "acme"
  subnet_id                   = aws_subnet.subnet-pb_VPC-C-1c.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vpcc-sg.id]
  user_data                   = file("userdata.tpl")

  tags = {
    Name = "VM-acme3"
  }

}

// SECURITY GROUPS

resource "aws_security_group" "vpca-sg" {
  vpc_id      = aws_vpc.VPC-A.id
  description = "Regras VPCA"
  name        = "VPCA SSH,HTTP"

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
    Name = "vpca-sg"
  }
}

resource "aws_security_group" "vpcb-sg" {
  vpc_id      = aws_vpc.VPC-B.id
  description = "Regras VPCB"
  name        = "VPCB SSH,HTTP"

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
    Name = "vpcb-sg"
  }
}

resource "aws_security_group" "vpcc-sg" {
  vpc_id      = aws_vpc.VPC-C.id
  description = "Regras VPCC"
  name        = "VPCC SSH,HTTP"

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
    Name = "vpcc-sg"
  }
}

// OUTPUTS

output "VM1-PV-IP" {
  value = aws_instance.vm1.private_ip
}

output "VM2-PV-IP" {
  value = aws_instance.vm2.private_ip
}

output "VM3-PV-IP" {
  value = aws_instance.vm3.private_ip
}

output "VM1-DNS" {
    value = aws_instance.vm1.public_dns
}
output "VM2-DNS" {
    value = aws_instance.vm2.public_dns
}
output "VM3-DNS" {
    value = aws_instance.vm3.public_dns
}

// CÓDIGO LEGADO DO STEP 1

// VPC A

resource "aws_vpc" "VPC-A" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-A"
  }
}

resource "aws_subnet" "subnet-pb_VPC-A-1a" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-pb_VPC-A-1a"
  }
}

resource "aws_subnet" "subnet-pv_VPC-A-1a" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-pv_VPC-A-1a"
  }
}

resource "aws_subnet" "subnet-db_VPC-A-1a" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-db_VPC-A-1a"
  }
}

resource "aws_subnet" "subnet-pb_VPC-A-1b" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-pb_VPC-A-1b"
  }
}

resource "aws_subnet" "subnet-pv_VPC-A-1b" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-pv_VPC-A-1b"
  }
}

resource "aws_subnet" "subnet-db_VPC-A-1b" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-db_VPC-A-1b"
  }
}

resource "aws_subnet" "subnet-pb_VPC-A-1c" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.7.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-pb_VPC-A-1c"
  }
}

resource "aws_subnet" "subnet-pv_VPC-A-1c" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.8.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-pv_VPC-A-1c"
  }
}

resource "aws_subnet" "subnet-db_VPC-A-1c" {
  vpc_id            = aws_vpc.VPC-A.id
  cidr_block        = "10.10.9.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-db_VPC-A-1c"
  }
}

// VPC B

resource "aws_vpc" "VPC-B" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-B"
  }
}

resource "aws_subnet" "subnet-pb_VPC-B-1a" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-pb_VPC-B-1a"
  }
}

resource "aws_subnet" "subnet-pv_VPC-B-1a" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-pv_VPC-B-1a"
  }
}

resource "aws_subnet" "subnet-db_VPC-B-1a" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-db_VPC-B-1a"
  }
}

resource "aws_subnet" "subnet-pb_VPC-B-1b" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-pb_VPC-B-1b"
  }
}

resource "aws_subnet" "subnet-pv_VPC-B-1b" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-pv_VPC-B-1b"
  }
}

resource "aws_subnet" "subnet-db_VPC-B-1b" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-db_VPC-B-1b"
  }
}

resource "aws_subnet" "subnet-pb_VPC-B-1c" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.7.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "subnet-pb_VPC-B-1c"
  }
}

resource "aws_subnet" "subnet-pv_VPC-B-1c" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.8.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "subnet-pv_VPC-B-1c"
  }
}

resource "aws_subnet" "subnet-db_VPC-B-1c" {
  vpc_id            = aws_vpc.VPC-B.id
  cidr_block        = "10.20.9.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "subnet-db_VPC-B-1c"
  }
}

// VPC C

resource "aws_vpc" "VPC-C" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-C"
  }
}

resource "aws_subnet" "subnet-pb_VPC-C-1a" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-pb_VPC-C-1a"
  }
}

resource "aws_subnet" "subnet-pv_VPC-C-1a" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-pv_VPC-C-1a"
  }
}

resource "aws_subnet" "subnet-db_VPC-C-1a" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-db_VPC-C-1a"
  }
}

resource "aws_subnet" "subnet-pb_VPC-C-1b" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-pb_VPC-C-1b"
  }
}

resource "aws_subnet" "subnet-pv_VPC-C-1b" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-pv_VPC-C-1b"
  }
}

resource "aws_subnet" "subnet-db_VPC-C-1b" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-db_VPC-C-1b"
  }
}

resource "aws_subnet" "subnet-pb_VPC-C-1c" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.7.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-pb_VPC-C-1c"
  }
}

resource "aws_subnet" "subnet-pv_VPC-C-1c" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.8.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-pv_VPC-C-1c"
  }
}

resource "aws_subnet" "subnet-db_VPC-C-1c" {
  vpc_id            = aws_vpc.VPC-C.id
  cidr_block        = "10.30.9.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "subnet-db_VPC-C-1c"
  }
}

// ROUTE TABLES PV/DB
// VPCA

resource "aws_route_table" "rt-subnet-pv-vpc-a" {
  vpc_id = aws_vpc.VPC-A.id

  tags = {
    Name = "rt-subnet-pv-vpc-a"
  }
}

resource "aws_route_table_association" "vpca-pv-az1" {
  subnet_id      = aws_subnet.subnet-pv_VPC-A-1a.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-a.id
}

resource "aws_route_table_association" "vpca-pv-az2" {
  subnet_id      = aws_subnet.subnet-pv_VPC-A-1b.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-a.id
}

resource "aws_route_table_association" "vpca-pv-az3" {
  subnet_id      = aws_subnet.subnet-pv_VPC-A-1c.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-a.id
}

resource "aws_route_table_association" "vpca-db-az1" {
  subnet_id      = aws_subnet.subnet-db_VPC-A-1a.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-a.id
}

resource "aws_route_table_association" "vpca-db-az2" {
  subnet_id      = aws_subnet.subnet-db_VPC-A-1b.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-a.id
}

resource "aws_route_table_association" "vpca-db-az3" {
  subnet_id      = aws_subnet.subnet-db_VPC-A-1c.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-a.id
}

// VPCB

resource "aws_route_table" "rt-subnet-pv-vpc-b" {
  vpc_id = aws_vpc.VPC-B.id

  tags = {
    Name = "rt-subnet-pv-vpc-b"
  }
}

resource "aws_route_table_association" "vpcb-pv-az1" {
  subnet_id      = aws_subnet.subnet-pv_VPC-B-1a.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-b.id
}

resource "aws_route_table_association" "vpcb-pv-az2" {
  subnet_id      = aws_subnet.subnet-pv_VPC-B-1b.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-b.id
}

resource "aws_route_table_association" "vpcb-pv-az3" {
  subnet_id      = aws_subnet.subnet-pv_VPC-B-1c.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-b.id
}

resource "aws_route_table_association" "vpcb-db-az1" {
  subnet_id      = aws_subnet.subnet-db_VPC-B-1a.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-b.id
}

resource "aws_route_table_association" "vpcb-db-az2" {
  subnet_id      = aws_subnet.subnet-db_VPC-B-1b.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-b.id
}

resource "aws_route_table_association" "vpcb-db-az3" {
  subnet_id      = aws_subnet.subnet-db_VPC-B-1c.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-b.id
}

// VPCC

resource "aws_route_table" "rt-subnet-pv-vpc-c" {
  vpc_id = aws_vpc.VPC-C.id

  tags = {
    Name = "rt-subnet-pv-vpc-c"
  }
}

resource "aws_route_table_association" "vpcc-pv-az1" {
  subnet_id      = aws_subnet.subnet-pv_VPC-C-1a.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-c.id
}

resource "aws_route_table_association" "vpcc-pv-az2" {
  subnet_id      = aws_subnet.subnet-pv_VPC-C-1b.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-c.id
}

resource "aws_route_table_association" "vpcc-pv-az3" {
  subnet_id      = aws_subnet.subnet-pv_VPC-C-1c.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-c.id
}

resource "aws_route_table_association" "vpcc-db-az1" {
  subnet_id      = aws_subnet.subnet-db_VPC-C-1a.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-c.id
}

resource "aws_route_table_association" "vpcc-db-az2" {
  subnet_id      = aws_subnet.subnet-db_VPC-C-1b.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-c.id
}

resource "aws_route_table_association" "vpcc-db-az3" {
  subnet_id      = aws_subnet.subnet-db_VPC-C-1c.id
  route_table_id = aws_route_table.rt-subnet-pv-vpc-c.id
}

// INTERNET GATEWAYS A,B,C

resource "aws_internet_gateway" "igw-vpc-a" {
  vpc_id = aws_vpc.VPC-A.id

  tags = {
    Name = "igw-vpc-a"
  }
}

resource "aws_internet_gateway" "igw-vpc-b" {
  vpc_id = aws_vpc.VPC-B.id

  tags = {
    Name = "igw-vpc-b"
  }
}

resource "aws_internet_gateway" "igw-vpc-c" {
  vpc_id = aws_vpc.VPC-C.id

  tags = {
    Name = "igw-vpc-c"
  }
}