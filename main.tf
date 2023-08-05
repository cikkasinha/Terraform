resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "Security group for demo EC2 instance"
  tags = {
    Name = "demo-sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo" {
  ami           = "ami-09ba48996007c8b50"  # Replace with your desired AMI ID
  instance_type = "t2.micro"  # Replace with your desired instance type
  key_name      = "chandra"  # Replace with your EC2 key pair name

  tags = {
    Name = "demo"
  }

  vpc_security_group_ids = [
    aws_security_group.demo-sg.id,
  ]
}

