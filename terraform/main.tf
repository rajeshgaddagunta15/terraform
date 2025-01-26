# in commit main.tf file didnt update so re pushing again
# Specify the provider
provider "aws" {
  region = "ap-south-1" # Mumbai region
}

# Define a security group
resource "aws_security_group" "example_sg" {
  name_prefix = "example-sg-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere; restrict it as per your needs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-04b4f1a9cf54c11d0" # Replace with a valid Mumbai AMI ID
  instance_type = "t2.micro"             # Modify as needed
  key_name      = "terralogin"   # Replace with your key pair name

  security_groups = [aws_security_group.example_sg.name]

  tags = {
    Name = "example-instance"
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}

# Output the instance ID
output "instance_id" {
  value = aws_instance.example.id
}