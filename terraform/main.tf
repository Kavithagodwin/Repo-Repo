resource "aws_instance" "devops-2022" {
  ami           = var.ami_id
  instance_type = var.inst_type
  subnet_id   = var.sub_id
  count = 2
  user_data = <<-EOF
  	#! /bin/bash
 	sudo yum install httpd
    	sudo echo "hello terraform" > /var/www/html/index.html
	sudo systemctl enable httpd
        EOF
 

  tags = {
    Name = "kavitha-terraform-$(count.index+1)"
  }
}

resource "aws_security_group" "pradeep_sg" {
  name        = "pradeep_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-06619b9a4856571a7"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["10.10.10.10/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

output "instance_ip" {
    value = ["$(aws_instance.devops-2022.*.public_ip)"]
}
