# Designate a cloud provider, region, and credentials
provider "aws" {
  region  = "us-east-1"
  profile = "personal"
}

# Provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity-T2" {
  ami           = "ami-0aa7d40eeae50c9a9" # Amazon Linux 2 AMI (HVM), SSD
  instance_type = "t2.micro"
  count         = 4

  tags = {
    Name = "Udacity T2"
  }
}

# Provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity-M4" {
  ami           = "ami-0aa7d40eeae50c9a9" # Amazon Linux 2 AMI (HVM), SSD
  instance_type = "m4.large"
  count         = 2

  tags = {
    Name = "Udacity M4"
  }
}
