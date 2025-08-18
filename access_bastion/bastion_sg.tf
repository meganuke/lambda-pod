resource "aws_security_group" "bastion_security_group" {
  name        = "${var.customer_prefix}-bastion-security-group"
  description = "Allow outbound traffic."
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.customer_prefix}-bastion-security-group"
  }
}

resource "aws_security_group_rule" "allowed-ips" {
  count             = length(var.allowed_ips)
  security_group_id = aws_security_group.bastion_security_group.id
  type             = "ingress"
  from_port        = 22 
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks       = [var.allowed_ips[count.index].cidr_block]
  description       = var.allowed_ips[count.index].description
}

