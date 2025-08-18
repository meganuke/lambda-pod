resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion_key"
  public_key = var.public_key
}

resource "aws_instance" "bastion_instance" {
  ami           = "ami-04b3f96fa99d40135" #var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.bastion_key.key_name
  root_block_device {
    volume_size = var.ebs_size
    volume_type = var.ebs_type
    encrypted   = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  iam_instance_profile = aws_iam_instance_profile.bastion_profile.name

  subnet_id       = var.subnet
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id]

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}
