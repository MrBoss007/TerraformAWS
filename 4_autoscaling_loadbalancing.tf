#Launch Template, Placement Group, Target Groups,Auto Scaling Groups, Load Balancer
#https://medium.com/@sampark02/application-load-balancer-and-target-group-attachment-using-terraform-d212ce8a38a0#:~:text=Application%20Load%20Balancer%20and%20Target%20group%20attachment%20using,on%20EC2%20Instances%20using%20the%20application%20load%20Balancer.

resource "aws_launch_template" trainging_launch_template{
    image_id = "ami-00c39f71452c08778"
    instance_type = "t3.micro"
    key_name = aws_key_pair.deployer-key1.key_name
    # vpc_security_group_ids = [aws_security_group.training_allow_all.id]
    placement {
        availability_zone = data.aws_availability_zones.available.names[0]
    }

    tags = {
        name = "training_ec2_launch_template"
        uniqueid = "training"
    }
}

resource "aws_placement_group" "Training_PlacementGrp" {
  name     = "Training_PlacementGrp"
  strategy = "partition"
}

resource "aws_autoscaling_group" "training_auto_scaling" {
  availability_zones = ["us-east-1a"]
  placement_group           = aws_placement_group.Training_PlacementGrp.id
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  launch_template {
    id      = aws_launch_template.trainging_launch_template.id
    version = "$Latest"
  }
}