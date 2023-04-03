#Key Pair, Availability Zones, Security Groups, EBS, EBS Volume Attachment, KMS Key, Key Alias, 


resource "aws_security_group" "training_allow_all" {
  name        = "training_allow_all"
  description = "Allow ALL inbound traffic"
  vpc_id      = aws_vpc.TrainingVPC.id

  ingress {
    description      = "All Traffic"
    from_port        = 443
    to_port          = 443
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

  tags = {
    Name = "Training_SG"
  }
}

resource "aws_key_pair" "deployer-key1" {
  key_name   = "deployer-key1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 karthikeyan.c@outlook.com"
  tags = {
    application="web"
  }
}

resource "aws_kms_key" "TrainingKey" {
  description             = "TrainingKey 1"
  deletion_window_in_days = 10
  tags= {
    name = "Training Key1"
  }
}

resource "aws_kms_alias" "TrainingKey" {
  name          = "alias/TrainingKey-alias1"
  target_key_id = aws_kms_key.TrainingKey.key_id
}

resource "aws_ebs_volume" "trainingebs" {
  availability_zone = data.aws_availability_zones.available.names[0]
  size              = 8
  encrypted  = true
  kms_key_id = aws_kms_key.TrainingKey.arn

  tags = {
    Name = "trainingebs"
  }
}

resource "aws_instance" trainging_ec2{
    ami = "ami-00c39f71452c08778"
    instance_type = "t3.micro"
    key_name = aws_key_pair.deployer-key1.key_name
    subnet_id     = aws_subnet.TrainingSubnet.id
    vpc_security_group_ids = [aws_security_group.training_allow_all.id]
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        name = "training_ec2"
        uniqueid = "training"
    }
}

resource "aws_volume_attachment" "training_ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.trainingebs.id
  instance_id = aws_instance.trainging_ec2.id
}

