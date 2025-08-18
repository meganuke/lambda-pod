resource "aws_eip" "bastion_eip" {
  count = var.publicly_accessible ? 1 : 0

  domain = "vpc"
}

resource "aws_eip_association" "bastion_eip_association" {
  count = var.publicly_accessible ? 1 : 0

  instance_id   = aws_instance.bastion_instance.id
  allocation_id = aws_eip.bastion_eip[0].id

  depends_on = [ aws_instance.bastion_instance ]
}
