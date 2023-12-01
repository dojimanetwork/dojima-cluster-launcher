# Resource: EC2 Instance
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"] # Canonical
}
resource "aws_instance" "bastionec2" {
  ami = data.aws_ami.amazon_linux_2.id
  associate_public_ip_address = true
  instance_type = "t2.micro"
  security_groups = [aws_security_group.TF_SG.id]
  subnet_id = module.vpc.public_subnets[0]
  key_name = "TF-key"
  user_data = file("startup.sh")

  tags = {
    Name = "Bastionvalidator"
  }
}

# bastion_security_group
resource "aws_security_group" "TF_SG" {
  name        = "TF-SG"
  description = "TF-SG bastion"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name = "TF-SG"
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "TCP"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_key_pair" "TF_key" {
  key_name   = "TF-key"
  public_key = tls_private_key.rsa.public_key_openssh

}          

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "TF-key"
}

